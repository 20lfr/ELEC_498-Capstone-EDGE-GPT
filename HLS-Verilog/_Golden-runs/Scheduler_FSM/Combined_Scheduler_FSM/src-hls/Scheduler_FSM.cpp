#include "Scheduler_FSM.hpp"
#include <cstdint>

// Minimal, single-path scheduler FSM used to bring RTL back to a known-good
// baseline. All I/O signatures are preserved, but parallel head handling and
// resource arbitration are stripped out. Each state launches at most one
// compute operation and waits for its corresponding done pulse before
// advancing.

void scheduler_hls(
    // ------------------------------------------------------------
    // AXI4-Lite CONTROL INTERFACE (PS → PL)
    // ------------------------------------------------------------
    bool cntrl_start,          // [INPUT]  From AXI-Lite: "start inference" bit
    bool cntrl_reset_n,        // [INPUT]  Active-low synchronous reset
    uint32_t &cntrl_layer_idx, // [OUTPUT] Current layer index mirrored into
                               // control mem
    bool &cntrl_busy,          // [OUTPUT] Scheduler active (non-idle)
    bool &cntrl_start_out, // [OUTPUT] FSM-controlled start bit (cleared after
                           // leaving IDLE)

    // ------------------------------------------------------------
    // AXI4-STREAM INPUT (INGRESS: PS → PL)
    // ------------------------------------------------------------
    bool axis_in_valid,  // [INPUT]  s_axis_in_tvalid
    bool axis_in_last,   // [INPUT]  s_axis_in_tlast
    bool &axis_in_ready, // [OUTPUT] s_axis_in_tready

    // ------------------------------------------------------------
    // WEIGHT LOADER (AXI4-FULL MASTER via DMA)
    // ------------------------------------------------------------
    bool wl_ready,    // [INPUT]  Weight loader ready for a new request
    bool &wl_start,   // [OUTPUT] Start weight load DMA
    int &wl_addr_sel, // [OUTPUT] Select which matrix/tile (Q, K, V, K cache, V
                      // cache, WO, W1...)
    int &wl_layer,    // [OUTPUT] Layer index for DMA
    int &wl_head,     // [OUTPUT] Head index for DMA (or -1 for non-head ops)
    int &wl_tile,     // [OUTPUT] Tile index for large matrices
    bool dma_done,    // [INPUT]  DMA transfer completed (single-cycle pulse)

    // ------------------------------------------------------------
    // COMPUTE CORE (MAC ARRAY + PIPELINE)
    // ------------------------------------------------------------
    bool compute_ready,  // [INPUT]  Compute engine idle / ready for next op
    bool compute_done,   // [INPUT]  Compute operation finished (one-shot)
    bool requant_ready,  // [INPUT]  Requant engine ready
    bool requant_done,   // [INPUT]  Requant engine operation done
    HeadCtx (&head_ctx_ref)[NUM_HEADS], // [BOTH]  Per-head context (in/out)
    bool &compute_start, // [OUTPUT] Trigger compute engine
    int &compute_op,     // [OUTPUT] What operation to run (QKV, AttnScore,
                         // Softmax...)
    bool &requant_start, // [OUTPUT] Trigger requant engine
    int &requant_op,     // [OUTPUT] Requant operation to run

    // ------------------------------------------------------------
    // AXI4-STREAM OUTPUT (EGRESS: PL → PS)
    // ------------------------------------------------------------
    bool stream_ready,  // [INPUT]  Stream-out engine is idle & ready to start
    bool &stream_start, // [OUTPUT] Tell stream-out module to begin streaming
    bool stream_done,   // [INPUT]  Stream-out finished entire sequence

    // ------------------------------------------------------------
    // GLOBAL COMPLETION FLAG
    // ------------------------------------------------------------
    bool &done, // [OUTPUT] Inference pipeline fully complete

    // ------------------------------------------------------------
    // DEBUG STATE OUTPUT
    // ------------------------------------------------------------
    SchedState &STATE // [OUTPUT] Current scheduler state
) {

#pragma HLS array_partition variable = head_ctx_ref complete dim = 1

  // Core FSM state
  static SchedState st;
#pragma HLS reset variable = st
  static int layer_idx;
#pragma HLS reset variable = layer_idx

  // One-shot guards for start pulses in each state
  static bool attn_started;
#pragma HLS reset variable = attn_started
  static bool attn_done;
#pragma HLS reset variable = attn_done
  static bool attn_compute_done;
#pragma HLS reset variable = attn_compute_done
  static bool concat_compute_done;
#pragma HLS reset variable = concat_compute_done
  static bool outproj_compute_done;
#pragma HLS reset variable = outproj_compute_done
  static bool resid0_compute_done;
#pragma HLS reset variable = resid0_compute_done
  static bool ln0_compute_done;
#pragma HLS reset variable = ln0_compute_done
  static bool ffn_w1_compute_done;
#pragma HLS reset variable = ffn_w1_compute_done
  static bool ffn_act_compute_done;
#pragma HLS reset variable = ffn_act_compute_done
  static bool ffn_w2_compute_done;
#pragma HLS reset variable = ffn_w2_compute_done
  static bool resid1_compute_done;
#pragma HLS reset variable = resid1_compute_done
  static bool ln1_compute_done;
#pragma HLS reset variable = ln1_compute_done


// HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static bool attn_group_done;
#pragma HLS reset variable = attn_group_done
  static int group_idx;
#pragma HLS reset variable = group_idx
  static bool start_head_group;
#pragma HLS reset variable = start_head_group
// HEADED ATTENTION DATA~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  static bool concat_started;
#pragma HLS reset variable = concat_started
  static bool outproj_started;
#pragma HLS reset variable = outproj_started
  static bool resid0_started;
#pragma HLS reset variable = resid0_started
  static bool ln0_started;
#pragma HLS reset variable = ln0_started
  enum class FfnStage : uint8_t { W1 = 0, ACT, W2 };
  static FfnStage ffn_stage;
#pragma HLS reset variable = ffn_stage
  static bool ffn_started;
#pragma HLS reset variable = ffn_started
  static bool resid1_started;
#pragma HLS reset variable = resid1_started
  static bool ln1_started;
#pragma HLS reset variable = ln1_started
  static bool stream_started;
#pragma HLS reset variable = stream_started
  static int wo_tile;
#pragma HLS reset variable = wo_tile
  static bool wo_dma_busy;
#pragma HLS reset variable = wo_dma_busy
  static bool wo_comp_busy;
#pragma HLS reset variable = wo_comp_busy
  static int w1_tile;
#pragma HLS reset variable = w1_tile
  static bool w1_dma_busy;
#pragma HLS reset variable = w1_dma_busy
  static bool w1_comp_busy;
#pragma HLS reset variable = w1_comp_busy
  static int w2_tile;
#pragma HLS reset variable = w2_tile
  static bool w2_dma_busy;
#pragma HLS reset variable = w2_dma_busy
  static bool w2_comp_busy;
#pragma HLS reset variable = w2_comp_busy

  const bool reset = !cntrl_reset_n;
  if (reset) {
    st = S_IDLE;
    layer_idx = 0;

    // Attention
    attn_started = false;
    attn_done = false;
    attn_compute_done = false;
    attn_group_done = false;
    group_idx = 0;

    start_head_group = false;
    for (int i = 0; i < NUM_HEADS; ++i){
#pragma HLS UNROLL
        init_head_ctx(head_ctx_ref[i], -1);
    }
    


    // Head concat
    concat_compute_done = false;
    concat_started = false;

    // Output projection
    outproj_started = false;
    outproj_compute_done = false;

    // Residual + LN (1st)
    resid0_started = false;
    resid0_compute_done = false;
    ln0_started = false;
    ln0_compute_done = false;

    // FFN
    ffn_w1_compute_done = false;
    ffn_act_compute_done = false;
    ffn_w2_compute_done = false;
    ffn_stage = FfnStage::W1;
    ffn_started = false;

    // Residual + LN (2nd)
    resid1_started = false;
    resid1_compute_done = false;
    ln1_started = false;
    ln1_compute_done = false;

    // Global progress/tiles
    stream_started = false;
    wo_tile = 0;
    wo_dma_busy = false;
    wo_comp_busy = false;
    w1_tile = 0;
    w1_dma_busy = false;
    w1_comp_busy = false;
    w2_tile = 0;
    w2_dma_busy = false;
    w2_comp_busy = false;
  }

  // Default outputs
  cntrl_layer_idx = layer_idx;
  axis_in_ready = 0;
  wl_start = 0;
  wl_addr_sel = 0;
  wl_layer = layer_idx;
  wl_head = 0;
  wl_tile = 0;
  compute_start = 0;
  compute_op = CMP_NONE;
  requant_start = 0;
  requant_op = RQ_NONE;
  stream_start = 0;
  done = 0;
  cntrl_busy = (st != S_IDLE);
  // Expose a start bit that auto-clears once we leave IDLE
  cntrl_start_out = (st == S_IDLE) ? cntrl_start : false;

  if (reset) {
    STATE = st;
    return;
  }

  if (compute_done) {
    if (st == S_ATTENTION_HEADS && attn_started)
      attn_compute_done = true;
    if (st == S_HEAD_CONCAT && concat_started)
      concat_compute_done = true;
    if (st == S_OUT_PROJECTION && outproj_started)
      outproj_compute_done = true;
    if (st == S_RES_ADD_1 && resid0_started)
      resid0_compute_done = true;
    if (st == S_LAYER_NORM_1 && ln0_started)
      ln0_compute_done = true;
    if (st == S_FFN && ffn_started) {
      if (ffn_stage == FfnStage::W1)
        ffn_w1_compute_done = true;
      else if (ffn_stage == FfnStage::ACT)
        ffn_act_compute_done = true;
      else if (ffn_stage == FfnStage::W2)
        ffn_w2_compute_done = true;
    }
    if (st == S_RES_ADD_2 && resid1_started)
      resid1_compute_done = true;
    if (st == S_LAYER_NORM_2 && ln1_started)
      ln1_compute_done = true;
  }

  switch (st) {
  case S_IDLE:
    if (cntrl_start) {
      st = S_STREAM_IN;

      // Attention
      attn_started = false;
      attn_done = false;
      attn_compute_done = false;
      attn_group_done = false;
      group_idx = 0;
      start_head_group = false;

      // Head concat
      concat_started = false;
      concat_compute_done = false;

      // Output projection
      outproj_started = false;
      outproj_compute_done = false;

      // Residual + LN (1st)
      resid0_started = false;
      resid0_compute_done = false;
      ln0_started = false;
      ln0_compute_done = false;

      // FFN
      ffn_started = false;
      ffn_w1_compute_done = false;
      ffn_act_compute_done = false;
      ffn_w2_compute_done = false;

      // Residual + LN (2nd)
      resid1_started = false;
      resid1_compute_done = false;
      ln1_started = false;
      ln1_compute_done = false;

      // Global progress/tiles
      stream_started = false;
      wo_tile = 0;
      wo_dma_busy = false;
      wo_comp_busy = false;
      w1_tile = 0;
      w1_dma_busy = false;
      w1_comp_busy = false;
      w2_tile = 0;
      w2_dma_busy = false;
      w2_comp_busy = false;
    }
    break;

  case S_STREAM_IN:
    axis_in_ready = 1;
    // Wait for ingress token with tlast before starting layer processing
    if (axis_in_valid && axis_in_last) {
      st = S_LAYER_COUNT;
    }
    break;

  case S_LAYER_COUNT:
    // Reset per-layer guards
    // Attention
    attn_started = false;
    attn_compute_done = false;
    attn_done = false;
    attn_group_done = false;
    group_idx = 0;

    start_head_group = true;
    for (int i = 0; i < NUM_HEADS; ++i){
#pragma HLS UNROLL
        init_head_ctx(head_ctx_ref[i], layer_idx);
    }

    // Head concat
    concat_started = false;
    concat_compute_done = false;

    // Output projection
    outproj_started = false;
    outproj_compute_done = false;

    // Residual + LN (1st)
    resid0_started = false;
    resid0_compute_done = false;
    ln0_started = false;
    ln0_compute_done = false;

    // FFN
    ffn_stage = FfnStage::W1;
    ffn_started = false;
    ffn_w1_compute_done = false;
    ffn_act_compute_done = false;
    ffn_w2_compute_done = false;

    // Residual + LN (2nd)
    resid1_started = false;
    resid1_compute_done = false;
    ln1_started = false;
    ln1_compute_done = false;

    // Global progress/tiles
    wo_tile = 0;
    wo_dma_busy = false;
    wo_comp_busy = false;
    w1_tile = 0;
    w1_dma_busy = false;
    w1_comp_busy = false;
    w2_tile = 0;
    w2_dma_busy = false;
    w2_comp_busy = false;
    st = S_ATTENTION_HEADS;

    break;

  case S_ATTENTION_HEADS: {
    // Multiple, parallel attention

    const int group_base = group_idx * HEADS_PARALLEL;
    HeadCtx head_group[HEADS_PARALLEL];
#pragma HLS ARRAY_PARTITION variable = head_group complete dim = 1

    // Slice the active group from the full context
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
      const int h = group_base + lane;
      if (h < NUM_HEADS) {
        head_group[lane] = head_ctx_ref[h];
      } else {
        init_head_ctx(head_group[lane], layer_idx);
        head_group[lane].phase = HeadPhase::DONE;
      }
    }

    // Drive current head group; compute handshake handled externally
    attn_group_done =
        drive_group_head_phase(head_group, group_base, layer_idx, start_head_group);

    // Copy results back into the full context
    for (int lane = 0; lane < HEADS_PARALLEL; ++lane) {
#pragma HLS UNROLL
        const int h = group_base + lane;
        if (h < NUM_HEADS) {
          head_ctx_ref[h] = head_group[lane];
        }
      }
      

    // Kick off the first group as soon as we enter this state
    if (!attn_started) {
      attn_started = true;
      start_head_group = true;
    }

    // When a group finishes, advance to the next
    if (attn_started){
      if (attn_group_done) {
        group_idx++;
        start_head_group = true;
        if (group_idx >= NUM_HEAD_GROUPS) {
          attn_started = false;
          group_idx = 0;
          start_head_group = false;
          st = S_HEAD_CONCAT;
        }
      }else{
        start_head_group = false;
      }
    }
    
    break;
  }

  case S_HEAD_CONCAT:
    if (!concat_started && compute_ready) {
      concat_compute_done = false;
      compute_start = 1;
      compute_op = CMP_CONCAT;
      concat_started = true;
    } else if (concat_started && concat_compute_done) {
      concat_started = false;
      concat_compute_done = false;
      st = S_OUT_PROJECTION;
    }
    break;

  case S_OUT_PROJECTION:
    if (wo_tile >= NUM_WO_TILES) {
      resid0_started = false;
      st = S_RES_ADD_1;
      break;
    }

    if (!outproj_started && wl_ready) {
      wl_start = 1;
      wl_addr_sel = DMASEL_WO;
      wl_head = -1;
      wl_tile = wo_tile;
      wo_dma_busy = true;
      outproj_started = true;
    } else if (outproj_started && wo_dma_busy && dma_done) {
      wo_dma_busy = false;
      wo_comp_busy = true;
    } else if (outproj_started && wo_comp_busy && compute_ready) {
      outproj_compute_done = false;
      compute_start = 1;
      compute_op = CMP_OUT_PROJ;
      wo_comp_busy = false;
    } else if (outproj_started && !wo_dma_busy && !wo_comp_busy &&
               outproj_compute_done) {
      outproj_started = false;
      outproj_compute_done = false;
      wo_tile++;
    }
    break;

  case S_RES_ADD_1:
    if (!resid0_started && compute_ready) {
      resid0_compute_done = false;
      compute_start = 1;
      compute_op = CMP_RESID0;
      resid0_started = true;
    } else if (resid0_started && resid0_compute_done) {
      resid0_started = false;
      resid0_compute_done = false;
      st = S_LAYER_NORM_1;
    }
    break;

  case S_LAYER_NORM_1:
    if (!ln0_started && compute_ready) {
      ln0_compute_done = false;
      compute_start = 1;
      compute_op = CMP_LN0;
      ln0_started = true;
    } else if (ln0_started && ln0_compute_done) {
      ln0_started = false;
      ln0_compute_done = false;
      st = S_FFN;
    }
    break;

  case S_FFN:
    // Serialize W1 -> ACT -> W2
    switch (ffn_stage) {
    case FfnStage::W1:
      if (w1_tile >= NUM_W1_TILES) {
        ffn_started = false;
        ffn_stage = FfnStage::ACT;
        break;
      }

      if (!ffn_started && wl_ready) {
        wl_start = 1;
        wl_addr_sel = DMASEL_W1;
        wl_head = -1;
        wl_tile = w1_tile;
        w1_dma_busy = true;
        ffn_started = true;
      } else if (ffn_started && w1_dma_busy && dma_done) {
        w1_dma_busy = false;
        w1_comp_busy = true;
      } else if (ffn_started && w1_comp_busy && compute_ready) {
        ffn_w1_compute_done = false;
        compute_start = 1;
        compute_op = CMP_FFN_W1;
        w1_comp_busy = false;
      } else if (ffn_started && !w1_dma_busy && !w1_comp_busy &&
                 ffn_w1_compute_done) {
        ffn_started = false;
        ffn_w1_compute_done = false;
        w1_tile++;
      }
      break;
    case FfnStage::ACT:
      if (!ffn_started && compute_ready) {
        ffn_act_compute_done = false;
        compute_start = 1;
        compute_op = CMP_FFN_ACT;
        ffn_started = true;
      } else if (ffn_started && ffn_act_compute_done) {
        ffn_started = false;
        ffn_act_compute_done = false;
        ffn_stage = FfnStage::W2;
      }
      break;
    case FfnStage::W2:
      if (w2_tile >= NUM_W2_TILES) {
        ffn_started = false;
        ffn_stage = FfnStage::W1;
        st = S_RES_ADD_2;
        break;
      }

      if (!ffn_started && wl_ready) {
        wl_start = 1;
        wl_addr_sel = DMASEL_W2;
        wl_head = -1;
        wl_tile = w2_tile;
        w2_dma_busy = true;
        ffn_started = true;
      } else if (ffn_started && w2_dma_busy && dma_done) {
        w2_dma_busy = false;
        w2_comp_busy = true;
      } else if (ffn_started && w2_comp_busy && compute_ready) {
        ffn_w2_compute_done = false;
        compute_start = 1;
        compute_op = CMP_FFN_W2;
        w2_comp_busy = false;
      } else if (ffn_started && !w2_dma_busy && !w2_comp_busy &&
                 ffn_w2_compute_done) {
        ffn_started = false;
        ffn_w2_compute_done = false;
        w2_tile++;
      }
      break;
    }
    break;

  case S_RES_ADD_2:
    if (!resid1_started && compute_ready) {
      resid1_compute_done = false;
      compute_start = 1;
      compute_op = CMP_RESID1;
      resid1_started = true;
    } else if (resid1_started && resid1_compute_done) {
      resid1_started = false;
      resid1_compute_done = false;
      st = S_LAYER_NORM_2;
    }
    break;

  case S_LAYER_NORM_2:
    if (!ln1_started && compute_ready) {
      ln1_compute_done = false;
      compute_start = 1;
      compute_op = CMP_LN1;
      ln1_started = true;
    } else if (ln1_started && ln1_compute_done) {
      ln1_started = false;
      ln1_compute_done = false;
      st = S_LOOP_CHECK;
    }
    break;

  case S_LOOP_CHECK:
    if (layer_idx + 1 < NUM_LAYERS) {
      layer_idx++;
      st = S_LAYER_COUNT;
    } else {
      st = S_STREAM_OUT;
      stream_started = false;
    }
    break;

  case S_STREAM_OUT:
    if (!stream_started && stream_ready) {
      stream_start = 1;
      stream_started = true;
    } else if (stream_started && stream_done) {
      stream_started = false;
      done = 1;
      st = S_IDLE;
    }
    break;
  }

  STATE = st;
}
