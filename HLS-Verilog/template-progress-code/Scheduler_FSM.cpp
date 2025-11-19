#include "Scheduler_FSM.hpp"
#include <cstdint>

HeadCtx g_head_ctx[NUM_HEADS];

// ------------------------------------------------------------
// Scheduler FSM
// ------------------------------------------------------------
void scheduler_hls(
    // ------------------------------------------------------------
    // AXI4-Lite CONTROL INTERFACE (PS → PL) - IE the Control Memory Address Interface
    // ------------------------------------------------------------
    bool cntrl_start,               // [INPUT]  From AXI-Lite: "start inference" bit
    bool cntrl_reset_n,             // [INPUT]  Active-low synchronous reset
    uint32_t  &cntrl_layer_idx,          // [OUTPUT] Current layer index mirrored into control mem

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
    int  &wl_addr_sel,       // [OUTPUT] Select which matrix/tile (QKV, K, V, WO, W1...)
    int  &wl_layer,          // [OUTPUT] Layer index for DMA
    int  &wl_head,           // [OUTPUT] Head index for DMA (or -1 for non-head ops)
    int  &wl_tile,           // [OUTPUT] Tile index for large matrices
    bool dma_done,           // [INPUT]  DMA transfer completed (single-cycle pulse)

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,      // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,       // [INPUT]  Compute operation finished (one-shot)
    bool &compute_start,     // [OUTPUT] Trigger compute engine
    int  &compute_op,        // [OUTPUT] What operation to run (QKV, AttnScore, Softmax...)

    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,       // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start,      // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,        // [INPUT]  Stream-out finished entire sequence

    // ------------------------------------------------------------
    // GLOBAL COMPLETION FLAG
    // ------------------------------------------------------------
    bool &done               // [OUTPUT] Inference pipeline fully complete
) {
#pragma HLS PIPELINE II=1       // Tells HLS compiler to make this function-module run every [1] clock cycle
    static SchedState st;
    static int        layer_idx; cntrl_layer_idx = layer_idx;
    static int        head_group;
    static bool       head_reset;
    static bool       embed_wait;

    // Output projection context
    static int  wo_tile;
    static bool wo_dma_busy;
    static bool wo_comp_busy;

    // Residual/LN waits
    static bool resid0_wait;
    static bool ln0_wait;
    static bool resid1_wait;
    static bool ln1_wait;

    // FFN context
    enum class FfnPhase : uint8_t { W1 = 0, ACT, W2, DONE }; // Internal Steps for FFN
    static FfnPhase ffn_phase;
    static int      ffn_tile;
    static bool     ffn_dma_busy;
    static bool     ffn_comp_busy;
    static bool     ffn_act_busy;

    // Stream context
    enum class StreamPhase : uint8_t { DEQUANT = 0, LOGITS, STREAM, COMPLETE }; // Internal state for OUTPUT AXI stream steps
    static StreamPhase stream_phase;
    static int         logit_tile;
    static bool        logit_dma_busy;
    static bool        logit_comp_busy;
    static bool        dequant_busy;
    static bool        axis_stream_busy;

    static bool concat_busy;

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
            init_head_ctx(g_head_ctx[i], -1);
        }
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
    stream_start  = 0;
    done          = 0;

    if (reset)
        return;

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
            st         = S_ATTENTION_HEADS;
            break;

        case S_ATTENTION_HEADS:
            // By running "run_head_group" we are initializing each head group, until i*head_group == NUM_HEADS
            if (run_head_group(
                    layer_idx,
                    head_group,
                    head_reset,
                    wl_ready,
                    dma_done,
                    compute_ready,
                    compute_done,
                    wl_start,
                    wl_addr_sel,
                    wl_layer,
                    wl_head,
                    wl_tile,
                    compute_start,
                    compute_op)) {
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
                st = S_RES_ADD_2;
                break;
            }
            if (ffn_phase == FfnPhase::W1) {
                if (ffn_dma_busy && dma_done) {
                    ffn_dma_busy  = false;
                    ffn_comp_busy = true;
                }
                if (ffn_tile >= NUM_W1_TILES) {
                    if (!ffn_dma_busy && !ffn_comp_busy) {
                        ffn_phase    = FfnPhase::ACT;
                        ffn_act_busy = false;
                    }
                } else if (!ffn_dma_busy && wl_ready) {
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
                if (ffn_tile >= NUM_W2_TILES) {
                    if (!ffn_dma_busy && !ffn_comp_busy) {
                        ffn_phase = FfnPhase::DONE;
                    }
                } else if (!ffn_dma_busy && wl_ready) {
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
            }
            break;
        case S_RES_ADD_2:
            if (!resid1_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_RESID1;
                resid1_wait   = true;
            } else if (resid1_wait && compute_done) {
                resid1_wait = false;
                st          = S_LAYER_NORM_2;
            }
            break;

        case S_LAYER_NORM_2:
            if (!ln1_wait && compute_ready) {
                compute_start = 1;
                compute_op    = CMP_LN1;
                ln1_wait      = true;
            } else if (ln1_wait && compute_done) {
                ln1_wait = false;
                st       = S_LOOP_CHECK;
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

}

// ------------------------------------------------------------
// Head processing helpers
// ------------------------------------------------------------
bool run_head_group(
    int   layer_idx,
    int   group_idx,
    bool  reset_resources,
    bool  wl_ready,
    bool  dma_done,
    bool  compute_ready,
    bool  compute_done,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile,
    bool &compute_start,
    int  &compute_op
) {
#pragma HLS INLINE
    static HeadResources res; // Manage resources for entire Head Group (managing shared resource signals)
    if (reset_resources) {
        res = HeadResources{}; // Re-init res if reset is asserted
    }

    if (dma_done && res.dma_busy) {
        HeadCtx &ctx = g_head_ctx[res.dma_owner];
        ctx.dma_done_flag = true;
        res.dma_busy      = false;
    }
    if (compute_done && res.comp_busy) {
        HeadCtx &ctx = g_head_ctx[res.comp_owner];
        ctx.comp_done_flag = true;
        res.comp_busy      = false;
    }

    const int head_base = group_idx * HEADS_PARALLEL;   // Calculate the Head "Group" we are currently in
    bool group_finished = true;                         // init the 

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) { // This will create HEADS_PARALLEL number of seperate headed computation runs
#pragma HLS UNROLL
        const int head_idx = head_base + lane;
        if (head_idx >= NUM_HEADS)
            continue;

        HeadCtx &ctx = g_head_ctx[head_idx];
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
                res,
                wl_start,
                wl_addr_sel,
                wl_layer,
                wl_head,
                wl_tile,
                compute_start,
                compute_op);
        }
    }

    return group_finished && !res.dma_busy && !res.comp_busy;
}

void init_head_ctx(HeadCtx &ctx, int layer_idx) {
#pragma HLS INLINE
    ctx.layer_stamp    = layer_idx;
    ctx.phase          = HeadPhase::QKV;
    ctx.wait_dma       = false;
    ctx.wait_comp      = false;
    ctx.dma_done_flag  = false;
    ctx.comp_done_flag = false;
}

void drive_head_phase(
    HeadCtx         &ctx,
    int             head_idx,
    int             layer_idx,
    bool            wl_ready,
    bool            compute_ready,
    HeadResources   &res,
    bool            &wl_start,
    int             &wl_addr_sel,
    int             &wl_layer,
    int             &wl_head,
    int             &wl_tile,
    bool            &compute_start,
    int             &compute_op
) {
#pragma HLS INLINE
    switch (ctx.phase) {
        case HeadPhase::QKV:
            //FETCH DATA part
            if (!ctx.wait_dma) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_QKV,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                ctx.wait_comp     = true;
            }

            //COMPUTE part
            if (ctx.wait_comp && !ctx.comp_done_flag) {
                if (start_head_compute(res, head_idx, CMP_QKV,
                                       compute_ready, compute_start, compute_op)) {
                    // wait for completion
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::ATT_SCORES;
            }
            break;

        case HeadPhase::ATT_SCORES:
            if (!ctx.wait_dma) {
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
                ctx.phase          = HeadPhase::REQUANT1;
            }
            break;
        case HeadPhase::REQUANT1:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_HEAD_REQUANT,
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
            if (!ctx.wait_dma) {
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
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_HEAD_REQUANT,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::KV_STORE;
            }
            break;

        case HeadPhase::KV_STORE:
            if (!ctx.wait_dma && !ctx.wait_comp) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_K_WRITE,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            } else if (ctx.wait_dma && ctx.dma_done_flag) {
                ctx.dma_done_flag = false;
                ctx.wait_dma      = false;
                if (!ctx.wait_comp) {
                    ctx.wait_comp = true;   // request V write next
                } else {
                    ctx.wait_comp = false;
                    ctx.phase     = HeadPhase::DONE;
                }
            }
            if (ctx.wait_comp && !ctx.wait_dma) {
                if (start_head_dma(res, head_idx, layer_idx, DMASEL_V_WRITE,
                                   wl_ready, wl_start, wl_addr_sel,
                                   wl_layer, wl_head, wl_tile)) {
                    ctx.wait_dma = true;
                }
            }
            break;

        case HeadPhase::DONE:
        default:
            break;
    }
}




bool start_head_dma(
    HeadResources &res,
    int   head_idx,
    int   layer_idx,
    DmaSel sel,
    bool  wl_ready,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile
) {
#pragma HLS INLINE
    if (res.dma_busy || !wl_ready || wl_start)
        return false; // need to keep waiting
    wl_start    = 1;
    wl_addr_sel = sel;
    wl_layer    = layer_idx;
    wl_head     = head_idx;
    wl_tile     = 0;
    res.dma_busy  = true;
    res.dma_owner = head_idx;
    res.dma_tag   = sel;
    return true;
}




bool start_head_compute(
    HeadResources &res,
    int   head_idx,
    ComputeOp op,
    bool  compute_ready,
    bool &compute_start,
    int  &compute_op
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
