#pragma once

#include <cstdint>

// ------------------------------------------------------------
// Tunable architecture parameters
// ------------------------------------------------------------

/*
d_model  = 2048 params 
Total Parameters: 1.1 billion
Hidden Size ($d_{model}$): 2048
Number of Layers: 22
Number of Attention Heads: 32
Intermediate Size: 5504 
(This is the size of the hidden layer in the Feed-Forward Network).

residual size is 2048 times int8 (8 bits) 
matrics is 4bits
*/
constexpr int NUM_LAYERS       = 2;
constexpr int NUM_HEADS        = 8;
constexpr int HEADS_PARALLEL   = 2;
constexpr int NUM_WO_TILES     = 4;
constexpr int NUM_W1_TILES     = 4;
constexpr int NUM_W2_TILES     = 4;
constexpr int NUM_LOGIT_TILES  = 2;

constexpr int NUM_HEAD_GROUPS =
    (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;

// ------------------------------------------------------------
// Scheduler state + helper enums
// ------------------------------------------------------------
enum SchedState {
    S_IDLE,             // 0
    S_STREAM_IN,        // 1
    S_LAYER_COUNT,      // 2
    S_ATTENTION_HEADS,  // 3
    S_HEAD_CONCAT,      // 4
    S_OUT_PROJECTION,   // 5
    S_RES_ADD_1,        // 6
    S_LAYER_NORM_1,     // 7
    S_FFN,              // 8
    S_RES_ADD_2,        // 9
    S_LAYER_NORM_2,     // 10
    S_LOOP_CHECK,       // 11
    S_STREAM_OUT        // 12
};

enum DmaSel : uint8_t {
    DMASEL_WQ = 0,   // 0
    DMASEL_WK,       // 1
    DMASEL_WV,       // 2
    DMASEL_CTX_K,    // 3
    DMASEL_CTX_V,    // 4
    DMASEL_K_WRITE,  // 5
    DMASEL_V_WRITE,  // 6
    DMASEL_WO,       // 7
    DMASEL_W1,       // 8
    DMASEL_W2,       // 9
    DMASEL_WLOGIT    // 10
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,     // 0
    CMP_Q,            // 1
    CMP_K,            // 2
    CMP_V,            // 3
    CMP_ATT_SCORES,   // 4
    CMP_VALUE_SCALE,  // 5
    CMP_SOFTMAX,      // 6
    CMP_ATT_VALUE,    // 7
    CMP_HEAD_REQUANT, // 8
    CMP_CONCAT,       // 9
    CMP_OUT_PROJ,     // 10
    CMP_RESID0,       // 11
    CMP_LN0,          // 12
    CMP_FFN_W1,       // 13
    CMP_FFN_ACT,      // 14
    CMP_FFN_W2,       // 15
    CMP_RESID1,       // 16
    CMP_LN1,          // 17
    CMP_DEQUANT,      // 18
    CMP_LOGITS        // 19
};

enum RequantOp : uint8_t {
    RQ_NONE = 0, // 0
    RQ_K,        // 1
    RQ_V,        // 2
    RQ_Q,        // 3
    RQ_FINAL     // 4
};

// ------------------------------------------------------------
// Scheduler FSM top-level
// ------------------------------------------------------------
void scheduler_hls(
    bool cntrl_start,
    bool cntrl_reset_n,
    uint32_t &cntrl_layer_idx,
    bool &cntrl_busy,
    bool &cntrl_start_out,
    bool axis_in_valid,
    bool axis_in_last,
    bool &axis_in_ready,
    bool wl_ready,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile,
    bool dma_done,
    bool compute_ready,
    bool compute_done,
    bool requant_ready,
    bool requant_done,
    bool &compute_start,
    int  &compute_op,
    bool &requant_start,
    int  &requant_op,
    bool stream_ready,
    bool &stream_start,
    bool stream_done,
    bool &done,
    SchedState &STATE
);
