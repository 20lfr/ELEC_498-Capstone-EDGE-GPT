// Simplified, single-head helper flow that only exercises compute.
// Each head has its own "resource" (no shared arbitration).
#include "simple_head_helpers.hpp"

void init_head_ctx(HeadCtx &ctx, int layer_idx) {
    ctx.layer_stamp   = layer_idx;
    ctx.phase         = HeadPhase::Q;
    ctx.wait_comp     = false;
    ctx.comp_done_flag= false;
    ctx.compute_ready = false;
    ctx.compute_done  = false;
    ctx.compute_start = false;
    ctx.compute_op    = static_cast<int>(CMP_NONE);
}

bool run_single_head(
    HeadCtx &ctx,
    int      head_idx,
    int      layer_idx)
{
#pragma HLS INLINE off
    // Defaults each call
    ctx.compute_start = false;
    ctx.compute_op    = static_cast<int>(CMP_NONE);

    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx);
    }

    // Consume compute_done if we were waiting
    if (ctx.wait_comp && ctx.compute_done) {
        ctx.wait_comp      = false;
        ctx.comp_done_flag = true;
    }

    // Drive phase machine
    switch (ctx.phase) {
        case HeadPhase::Q: // Q
            if (!ctx.wait_comp) {
                if (ctx.compute_ready) {
                    ctx.compute_start = true;
                    ctx.compute_op    = static_cast<int>(CMP_Q);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = HeadPhase::K;
            }
            break;
        case HeadPhase::K: // K
            if (!ctx.wait_comp) {
                if (ctx.compute_ready) {
                    ctx.compute_start = true;
                    ctx.compute_op    = static_cast<int>(CMP_K);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = HeadPhase::V;
            }
            break;
        case HeadPhase::V: // V
            if (!ctx.wait_comp) {
                if (ctx.compute_ready) {
                    ctx.compute_start = true;
                    ctx.compute_op    = static_cast<int>(CMP_V);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = HeadPhase::DONE;
            }
            break;
        case HeadPhase::DONE: // DONE
        default:
            break;
    }

    const bool finished = (ctx.phase == HeadPhase::DONE) && !ctx.wait_comp;
    (void)head_idx; // head_idx reserved for future use/debug
    return finished;
}
