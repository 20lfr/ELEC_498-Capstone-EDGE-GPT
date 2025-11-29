// Simplified, single-head helper flow that only exercises compute.
// Each head has its own "resource" (no shared arbitration).
#include "simple_head_helpers.hpp"

void init_head_ctx(HeadCtx &ctx, int layer_idx) {
    ctx.layer_stamp   = layer_idx;
    ctx.phase         = HeadPhase::IDLE;
    ctx.compute_ready = false;
    ctx.compute_done  = false;
    ctx.compute_start = false;
    ctx.compute_op    = ComputeOp::CMP_NONE;
    ctx.start_head    = false;
    ctx.q_started          = false;
    ctx.k_started          = false;
    ctx.v_started          = false;
    ctx.att_scores_started = false;
    ctx.val_scale_started  = false;
    ctx.softmax_started    = false;
    ctx.att_value_started  = false;

    ctx.q_compute_done          = false;
    ctx.k_compute_done          = false;
    ctx.v_compute_done          = false;
    ctx.att_scores_compute_done = false;
    ctx.val_scale_compute_done  = false;
    ctx.softmax_compute_done    = false;
    ctx.att_value_compute_done  = false;
}

// NOTE: Head &ctx originate outside this logic, so it must be reset outside of it
// 
/*
    FUNCTIONALITY NOTES:
        ctx.compute_done:   Becuase the hardware intention is for this signal to be a pulse, it is
                            the externals logic's responsiblity to hold this signal long enough to be caught 
                            by the if condition that blocks the next phase. LOOK HERE IF HAVING TIMING ISSUES!
*/
// Return: true when ctx reaches DONE and is not waiting on compute; false otherwise.
bool run_single_head(
    HeadCtx &ctx,           // [BOTH]   Persistent head state (phase, flags, last layer stamp, compute handshake bits).
    int      layer_idx,     // [INPUT]: Current layer stamp; if changed, ctx re-initializes to IDLE.
    bool     start          // [INPUT]: Kick from IDLE into Q (independent of compute_ready).
)
{
#pragma HLS INLINE off
    // Defaults each call
    ctx.compute_start = false;
    ctx.compute_op    = ComputeOp::CMP_NONE;
    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx);
    }

    // Sticky capture of compute_done per phase so single-cycle pulses are retained
    if (ctx.compute_done) {
        if (ctx.q_started)          ctx.q_compute_done = true;
        if (ctx.k_started)          ctx.k_compute_done = true;
        if (ctx.v_started)          ctx.v_compute_done = true;
        if (ctx.att_scores_started) ctx.att_scores_compute_done = true;
        if (ctx.val_scale_started)  ctx.val_scale_compute_done  = true;
        if (ctx.softmax_started)    ctx.softmax_compute_done    = true;
        if (ctx.att_value_started)  ctx.att_value_compute_done  = true;
    }

    // Drive phase machine
    switch (ctx.phase) {
        case HeadPhase::IDLE: // wait for explicit start to kick off Q
            if (start) {
                // Clear any stale handshakes when starting a new sequence
                ctx.compute_ready = false;
                ctx.compute_done  = false;
                ctx.compute_start = false;
                ctx.q_started = false;
                ctx.k_started = false;
                ctx.v_started = false;
                ctx.att_scores_started = false;
                ctx.val_scale_started  = false;
                ctx.softmax_started    = false;
                ctx.att_value_started  = false;
                ctx.q_compute_done          = false;
                ctx.k_compute_done          = false;
                ctx.v_compute_done          = false;
                ctx.att_scores_compute_done = false;
                ctx.val_scale_compute_done  = false;
                ctx.softmax_compute_done    = false;
                ctx.att_value_compute_done  = false;
                ctx.phase = HeadPhase::Q;
            }
            break;
        case HeadPhase::Q: // Q
            if (ctx.compute_ready && !ctx.q_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_Q;
                ctx.q_started = true;
            }
            else if (ctx.q_compute_done && ctx.q_started) {
                ctx.phase = HeadPhase::K;
                ctx.q_started = false;
            }
            break;
        case HeadPhase::K: // K
            if (ctx.compute_ready && !ctx.k_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_K;
                ctx.k_started = true;
            }
            else if (ctx.k_compute_done && ctx.k_started) {
                ctx.phase = HeadPhase::K_REQUANT;
                ctx.k_started = false;            }
            break;
        case HeadPhase::K_REQUANT:
            ctx.phase = HeadPhase::K_WRITEBACK;
            break;
        case HeadPhase::K_WRITEBACK:
            ctx.phase = HeadPhase::V;
            break;
        case HeadPhase::V: // V
            if (ctx.compute_ready && !ctx.v_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_V;
                ctx.v_started = true;
            }
            else if (ctx.v_compute_done && ctx.v_started) {
                ctx.phase = HeadPhase::V_REQUANT;
                ctx.v_started = false;
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
            if (ctx.compute_ready && !ctx.att_scores_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_ATT_SCORES;
                ctx.att_scores_started = true;
            } else if (ctx.att_scores_compute_done && ctx.att_scores_started) {
                ctx.phase = HeadPhase::VALUE_SCALE_CLAMP;
                ctx.att_scores_started = false;
            }
            break;
        case HeadPhase::VALUE_SCALE_CLAMP:
            if (ctx.compute_ready && !ctx.val_scale_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_VALUE_SCALE;
                ctx.val_scale_started = true;
            } else if (ctx.val_scale_compute_done && ctx.val_scale_started) {
                ctx.phase = HeadPhase::ATT_SOFTMAX;
                ctx.val_scale_started = false;
            }
            break;
        case HeadPhase::ATT_SOFTMAX:
            if (ctx.compute_ready && !ctx.softmax_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_SOFTMAX;
                ctx.softmax_started = true;
            } else if (ctx.softmax_compute_done && ctx.softmax_started) {
                ctx.phase = HeadPhase::ATT_VALUE;
                ctx.softmax_started = false;
            }
            break;
        case HeadPhase::ATT_VALUE:
            if (ctx.compute_ready && !ctx.att_value_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_ATT_VALUE;
                ctx.att_value_started = true;
            } else if (ctx.att_value_compute_done && ctx.att_value_started) {
                ctx.phase = HeadPhase::REQUANT2;
                ctx.att_value_started = false;
            }
            break;
        case HeadPhase::REQUANT2:
            ctx.phase = HeadPhase::DONE;
            break;
        case HeadPhase::DONE: // DONE
            break;
        default:
            break;
    }

    return (ctx.phase == HeadPhase::DONE);
}



bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[HEADS_PARALLEL], // [BOTH]:  Tracks current group only
    int         base_head_idx,                  // [INPUT]: Global base index of this group
    int         layer_idx,                      // [INPUT]: Current Layer ID
    bool        start                           // [INPUT]: Start the driving phase
){
#pragma HLS ARRAY_PARTITION variable=head_ctx_ref complete dim=1

    bool group_finished = true; // assume finished unless any head is still active

    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        HeadCtx &ctx = head_ctx_ref[lane]; // Current head in this group

        if (ctx.phase != HeadPhase::DONE) {
            ctx.start_head = start && (ctx.phase == HeadPhase::IDLE);
            const bool head_done = run_single_head(
                ctx,
                layer_idx,
                ctx.start_head);
            if (!head_done) group_finished = false;
        }
    }

    (void)base_head_idx; // currently unused, but reserved for global indexing/debug

    return group_finished;
}
