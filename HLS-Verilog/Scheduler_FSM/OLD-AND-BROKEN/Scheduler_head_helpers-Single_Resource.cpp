#include "Scheduler_FSM.hpp"
#include <cstdint>

// ------------------------------------------------------------------
// Head-group runner using HeadPhase:
// - Launch CMP_Q per head in the current group when compute is free.
// - Advance head to DONE on compute_done.
// - Group completes when all heads in the group reach DONE.
// ------------------------------------------------------------------
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
// #pragma HLS INLINE off
    // Default deasserts
    wl_start      = 0;
    compute_start = 0;
    requant_start = 0;
    compute_op    = static_cast<int>(CMP_NONE);
    requant_op    = static_cast<int>(RQ_NONE);

    if (reset_resources) {
        res = HeadResources{}; // Re-init res if reset is asserted
    }


    // MAY CONFLICT WITH ARBITER BELOW
    if (compute_done && res.comp_busy) {
        HeadCtx &ctx = head_ctx_ref[res.comp_owner];
        ctx.comp_done_flag = true;
        res.comp_busy      = false;
        res.grant_compute[res.comp_owner] = false;
        res.currently_granting            = false;
        res.comp_owner     = -1;
        res.comp_tag       = CMP_NONE;
    }

    const int head_base = group_idx * HEADS_PARALLEL;   // Calculate the Head "Group" we are currently in

    // Single-grant arbitration for compute
    const bool clear_grants = !res.currently_granting;
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int head_idx = head_base + lane;
        if (head_idx >= NUM_HEADS)
            continue;
        if (!clear_grants)
            continue;
        res.grant_compute[head_idx] = false; // clear stale grants when idle
    }

    bool can_grant = (!res.comp_busy && !res.currently_granting && compute_ready);
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int head_idx = head_base + lane;
        if (head_idx >= NUM_HEADS)
            continue;
        if (!can_grant)
            continue;
        if (res.request_compute[head_idx]) {
            res.grant_compute[head_idx] = true;
            res.currently_granting      = true;
            can_grant                   = false; // prevent additional grants in this cycle
        }
    }

    // This is the the return conditional later to make vitis Synthesize into RTL easier
    bool group_finished = true; // init the group finished variable
    bool resources_idle = (!res.comp_busy);

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
    // Default unused outputs for this simplified, compute-only flow
    wl_start      = 0;
    wl_addr_sel   = 0;
    wl_layer      = layer_idx;
    wl_head       = head_idx;
    wl_tile       = 0;
    requant_start = 0;
    requant_op    = static_cast<int>(RQ_NONE);

    switch (ctx.phase) {
        case HeadPhase::Q:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_Q, compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::K;
            }
            break;

        case HeadPhase::K:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_K,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::K_REQUANT;
            }
            break;

        case HeadPhase::K_REQUANT:
            ctx.phase = HeadPhase::K_WRITEBACK;
            break;

        case HeadPhase::K_WRITEBACK:
            ctx.phase = HeadPhase::V;
            break;

        case HeadPhase::V:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_V,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::V_REQUANT;
            }
            break;

        case HeadPhase::V_REQUANT:
            ctx.phase = HeadPhase::V_WRITEBACK;
            break;

        case HeadPhase::V_WRITEBACK:
            ctx.phase = HeadPhase::REQUANT_Q;
            break;

        case HeadPhase::REQUANT_Q:
            ctx.phase = HeadPhase::ATT_SCORES;
            break;

        case HeadPhase::ATT_SCORES:
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_ATT_SCORES,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::VALUE_SCALE_CLAMP;
            }
            break;

        case HeadPhase::VALUE_SCALE_CLAMP:
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
            if (!ctx.wait_comp) {
                if (start_head_compute(res, head_idx, CMP_ATT_VALUE,
                                       compute_ready, compute_start, compute_op)) {
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.wait_comp      = false;
                ctx.phase          = HeadPhase::REQUANT2;
            }
            break;

        case HeadPhase::REQUANT2:
            ctx.phase = HeadPhase::DONE;
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
    HeadResources &res,   // [BOTH] Shared compute bookkeeping tracking ownership/busy flags
    int    head_idx,      // [INPUT] Head issuing the compute request
    ComputeOp op,         // [INPUT] Enumerated compute opcode
    bool   compute_ready, // [INPUT] Compute engine readiness
    bool  &compute_start, // [OUTPUT] Pulse that fires the compute engine
    int   &compute_op     // [OUTPUT] Encoded opcode forwarded to hardware
) {
#pragma HLS INLINE
    // Make sure a request is registered
    if (!res.request_compute[head_idx]) {
        res.request_compute[head_idx] = true;
    }
    if (res.comp_busy || compute_start)
        return false; // compute block already taken this cycle
    if (!res.grant_compute[head_idx])
        return false; // no grant yet for this head
    if (!compute_ready)
        return false; // compute pipeline not ready to launch

    // Consume the grant and launch compute
    compute_start = 1;
    compute_op    = static_cast<int>(op);
    res.comp_busy  = true;
    res.comp_owner = head_idx;
    res.comp_tag   = op;
    res.request_compute[head_idx] = false;
    return true;
}

bool start_head_requant(
    HeadResources &res,   // [BOTH] Shared requant bookkeeping tracking ownership/busy flags
    int    head_idx,      // [INPUT] Head issuing the requant request
    RequantOp op,         // [INPUT] Enumerated requant opcode
    bool   requant_ready, // [INPUT] Requant engine readiness
    bool  &requant_start, // [OUTPUT] Pulse that fires the requant engine
    int   &requant_op     // [OUTPUT] Encoded opcode forwarded to hardware
) {
#pragma HLS INLINE
    if (res.requant_busy || !requant_ready || requant_start)
        return false;
    requant_start = 1;
    requant_op    = static_cast<int>(op);
    res.requant_busy  = true;
    res.requant_owner = head_idx;
    res.requant_tag   = op;
    return true;
}
