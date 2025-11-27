// Declarations for the simplified, single-head helper flow (compute-only).
#pragma once
#include <cstdint>

constexpr int NUM_HEADS      = 2;
constexpr int HEADS_PARALLEL = 2;

enum class HeadPhase : uint8_t {
    IDLE = 0,          // 0
    Q,                 // 1
    K,                 // 2
    K_REQUANT,         // 3
    K_WRITEBACK,       // 4
    V,                 // 5
    V_REQUANT,         // 6
    V_WRITEBACK,       // 7
    REQUANT_Q,         // 8
    ATT_SCORES,        // 9
    VALUE_SCALE_CLAMP, // 10
    ATT_SOFTMAX,       // 11
    ATT_VALUE,         // 12
    REQUANT2,          // 13
    DONE               // 14
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_Q,
    CMP_K,
    CMP_V,
    CMP_ATT_SCORES,
    CMP_VALUE_SCALE,
    CMP_SOFTMAX,
    CMP_ATT_VALUE
};

struct HeadCtx {
    int  layer_stamp   = -1;
    HeadPhase  phase   = HeadPhase::IDLE; // start idle, then Q/K/V/DONE
    bool compute_ready = false;
    bool compute_done  = false;
    bool compute_start = false;
    ComputeOp  compute_op    = ComputeOp::CMP_NONE;

    bool start_head = false;

    // Per-head bookkeeping for started phases
    bool q_started          = false;
    bool k_started          = false;
    bool v_started          = false;
    bool att_scores_started = false;
    bool val_scale_started  = false;
    bool softmax_started    = false;
    bool att_value_started  = false;

    bool q_compute_done          = false;
    bool k_compute_done          = false;
    bool v_compute_done          = false;
    bool att_scores_compute_done = false;
    bool val_scale_compute_done  = false;
    bool softmax_compute_done    = false;
    bool att_value_compute_done  = false;


};

void init_head_ctx(HeadCtx &ctx, int layer_idx);

// Single-head driver: issues compute_start when ready, advances on compute_done.
// Returns true when the head reaches DONE and is not waiting on compute.
bool run_single_head(
    HeadCtx     &ctx,
    int         layer_idx,
    bool        start
);

bool drive_group_head_phase(
    HeadCtx     (&head_ctx_ref)[NUM_HEADS],
    int         group_idx,
    int         layer_idx,
    bool        start
);
