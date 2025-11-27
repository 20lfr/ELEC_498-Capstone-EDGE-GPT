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
}

// NOTE: Head &ctx originate outside this logic, so it must be reset outside of it
// Return: true when ctx reaches DONE and is not waiting on compute; false otherwise.
bool run_single_head(
    HeadCtx &ctx,           // [BOTH]   Persistent head state (phase, flags, last layer stamp, compute handshake bits).
    int      layer_idx,     // [INPUT]: Current layer stamp; if changed, ctx re-initializes to IDLE.
    bool     start          // [INPUT]: Kick from IDLE into Q (independent of compute_ready).
)
{
#pragma HLS INLINE off
    static bool Q_started;
#pragma HLS reset variable=Q_started
    static bool K_started;
#pragma HLS reset variable=K_started
    static bool V_started;
#pragma HLS reset variable=V_started
    static bool att_scores_started;
#pragma HLS reset variable=att_scores_started
    static bool val_scale_started;
#pragma HLS reset variable=val_scale_started
    static bool softmax_started;
#pragma HLS reset variable=softmax_started
    static bool att_value_started;
#pragma HLS reset variable=att_value_started

    bool reset_flags = false;


    // Defaults each call
    ctx.compute_start = false;
    ctx.compute_op    = ComputeOp::CMP_NONE;

    // Initialize context if layer changes
    if (ctx.layer_stamp != layer_idx) {
        init_head_ctx(ctx, layer_idx);
        reset_flags = true;
    }

    if (reset_flags) {
        Q_started = false;
        K_started = false;
        V_started = false;
        att_scores_started = false;
        val_scale_started  = false;
        softmax_started    = false;
        att_value_started  = false;
    }

    // Drive phase machine
    switch (ctx.phase) {
        case HeadPhase::IDLE: // wait for explicit start to kick off Q
            if (start) {
                // Clear any stale handshakes when starting a new sequence
                ctx.compute_ready = false;
                ctx.compute_done  = false;
                ctx.compute_start = false;
                Q_started = false;
                K_started = false;
                V_started = false;
                att_scores_started = false;
                val_scale_started  = false;
                softmax_started    = false;
                att_value_started  = false;
                ctx.phase = HeadPhase::Q;
            }
            break;
        case HeadPhase::Q: // Q
            if (ctx.compute_ready && !Q_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_Q;
                Q_started = true;
            }
            else if (ctx.compute_done && Q_started) {
                ctx.phase = HeadPhase::K;
                Q_started = false;
            }
            break;
        case HeadPhase::K: // K
            if (ctx.compute_ready && !K_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_K;
                K_started = true;
            }
            else if (ctx.compute_done && K_started) {
                ctx.phase = HeadPhase::K_REQUANT;
                K_started = false;
            }
            break;
        case HeadPhase::K_REQUANT:
            ctx.phase = HeadPhase::K_WRITEBACK;
            break;
        case HeadPhase::K_WRITEBACK:
            ctx.phase = HeadPhase::V;
            break;
        case HeadPhase::V: // V
            if (ctx.compute_ready && !V_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_V;
                V_started = true;
            }
            else if (ctx.compute_done && V_started) {
                ctx.phase = HeadPhase::V_REQUANT;
                V_started = false;
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
            if (ctx.compute_ready && !att_scores_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_ATT_SCORES;
                att_scores_started = true;
            } else if (ctx.compute_done && att_scores_started) {
                ctx.phase = HeadPhase::VALUE_SCALE_CLAMP;
                att_scores_started = false;
            }
            break;
        case HeadPhase::VALUE_SCALE_CLAMP:
            if (ctx.compute_ready && !val_scale_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_VALUE_SCALE;
                val_scale_started = true;
            } else if (ctx.compute_done && val_scale_started) {
                ctx.phase = HeadPhase::ATT_SOFTMAX;
                val_scale_started = false;
            }
            break;
        case HeadPhase::ATT_SOFTMAX:
            if (ctx.compute_ready && !softmax_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_SOFTMAX;
                softmax_started = true;
            } else if (ctx.compute_done && softmax_started) {
                ctx.phase = HeadPhase::ATT_VALUE;
                softmax_started = false;
            }
            break;
        case HeadPhase::ATT_VALUE:
            if (ctx.compute_ready && !att_value_started) {
                ctx.compute_start = true;
                ctx.compute_op    = ComputeOp::CMP_ATT_VALUE;
                att_value_started = true;
            } else if (ctx.compute_done && att_value_started) {
                ctx.phase = HeadPhase::REQUANT2;
                att_value_started = false;
            }
            break;
        case HeadPhase::REQUANT2:
            ctx.phase = HeadPhase::DONE;
            break;
        case HeadPhase::DONE: // DONE
        default:
            break;
    }

    const bool finished = (ctx.phase == HeadPhase::DONE);
    return finished;
}



bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[NUM_HEADS], // [BOTH]:  Tracks all head data
    int         group_idx,                  // [INPUT]: Which group of heads to service
    int         layer_idx,                  // [INPUT]: Current Layer ID
    bool        start                       // [INPUT]: Start the driving phase
){
    
// #pragma HLS INLINE off
    // Default deasserts
    

    // This is the the return conditional later to make vitis Synthesize into RTL easier
    bool group_finished = true; // assume finished unless any head is still active

    const int head_group_base = group_idx * HEADS_PARALLEL;
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) { // service only the active group
#pragma HLS UNROLL
        const int head_idx = head_group_base + lane;
        if (head_idx >= NUM_HEADS)
            continue;

        HeadCtx &ctx = head_ctx_ref[head_idx]; // Current head
        if (ctx.layer_stamp != layer_idx) {
            init_head_ctx(ctx, layer_idx);
        }

        if (ctx.phase != HeadPhase::DONE) {
            ctx.start_head = start && (ctx.phase == HeadPhase::IDLE);
            const bool head_done = run_single_head(
                ctx,
                layer_idx,
                ctx.start_head);
            if (!head_done) group_finished = false;
        }
    }
    

    if (!group_finished) return false;
    return group_finished;



}
