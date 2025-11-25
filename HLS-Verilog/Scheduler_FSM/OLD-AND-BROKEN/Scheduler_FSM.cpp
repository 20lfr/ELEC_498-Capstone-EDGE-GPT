#include "Scheduler_FSM.hpp"
#include <cstdint>


// ------------------------------------------------------------
// Scheduler FSM
// ------------------------------------------------------------
void scheduler_hls(
    // ------------------------------------------------------------
    // AXI4-Lite CONTROL INTERFACE (PS → PL) - IE the Control Memory Address Interface
    // ------------------------------------------------------------
    bool cntrl_start,               // [INPUT]  From AXI-Lite: "start inference" bit
    bool cntrl_reset_n,             // [INPUT]  Active-low synchronous reset
    uint32_t  &cntrl_layer_idx,     // [OUTPUT] Current layer index mirrored into control mem
    
    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,      // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,       // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready,     // [OUTPUT] s_axis_in_tready

    // ------------------------------------------------------------
    // WEIGHT LOADER (AXI4-FULL MASTER via DMA)
    // ------------------------------------------------------------
    bool wl_ready,           // [INPUT]  Weight loader ready for a new request
    bool &wl_start,          // [OUTPUT] Start weight load DMA
    int  &wl_addr_sel,       // [OUTPUT] Select which matrix/tile (Q, K, V, K cache, V cache, WO, W1...)
    int  &wl_layer,          // [OUTPUT] Layer index for DMA
    int  &wl_head,           // [OUTPUT] Head index for DMA (or -1 for non-head ops)
    int  &wl_tile,           // [OUTPUT] Tile index for large matrices
    bool dma_done,           // [INPUT]  DMA transfer completed (single-cycle pulse)

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,      // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,       // [INPUT]  Compute operation finished (one-shot)
    bool requant_ready,      // [INPUT]  Requant engine ready
    bool requant_done,       // [INPUT]  Requant engine operation done
    bool &compute_start,     // [OUTPUT] Trigger compute engine
    int  &compute_op,        // [OUTPUT] What operation to run (QKV, AttnScore, Softmax...)
    bool &requant_start,     // [OUTPUT] Trigger requant engine
    int  &requant_op,        // [OUTPUT] Requant operation to run

    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,       // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,      // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,        // [INPUT]  Stream-out finished entire sequence

    // ------------------------------------------------------------
    // GLOBAL COMPLETION FLAG
    // ------------------------------------------------------------
    bool &done,              // [OUTPUT] Inference pipeline fully complete

    // ------------------------------------------------------------
    // DEBUG STATE OUTPUT
    // ------------------------------------------------------------
    SchedState &STATE
) {
    // Removed pipelining while debugging static-state timing; revisit once functionality is verified.
    static SchedState st;
#pragma HLS reset variable=st
    static int        layer_idx; cntrl_layer_idx = layer_idx;
#pragma HLS reset variable=layer_idx
    static int        head_group;
#pragma HLS reset variable=head_group
    static bool       head_reset;
#pragma HLS reset variable=head_reset
    static bool       embed_wait;
#pragma HLS reset variable=embed_wait

    // Output projection context
    static int  wo_tile;
#pragma HLS reset variable=wo_tile
    static bool wo_dma_busy;
#pragma HLS reset variable=wo_dma_busy
    static bool wo_comp_busy;
#pragma HLS reset variable=wo_comp_busy

    // Residual/LN waits
    static bool resid0_wait;
#pragma HLS reset variable=resid0_wait
    static bool ln0_wait;
#pragma HLS reset variable=ln0_wait
    static bool resid1_wait;
#pragma HLS reset variable=resid1_wait
    static bool ln1_wait;
#pragma HLS reset variable=ln1_wait

    // FFN context
    enum class FfnPhase : uint8_t { W1 = 0, ACT, W2, DONE }; // Internal Steps for FFN
    static FfnPhase ffn_phase;
#pragma HLS reset variable=ffn_phase
    static int      ffn_tile;
#pragma HLS reset variable=ffn_tile
    static bool     ffn_dma_busy;
#pragma HLS reset variable=ffn_dma_busy
    static bool     ffn_comp_busy;
#pragma HLS reset variable=ffn_comp_busy
    static bool     ffn_act_busy;
#pragma HLS reset variable=ffn_act_busy

    // Stream context
    enum class StreamPhase : uint8_t { DEQUANT = 0, LOGITS, STREAM, COMPLETE }; // Internal state for OUTPUT AXI stream steps
    static StreamPhase stream_phase;
#pragma HLS reset variable=stream_phase
    static int         logit_tile;
#pragma HLS reset variable=logit_tile
    static bool        logit_dma_busy;
#pragma HLS reset variable=logit_dma_busy
    static bool        logit_comp_busy;
#pragma HLS reset variable=logit_comp_busy
    static bool        dequant_busy;
#pragma HLS reset variable=dequant_busy
    static bool        axis_stream_busy;
#pragma HLS reset variable=axis_stream_busy

    static bool concat_busy;
#pragma HLS reset variable=concat_busy

    static HeadCtx head_ctx[NUM_HEADS];
#pragma HLS reset variable=head_ctx
    static HeadResources head_res;      //Manages Resources across multiple parellel heads
#pragma HLS reset variable=head_res

    const bool reset = !cntrl_reset_n;
    if (reset) {
        st         = S_IDLE;
        layer_idx  = 0;
        head_group = 0;
        head_reset = true;
        embed_wait = false;

        wo_tile      = 0;
        wo_dma_busy  = false;
        wo_comp_busy = false;

        resid0_wait = false;
        ln0_wait    = false;
        resid1_wait = false;
        ln1_wait    = false;

        ffn_phase     = FfnPhase::W1;
        ffn_tile      = 0;
        ffn_dma_busy  = false;
        ffn_comp_busy = false;
        ffn_act_busy  = false;

        stream_phase     = StreamPhase::DEQUANT;
        logit_tile       = 0;
        logit_dma_busy   = false;
        logit_comp_busy  = false;
        dequant_busy     = false;
        axis_stream_busy = false;

        concat_busy = false;

        for (int i = 0; i < NUM_HEADS; ++i) {
#pragma HLS UNROLL
            init_head_ctx(head_ctx[i], -1);
        }
        head_res = HeadResources{};
    }

    // Default outputs
    axis_in_ready = 0;
    wl_start      = 0;
    wl_addr_sel   = 0;
    wl_layer      = layer_idx;
    wl_head       = 0;
    wl_tile       = 0;
    compute_start = 0;
    compute_op    = CMP_NONE;
    requant_start = 0;
    requant_op    = RQ_NONE;
    stream_start  = 0;
    done          = 0;

    if (reset) {
        STATE = st;
        return;
    }

    switch (st) {
        case S_IDLE:
            // If in IDLING STATE, and start signal comes from AXI-lite (ie shared control mem address), then start inference
            if (cntrl_start) {
                st          = S_START;
                layer_idx   = 0;
                head_group  = 0;
                head_reset  = true;
                embed_wait  = false;
                stream_phase= StreamPhase::DEQUANT;
            }
            break;

        case S_START:
            axis_in_ready = 1;
            if (cntrl_start)
                embed_wait = true;
            if (embed_wait && axis_in_valid && axis_in_last) {
                embed_wait = false;
                st         = S_LAYER_COUNT;
            }
            break;

        case S_LAYER_COUNT:
            head_group = 0;
            head_reset = true;
            head_res   = HeadResources{};
            st         = S_ATTENTION_HEADS;
            break;

        case S_ATTENTION_HEADS:
            // By running "run_head_group" we are initializing each head group, until i*head_group == NUM_HEADS
            if (run_head_group(
                    head_ctx,
                    head_res,
                    layer_idx,
                    head_group,
                    head_reset,
                    wl_ready,
                    dma_done,
                    compute_ready,
                    compute_done,
                    requant_ready,
                    requant_done,
                    wl_start,
                    wl_addr_sel,
                    wl_layer,
                    wl_head,
                    wl_tile,
                    compute_start,
                    compute_op,
                    requant_start,
                    requant_op)) {
                head_group++;
                head_reset = true;
                if (head_group >= NUM_HEAD_GROUPS)
                    st = S_HEAD_CONCAT;
            } else {
                head_reset = false;
            }
            break;

        case S_HEAD_CONCAT:
            if (!concat_busy && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_CONCAT;
                concat_busy   = true;
            } else if (concat_busy && compute_done) {
                concat_busy = false;
                st          = S_OUT_PROJECTION;
                wo_tile     = 0;
                wo_dma_busy = false;
                wo_comp_busy= false;
            }
            break;

        case S_OUT_PROJECTION:
            if (wo_tile >= NUM_WO_TILES) {
                resid0_wait = false; // entering residual stage with clean wait flag
                st = S_RES_ADD_1;
                break;
            }
            if (!wo_dma_busy && wl_ready) {
                wl_start    = 1;
                wl_addr_sel = DMASEL_WO;
                wl_head     = -1;
                wl_tile     = wo_tile;
                wo_dma_busy = true;
            } else if (wo_dma_busy && dma_done) {
                wo_dma_busy = false;
                wo_comp_busy= true;
            }
            if (wo_comp_busy && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_OUT_PROJ;
                wo_comp_busy  = false;
                wo_tile++;
            }
            break;

        case S_RES_ADD_1:
            if (!resid0_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_RESID0;
                resid0_wait   = true;
            } else if (resid0_wait && compute_done) {
                resid0_wait = false;
                ln0_wait    = false; // ensure LN state always starts idle
                st          = S_LAYER_NORM_1;
            }
            break;

        case S_LAYER_NORM_1:
            if (!ln0_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_LN0;
                ln0_wait      = true;
            } else if (ln0_wait && compute_done) {
                ln0_wait  = false;
                st        = S_FFN;
                ffn_phase = FfnPhase::W1;
                ffn_tile  = 0;
                ffn_dma_busy  = false;
                ffn_comp_busy = false;
                ffn_act_busy  = false;
            }
            break;

        case S_FFN:
            if (ffn_phase == FfnPhase::DONE) {
                resid1_wait = false; // prep residual block handshake
                st = S_RES_ADD_2;
                break;
            }
            if (ffn_phase == FfnPhase::W1) {
                if (ffn_dma_busy && dma_done) {
                    ffn_dma_busy  = false;
                    ffn_comp_busy = true;
                }
                const bool w1_tiles_remaining = (ffn_tile < NUM_W1_TILES);
                if (w1_tiles_remaining && !ffn_dma_busy && wl_ready) {
                    wl_start     = 1;
                    wl_addr_sel  = DMASEL_W1;
                    wl_head      = -1;
                    wl_tile      = ffn_tile;
                    ffn_dma_busy = true;
                }
                if (ffn_comp_busy && compute_ready) {
                    compute_start  = 1;
                    compute_op     = CMP_FFN_W1;
                    ffn_comp_busy  = false;
                    ffn_tile++;
                }
                const bool w1_complete = (ffn_tile >= NUM_W1_TILES) && !ffn_dma_busy && !ffn_comp_busy;
                if (w1_complete) {
                    ffn_phase    = FfnPhase::ACT;
                    ffn_act_busy = false;
                } // else: waiting for this phase to complete (loop warning - may loop forever if w1_complete is not implemented properly)
            } else if (ffn_phase == FfnPhase::ACT) {
                if (!ffn_act_busy && compute_ready) {
                    compute_start = 1;
                    compute_op    = CMP_FFN_ACT;
                    ffn_act_busy  = true;
                } else if (ffn_act_busy && compute_done) {
                    ffn_act_busy = false;
                    ffn_phase    = FfnPhase::W2;
                    ffn_tile     = 0;
                }
            } else if (ffn_phase == FfnPhase::W2) {
                if (ffn_dma_busy && dma_done) {
                    ffn_dma_busy  = false;
                    ffn_comp_busy = true;
                }
                const bool w2_tiles_remaining = (ffn_tile < NUM_W2_TILES);
                if (w2_tiles_remaining && !ffn_dma_busy && wl_ready) {
                    wl_start     = 1;
                    wl_addr_sel  = DMASEL_W2;
                    wl_head      = -1;
                    wl_tile      = ffn_tile;
                    ffn_dma_busy = true;
                }
                if (ffn_comp_busy && compute_ready) {
                    compute_start  = 1;
                    compute_op     = CMP_FFN_W2;
                    ffn_comp_busy  = false;
                    ffn_tile++;
                }
                const bool w2_complete = (ffn_tile >= NUM_W2_TILES) && !ffn_dma_busy && !ffn_comp_busy;
                if (w2_complete) {
                    ffn_phase = FfnPhase::DONE;
                }
            }
            break;
        case S_RES_ADD_2:
            if (!resid1_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_RESID1;
                resid1_wait   = true;
            } else if (resid1_wait && compute_done) {
                resid1_wait = false;
                ln1_wait    = false; // next LN stage should see idle wait flag
                st          = S_LAYER_NORM_2;
            }
            break;

        case S_LAYER_NORM_2:
            if (!ln1_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_LN1;
                ln1_wait      = true;
            } else if (ln1_wait && compute_done) {
                ln1_wait   = false;
                resid0_wait = false;
                ln0_wait    = false;
                resid1_wait = false;
                st         = S_LOOP_CHECK;
            }
            break;

        case S_LOOP_CHECK:
            if (layer_idx + 1 < NUM_LAYERS) {
                layer_idx++;
                st = S_LAYER_COUNT;
            } else {
                st            = S_STREAM_OUT;
                stream_phase  = StreamPhase::DEQUANT;
                logit_tile    = 0;
                logit_dma_busy= false;
                logit_comp_busy = false;
                dequant_busy  = false;
                axis_stream_busy = false;
            }
            break;

        case S_STREAM_OUT:
            if (stream_phase == StreamPhase::DEQUANT) {
                if (!dequant_busy && compute_ready) {
                    compute_start = 1;
                    compute_op    = CMP_DEQUANT;
                    dequant_busy  = true;
                } else if (dequant_busy && compute_done) {
                    dequant_busy = false;
                    stream_phase = StreamPhase::LOGITS;
                }
            } else if (stream_phase == StreamPhase::LOGITS) {
                if (logit_tile >= NUM_LOGIT_TILES) {
                    stream_phase = StreamPhase::STREAM;
                } else if (!logit_dma_busy && wl_ready) {
                    wl_start        = 1;
                    wl_addr_sel     = DMASEL_WLOGIT;
                    wl_head         = -1;
                    wl_tile         = logit_tile;
                    logit_dma_busy  = true;
                } else if (logit_dma_busy && dma_done) {
                    logit_dma_busy  = false;
                    logit_comp_busy = true;
                }
                if (logit_comp_busy && compute_ready) {
                    compute_start   = 1;
                    compute_op      = CMP_LOGITS;
                    logit_comp_busy = false;
                    logit_tile++;
                }
            } else if (stream_phase == StreamPhase::STREAM) {
                if (!axis_stream_busy && stream_ready) {
                    stream_start    = 1;
                    axis_stream_busy= true;
                } else if (axis_stream_busy && stream_done) {
                    axis_stream_busy = false;
                    stream_phase     = StreamPhase::COMPLETE;
                }
            } else {
                done = 1;
                if (!cntrl_start)
                    st = S_IDLE;
            }
            break;
    }

    STATE = st;
}

// ------------------------------------------------------------
// Head processing helpers
// ------------------------------------------------------------
bool run_head_group(
    HeadCtx (&head_ctx_ref)[NUM_HEADS],
    HeadResources &res,
    int   layer_idx,       // [INPUT] Layer index that every head context should be aligned to
    int   group_idx,       // [INPUT] Which head group (batch of parallel heads) to service
    bool  reset_resources, // [INPUT] Request to clear shared resource tracking before use
    bool  wl_ready,        // [INPUT] Weight loader readiness to accept a new DMA command
    bool  dma_done,        // [INPUT] Global DMA completion pulse for whichever head owns it
    bool  compute_ready,   // [INPUT] Compute pipeline idle indicator
    bool  compute_done,    // [INPUT] Compute pipeline completion pulse
    bool  requant_ready,   // [INPUT] Requant pipeline ready indicator
    bool  requant_done,    // [INPUT] Requant completion pulse
    bool &wl_start,        // [OUTPUT] Start signal sent to the DMA controller
    int  &wl_addr_sel,     // [OUTPUT] Encoded DMA selector describing which buffer to load/store
    int  &wl_layer,        // [OUTPUT] Layer index tagged onto DMA requests
    int  &wl_head,         // [OUTPUT] Head index associated with the DMA launch
    int  &wl_tile,         // [OUTPUT] Tile identifier for tiled DMA requests
    bool &compute_start,   // [OUTPUT] Kick-off bit for the compute engine
    int  &compute_op,      // [OUTPUT] Encoded operation describing what the compute engine should do
    bool &requant_start,   // [OUTPUT] Kick-off bit for the requant engine
    int  &requant_op       // [OUTPUT] Encoded operation describing what the requant engine should do
) {
#pragma HLS INLINE off
    if (reset_resources) {
        res = HeadResources{}; // Re-init res if reset is asserted
    }

    if (dma_done && res.dma_busy) {
        HeadCtx &ctx = head_ctx_ref[res.dma_owner];
        ctx.dma_done_flag = true;
        res.dma_busy      = false;
    }
    if (compute_done && res.comp_busy) {
        HeadCtx &ctx = head_ctx_ref[res.comp_owner];
        ctx.comp_done_flag = true;
        res.comp_busy      = false;
    }
    if (requant_done && res.requant_busy) {
        HeadCtx &ctx = head_ctx_ref[res.requant_owner];
        ctx.requant_done_flag = true;
        res.requant_busy      = false;
    }

    const int head_base = group_idx * HEADS_PARALLEL;   // Calculate the Head "Group" we are currently in

    // This is the the return conditional later to make vitis Synthesize into RTL easier
    bool group_finished = true; // init the group finished variable
    bool resources_idle = (!res.dma_busy && !res.comp_busy && !res.requant_busy);

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) { // This will create HEADS_PARALLEL number of seperate headed computation runs
#pragma HLS UNROLL
        const int head_idx = head_base + lane;
        if (head_idx >= NUM_HEADS)
            continue;

        HeadCtx &ctx = head_ctx_ref[head_idx];
        if (ctx.layer_stamp != layer_idx) {
            init_head_ctx(ctx, layer_idx);
        }

        if (ctx.phase != HeadPhase::DONE) {
            group_finished = false;
            drive_head_phase(
                ctx,
                head_idx,
                layer_idx,
                wl_ready,
                compute_ready,
                requant_ready,
                res,
                wl_start,
                wl_addr_sel,
                wl_layer,
                wl_head,
                wl_tile,
                compute_start,
                compute_op,
                requant_start,
                requant_op);
        }
    }

    if (!group_finished) return false;
    return group_finished && resources_idle;
}

void init_head_ctx(
    HeadCtx &ctx, // [OUTPUT] Head context object that needs to be reinitialized
    int layer_idx // [INPUT] Layer index that seeds the context's stamp
) {
#pragma HLS INLINE
    ctx.layer_stamp    = layer_idx;
    ctx.phase          = HeadPhase::Q;
    ctx.wait_dma       = false;
    ctx.wait_comp      = false;
    ctx.wait_requant   = false;
    ctx.dma_done_flag  = false;
    ctx.comp_done_flag = false;
    ctx.requant_done_flag = false;
}

void drive_head_phase(
    HeadCtx         &ctx,           // [BOTH] Per-head FSM state that gets read/updated
    int             head_idx,       // [INPUT] Absolute head index being serviced
    int             layer_idx,      // [INPUT] Layer discriminator forwarded to DMA requests
    bool            wl_ready,       // [INPUT] Weight loader ready flag for DMA
    bool            compute_ready,  // [INPUT] Compute pipeline idle flag
    bool            requant_ready,  // [INPUT] Requant pipeline ready flag
    HeadResources   &res,           // [BOTH] Shared resource bookkeeping for this head group
    bool            &wl_start,      // [OUTPUT] DMA start pulse driven toward the weight loader
    int             &wl_addr_sel,   // [OUTPUT] Selects which tensor the DMA should service
    int             &wl_layer,      // [OUTPUT] Exposes layer index to the DMA
    int             &wl_head,       // [OUTPUT] Provides the head index to the DMA
    int             &wl_tile,       // [OUTPUT] Encodes tile index for multi-tile transfers
    bool            &compute_start, // [OUTPUT] Compute start handshake toward MAC array
    int             &compute_op,    // [OUTPUT] Operation ID for the compute engine
    bool            &requant_start, // [OUTPUT] Requant start handshake
    int             &requant_op     // [OUTPUT] Operation ID for the requant engine
) {
#pragma HLS INLINE
    switch (ctx.phase) {
        case HeadPhase::Q:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_WQ,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_Q,
                                       compute_ready, compute_start, compute_op)) {
                    // wait
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::K;
            }
            break;

        case HeadPhase::K:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_WK,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_K,
                                       compute_ready, compute_start, compute_op)) {
                    // wait
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::K_REQUANT;
            }
            break;

        case HeadPhase::K_REQUANT:
            if (!ctx.wait_requant) {
                if (start_head_requant(res, head_idx, RQ_K,
                                       requant_ready, requant_start, requant_op)) {
                    ctx.wait_requant = true;
                }
            } else if (ctx.requant_done_flag) {
                ctx.requant_done_flag = false;
                ctx.wait_requant     = false;
                ctx.phase            = HeadPhase::K_WRITEBACK;
            }
            break;

        case HeadPhase::K_WRITEBACK:
            if (!ctx.wait_dma) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_K_WRITE,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.phase         = HeadPhase::V;
            }
            break;

        case HeadPhase::V:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_WV,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_V,
                                       compute_ready, compute_start, compute_op)) {
                    // wait
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::V_REQUANT;
            }
            break;

        case HeadPhase::V_REQUANT:
            if (!ctx.wait_requant) {
                if (start_head_requant(res, head_idx, RQ_V,
                                       requant_ready, requant_start, requant_op)) {
                    ctx.wait_requant = true;
                }
            } else if (ctx.requant_done_flag) {
                ctx.requant_done_flag = false;
                ctx.wait_requant     = false;
                ctx.phase            = HeadPhase::V_WRITEBACK;
            }
            break;

        case HeadPhase::V_WRITEBACK:
            if (!ctx.wait_dma) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_V_WRITE,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.phase         = HeadPhase::REQUANT_Q;
            }
            break;

        case HeadPhase::REQUANT_Q:
            if (!ctx.wait_requant) {
                if (start_head_requant(res, head_idx, RQ_Q,
                                       requant_ready, requant_start, requant_op)) {
                    ctx.wait_requant = true;
                }
            } else if (ctx.requant_done_flag) {
                ctx.requant_done_flag = false;
                ctx.wait_requant     = false;
                ctx.phase            = HeadPhase::ATT_SCORES;
            }
            break;

        case HeadPhase::ATT_SCORES:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_CTX_K,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_ATT_SCORES,
                                       compute_ready, compute_start, compute_op)) {
                    // wait
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::VALUE_SCALE_CLAMP;
            }
            break;

        case HeadPhase::VALUE_SCALE_CLAMP:
            // Use QK quant scale (g_ctrl_regs.scale_q) to scale + clamp raw attention scores.
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_VALUE_SCALE,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::ATT_SOFTMAX;
            }
            break;

        case HeadPhase::ATT_SOFTMAX:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_SOFTMAX,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::ATT_VALUE;
            }
            break;

        case HeadPhase::ATT_VALUE:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_CTX_V,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_ATT_VALUE,
                                       compute_ready, compute_start, compute_op)) {
                    // wait
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::REQUANT2;
            }
            break;

        case HeadPhase::REQUANT2:
            if (!ctx.wait_requant) {
                if (start_head_requant(res, head_idx, RQ_FINAL,
                                       requant_ready, requant_start, requant_op)) {
                    ctx.wait_requant = true;
                }
            } else if (ctx.requant_done_flag) {
                ctx.requant_done_flag = false;
                ctx.wait_requant     = false;
                ctx.phase            = HeadPhase::DONE;
            }
            break;

        case HeadPhase::DONE:
        default:
            break;
    }
}




bool start_head_dma(
    HeadResources &res, // [BOTH] Shared DMA bookkeeping tracking ownership/busy flags
    int   head_idx,     // [INPUT] Head issuing the DMA request
    int   layer_idx,    // [INPUT] Layer index paired with the DMA request
    DmaSel sel,         // [INPUT] Enumerated selection of which buffer/tensor to access
    bool  wl_ready,     // [INPUT] Weight loader DMA interface readiness
    bool &wl_start,     // [OUTPUT] Pulse that actually fires the DMA engine
    int  &wl_addr_sel,  // [OUTPUT] Encoded DMA selector forwarded to hardware
    int  &wl_layer,     // [OUTPUT] Layer index accompanying the transfer
    int  &wl_head,      // [OUTPUT] Head index driving the request
    int  &wl_tile       // [OUTPUT] Tile identifier (0 for untiled transfers)
) {
#pragma HLS INLINE
    if (res.dma_busy || !wl_ready || wl_start)
        return false; // need to keep waiting
    wl_start    = 1;
    wl_addr_sel = static_cast<int>(sel);
    wl_layer    = layer_idx;
    wl_head     = head_idx;
    wl_tile     = 0;
    res.dma_busy  = true;
    res.dma_owner = head_idx;
    res.dma_tag   = sel;
    return true;
}




bool start_head_compute(
    HeadResources &res,     // [BOTH] Shared compute resource ownership/busy tracker
    int   head_idx,         // [INPUT] Head requesting compute time
    ComputeOp op,           // [INPUT] Operation identifier the compute core must execute
    bool  compute_ready,    // [INPUT] Compute engine idle status
    bool &compute_start,    // [OUTPUT] Pulse that triggers compute launch
    int  &compute_op        // [OUTPUT] Encoded opcode driven into the compute core
) {
#pragma HLS INLINE
    if (res.comp_busy || !compute_ready || compute_start)
        return false;
    compute_start  = 1;
    compute_op     = op;
    res.comp_busy  = true;
    res.comp_owner = head_idx;
    res.comp_tag   = op;
    return true;
}

bool start_head_requant(
    HeadResources &res,     // [BOTH] Requant resource tracker
    int   head_idx,         // [INPUT] Head requesting requant operation
    RequantOp op,           // [INPUT] Requant operation identifier
    bool  requant_ready,    // [INPUT] Requant engine idle status
    bool &requant_start,    // [OUTPUT] Pulse that triggers requant launch
    int  &requant_op        // [OUTPUT] Encoded opcode driven into the requant engine
) {
#pragma HLS INLINE
    if (res.requant_busy || !requant_ready || requant_start)
        return false;
    requant_start   = 1;
    requant_op      = op;
    res.requant_busy  = true;
    res.requant_owner = head_idx;
    res.requant_tag   = op;
    return true;
}