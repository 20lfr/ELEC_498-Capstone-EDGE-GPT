#pragma once

#include <cstdint>

// ------------------------------------------------------------
// Tunable architecture parameters
// ------------------------------------------------------------
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
    S_START,
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
    QKV = 0,
    REQUANT1,
    ATT_SCORES,
    ATT_SOFTMAX,
    ATT_VALUE,
    REQUANT2,
    KV_STORE,
    DONE
};

enum DmaSel : uint8_t {
    DMASEL_QKV = 0,
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
    CMP_QKV,
    CMP_ATT_SCORES,
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

struct HeadCtx {
    int       layer_stamp   = -1;
    HeadPhase phase         = HeadPhase::QKV;
    bool      wait_dma      = false;
    bool      wait_comp     = false;
    bool      dma_done_flag = false;
    bool      comp_done_flag= false;
};

struct HeadResources {
    bool   dma_busy  = false;
    int    dma_owner = -1;
    DmaSel dma_tag   = DMASEL_QKV;

    bool       comp_busy  = false;
    int        comp_owner = -1;
    ComputeOp  comp_tag   = CMP_NONE;
};

extern HeadCtx g_head_ctx[NUM_HEADS];

// ------------------------------------------------------------
// Helper declarations
// ------------------------------------------------------------
bool run_head_group(
    int   layer_idx,
    int   group_idx,
    bool  reset_resources,
    bool  wl_ready,
    bool  dma_done,
    bool  compute_ready,
    bool  compute_done,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile,
    bool &compute_start,
    int  &compute_op
);

void init_head_ctx(HeadCtx &ctx, int layer_idx);

void drive_head_phase(
    HeadCtx &ctx,
    int       head_idx,
    int       layer_idx,
    bool      wl_ready,
    bool      compute_ready,
    HeadResources &res,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile,
    bool &compute_start,
    int  &compute_op
);

bool start_head_dma(
    HeadResources &res,
    int   head_idx,
    int   layer_idx,
    DmaSel sel,
    bool  wl_ready,
    bool &wl_start,
    int  &wl_addr_sel,
    int  &wl_layer,
    int  &wl_head,
    int  &wl_tile
);

bool start_head_compute(
    HeadResources &res,
    int   head_idx,
    ComputeOp op,
    bool  compute_ready,
    bool &compute_start,
    int  &compute_op
);

// ------------------------------------------------------------
// Scheduler FSM top-level
// ------------------------------------------------------------
void scheduler_hls(
    bool cntrl_start,
    bool cntrl_reset_n,
    uint32_t &cntrl_layer_idx,
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
    bool &compute_start,
    int  &compute_op,
    bool stream_ready,
    bool &stream_start,
    bool stream_done,
    bool &done
);
