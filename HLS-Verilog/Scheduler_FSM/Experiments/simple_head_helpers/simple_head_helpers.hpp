// Declarations for the simplified, single-head helper flow (compute-only).
#pragma once
#include <cstdint>

constexpr int NUM_HEADS      = 4;
constexpr int HEADS_PARALLEL = 1;

enum class HeadPhase : uint8_t {
    Q = 0,             // 0
    K,                 // 1
    K_REQUANT,         // 2
    K_WRITEBACK,       // 3
    V,                 // 4
    V_REQUANT,         // 5
    V_WRITEBACK,       // 6
    REQUANT_Q,         // 7
    ATT_SCORES,        // 8
    VALUE_SCALE_CLAMP, // 9
    ATT_SOFTMAX,       // 10
    ATT_VALUE,         // 11
    REQUANT2,          // 12
    DONE               // 13
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_Q,
    CMP_K,
    CMP_V
};

struct HeadCtx {
    int  layer_stamp   = -1;
    HeadPhase  phase   = HeadPhase::Q; // 0=Q,1=K,2=V,3=DONE
    bool wait_comp     = false;
    bool comp_done_flag= false;
    bool compute_ready = false;
    bool compute_done  = false;
    bool compute_start = false;
    int  compute_op    = static_cast<int>(CMP_NONE);
};

void init_head_ctx(HeadCtx &ctx, int layer_idx);

// Single-head driver: issues compute_start when ready, advances on compute_done.
// Returns true when the head reaches DONE and is not waiting on compute.
bool run_single_head(
    HeadCtx &ctx,
    int      head_idx,
    int      layer_idx);
