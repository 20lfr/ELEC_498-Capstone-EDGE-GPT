// Declarations for the simplified, single-head helper flow (compute-only).
#pragma once
#include <cstdint>

constexpr int NUM_HEADS      = 2;
constexpr int HEADS_PARALLEL = 2;

enum ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_Q,
    CMP_K,
    CMP_V
};

struct HeadCtx {
    int  layer_stamp   = -1;
    int  phase         = 0; // 0=Q,1=K,2=V,3=DONE
    bool wait_comp     = false;
    bool comp_done_flag= false;
};

void init_head_ctx(HeadCtx &ctx, int layer_idx);

// Single-head driver: issues compute_start when ready, advances on compute_done.
// Returns true when the head reaches DONE and is not waiting on compute.
bool run_single_head(
    HeadCtx &ctx,
    int      head_idx,
    int      layer_idx,
    bool     compute_ready,
    bool     compute_done,
    bool    &compute_start,
    int     &compute_op);
