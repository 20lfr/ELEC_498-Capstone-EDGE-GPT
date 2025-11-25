// Simplified, single-head helper flow that only exercises compute.
// Each head has its own "resource" (no shared arbitration).
#include "simple_head_helpers.hpp"

void init_head_ctx(HeadCtx &ctx, int layer_idx) {
    ctx.layer_stamp   = layer_idx;
    ctx.phase         = 0;
    ctx.wait_comp     = false;
    ctx.comp_done_flag= false;
}

bool run_single_head(
    HeadCtx &ctx,
    int      head_idx,
    int      layer_idx,
    bool     compute_ready,
    bool     compute_done,
    bool    &compute_start,
    int     &compute_op)
{
#pragma HLS INLINE off
    // Defaults each call
    compute_start = false;
    compute_op    = static_cast<int>(CMP_NONE);

    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx);
    }

    // Consume compute_done if we were waiting
    if (ctx.wait_comp && compute_done) {
        ctx.wait_comp      = false;
        ctx.comp_done_flag = true;
    }

    // Drive phase machine
    switch (ctx.phase) {
        case 0: // Q
            if (!ctx.wait_comp) {
                if (compute_ready) {
                    compute_start = true;
                    compute_op    = static_cast<int>(CMP_Q);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = 1;
            }
            break;
        case 1: // K
            if (!ctx.wait_comp) {
                if (compute_ready) {
                    compute_start = true;
                    compute_op    = static_cast<int>(CMP_K);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = 2;
            }
            break;
        case 2: // V
            if (!ctx.wait_comp) {
                if (compute_ready) {
                    compute_start = true;
                    compute_op    = static_cast<int>(CMP_V);
                    ctx.wait_comp = true;
                }
            } else if (ctx.comp_done_flag) {
                ctx.comp_done_flag = false;
                ctx.phase = 3;
            }
            break;
        case 3: // DONE
        default:
            break;
    }

    const bool finished = (ctx.phase == 3) && !ctx.wait_comp;
    (void)head_idx; // head_idx reserved for future use/debug
    return finished;
}
