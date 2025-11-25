#pragma once

#include <cstdint>

// ------------------------------------------------------------
// Tunable architecture parameters
// ------------------------------------------------------------

/*
Model Features:=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
d_model  = 2048 params 
Total Parameters: 1.1 billion
Hidden Size ($d_{model}$): 2048
Number of Layers: 22
Number of Attention Heads: 32
Intermediate Size: 5504 
(This is the size of the hidden layer in the Feed-Forward Network).

(int8) Residual size   = 2048 values -> 16 Kb (16,384 bits)
(int4) Head size       = per-head Q/K/V weights: 2048 x 64 -> 131,072 weights -> 524,288 bits (512 Kb ≈ 0.5 Mb)
(int4) Head concat     = 32 heads (activations) -> 8 Kb (8,192 bits)
(int4) WQ dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WK dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WV dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) WO dimensions   = 2048 x 2048 -> 4,194,304 weights  -> 16,777,216 bits (16,384 Kb ≈ 16 Mb)
(int4) W1 dimensions   = 2048 x 5504 -> 11,272,192 weights -> 45,088,768 bits (44,064 Kb ≈ 44.064 Mb)
(int4) W2 dimensions   = 5504 x 2048 -> 11,272,192 weights -> 45,088,768 bits (44,064 Kb ≈ 44.064 Mb)

Tiling Methods:
WO per tile = 2048 x 2048 -> 2048 x 64 (32 tiles)
W1 per tile = 2048 x 5504 -> 2048 x 64 (86 tiles)
W2 per tile = 5504 x 2048 -> 5504 x 64 (32 tiles)

URAM Features:=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
URAM total: 64 blocks × 288 Kb ≈ 18.4 Mb total on-chip URAM
Per Block : 288Kb ≈ 0.28125 Mb

== Tiles/Heads ==
Per Head     : 2 Blocks per head
Per Tile W0  : 2 Blocks per tile
Per Tile W1  : 2 blocks per tile
Per Tile W2  : 5 blocks per tile

== KV Cache ==
L = context window size
Per head:  
    K_cache_head = [L × 64] int8  
    V_cache_head = [L × 64] int8
All heads:  
    K_cache = [32 × L × 64] int8  
    V_cache = [32 × L × 64] int8

BRAM Features::=~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
BRAM total: 144 blocks × 36 Kb ≈ 5.1 Mb total on-chip BRAM

======================  ATTENTION PIPELINE  ======================
== Phase 0: Input / Residual ==
Stored:  x_in                = [2048] int8
Compute: int8 loaded into MACs

== Phase 1: Q/K/V Projections ==
Compute: int8 * int4 -> int32 accum (64 accs per head)
Stored per head:  
    Q_head = [64] int8  
    K_head = [64] int8  
    V_head = [64] int8
Stored all heads (optional):  
    Q_all = [2048] int8  
    K_all = [2048] int8  
    V_all = [2048] int8

== Phase 2: Attention Scores (QKᵀ) ==
Input: Q_head_now = [64] int8  
       K_cache_head = [L × 64] int8
Compute: dot(64) → int32 accum → clamp to int16 accum for softmax later
Stored: scores_head = [L] int16

== Phase 3: Scaling + Softmax ==
Input:              scores_head = [L] int16
Stored (Output):    probs_head = [L] int16

== Phase 4: Value Aggregation (S·V) ==
Input: probs_head = [L] int16  
       V_cache_head = [L × 64] int8
Compute: per-dim accumulate → int32
Stored per head: out_head = [64] int8
Stored concat:   attn_out = [2048] int8

== Phase 5: Output Projection (WO) ==
Input: attn_out = [2048] int8
Compute: int8 * int4 → int32 accum
Stored: attn_proj = [2048] int8
Final residual add: x_out = [2048] int8


======================  FEED-FORWARD NETWORK  ======================
== Phase 7: W1 Projection ==
Input: x_out = [2048] int8
Compute: int8 * int4 → int32
Stored: ffn_up = [5504] int8

== Phase 8: Activation (ReLU/GELU) ==
Stored: ffn_act = [5504] int8

== Phase 9: W2 Projection ==
Input: ffn_act = [5504] int8
Compute: int8 * int4 → int32
Stored: ffn_down = [2048] int8

== Phase 10: Residual Output ==
Stored: final_out = [2048] int8


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
    S_IDLE,
    S_STREAM_IN,
    S_LAYER_COUNT,
    S_ATTENTION_HEADS,
    S_HEAD_CONCAT,
    S_OUT_PROJECTION,
    S_RES_ADD_1,
    S_LAYER_NORM_1,
    S_FFN,
    S_RES_ADD_2,
    S_LAYER_NORM_2,
    S_LOOP_CHECK,
    S_STREAM_OUT
};

enum class HeadPhase : uint8_t {
    Q = 0,
    K,
    K_REQUANT,
    K_WRITEBACK,
    V,
    V_REQUANT,
    V_WRITEBACK,
    REQUANT_Q,
    ATT_SCORES,
    VALUE_SCALE_CLAMP,
    ATT_SOFTMAX,
    ATT_VALUE,
    REQUANT2,
    DONE
};

enum DmaSel : uint8_t {
    DMASEL_WQ = 0,
    DMASEL_WK,
    DMASEL_WV,
    DMASEL_CTX_K,
    DMASEL_CTX_V,
    DMASEL_K_WRITE,
    DMASEL_V_WRITE,
    DMASEL_WO,
    DMASEL_W1,
    DMASEL_W2,
    DMASEL_WLOGIT
};

enum ComputeOp : uint8_t {
    CMP_NONE = 0,
    CMP_Q,
    CMP_K,
    CMP_V,
    CMP_ATT_SCORES,
    CMP_VALUE_SCALE,
    CMP_SOFTMAX,
    CMP_ATT_VALUE,
    CMP_HEAD_REQUANT,
    CMP_CONCAT,
    CMP_OUT_PROJ,
    CMP_RESID0,
    CMP_LN0,
    CMP_FFN_W1,
    CMP_FFN_ACT,
    CMP_FFN_W2,
    CMP_RESID1,
    CMP_LN1,
    CMP_DEQUANT,
    CMP_LOGITS
};

enum RequantOp : uint8_t {
    RQ_NONE = 0,
    RQ_K,
    RQ_V,
    RQ_Q,
    RQ_FINAL
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
