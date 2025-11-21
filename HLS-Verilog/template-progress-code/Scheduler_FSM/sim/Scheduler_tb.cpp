#include <array>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include <iostream>

#include "../Scheduler_FSM.hpp"

namespace {

const char *dma_sel_name(int sel_raw) {
    const DmaSel sel = static_cast<DmaSel>(sel_raw);
    switch (sel) {
        case DMASEL_WQ:      return "WQ";
        case DMASEL_WK:      return "WK";
        case DMASEL_WV:      return "WV";
        case DMASEL_CTX_K:   return "CTX_K";
        case DMASEL_CTX_V:   return "CTX_V";
        case DMASEL_K_WRITE: return "K_WR";
        case DMASEL_V_WRITE: return "V_WR";
        case DMASEL_WO:      return "WO";
        case DMASEL_W1:      return "W1";
        case DMASEL_W2:      return "W2";
        case DMASEL_WLOGIT:  return "WLOGIT";
        default:             return "UNK";
    }
}

const char *compute_op_name(int op_raw) {
    const ComputeOp op = static_cast<ComputeOp>(op_raw);
    switch (op) {
        case CMP_NONE:        return "NONE";
        case CMP_Q:           return "Q";
        case CMP_K:           return "K";
        case CMP_V:           return "V";
        case CMP_ATT_SCORES:  return "ATT_SCORES";
        case CMP_VALUE_SCALE: return "VALUE_SCALE";
        case CMP_SOFTMAX:     return "SOFTMAX";
        case CMP_ATT_VALUE:   return "ATT_VALUE";
        case CMP_HEAD_REQUANT:return "HEAD_REQUANT";
        case CMP_CONCAT:      return "CONCAT";
        case CMP_OUT_PROJ:    return "OUT_PROJ";
        case CMP_RESID0:      return "RESID0";
        case CMP_LN0:         return "LN0";
        case CMP_FFN_W1:      return "FFN_W1";
        case CMP_FFN_ACT:     return "FFN_ACT";
        case CMP_FFN_W2:      return "FFN_W2";
        case CMP_RESID1:      return "RESID1";
        case CMP_LN1:         return "LN1";
        case CMP_DEQUANT:     return "DEQUANT";
        case CMP_LOGITS:      return "LOGITS";
        default:              return "UNK";
    }
}

const char *state_name(SchedState st) {
    switch (st) {
        case S_IDLE:          return "S_IDLE";
        case S_START:         return "S_START";
        case S_LAYER_COUNT:   return "S_LAYER_COUNT";
        case S_ATTENTION_HEADS: return "S_ATT_HEADS";
        case S_HEAD_CONCAT:   return "S_HEAD_CONCAT";
        case S_OUT_PROJECTION:return "S_OUT_PROJ";
        case S_RES_ADD_1:     return "S_RES_ADD_1";
        case S_LAYER_NORM_1:  return "S_LN_1";
        case S_FFN:           return "S_FFN";
        case S_RES_ADD_2:     return "S_RES_ADD_2";
        case S_LAYER_NORM_2:  return "S_LN_2";
        case S_LOOP_CHECK:    return "S_LOOP_CHECK";
        case S_STREAM_OUT:    return "S_STREAM_OUT";
        default:              return "UNKNOWN";
    }
}

} // namespace

int main() {
    constexpr int   MAX_CYCLES   = 4000;
    constexpr int   AXIS_TOKENS  = 4;
    constexpr size_t DMASEL_COUNT = static_cast<size_t>(DMASEL_WLOGIT) + 1;
    constexpr size_t CMP_COUNT    = static_cast<size_t>(CMP_LOGITS) + 1;

    bool cntrl_start    = false;
    bool cntrl_reset_n  = false;
    uint32_t cntrl_layer_idx = 0;

    bool axis_in_valid  = false;
    bool axis_in_last   = false;
    bool axis_in_ready  = false;
    int  axis_sent      = 0;
    bool axis_feed_done = false;

    bool wl_ready   = true;
    bool wl_start   = false;
    int  wl_addr_sel= 0;
    int  wl_layer   = 0;
    int  wl_head    = 0;
    int  wl_tile    = 0;
    bool dma_done   = false;

    bool compute_ready = true;
    bool compute_done  = false;
    bool compute_start = false;
    int  compute_op    = CMP_NONE;

    bool stream_ready = true;
    bool stream_start = false;
    bool stream_done  = false;

    bool done = false;
    SchedState STATE = S_IDLE;

    bool dma_busy          = false;
    bool pending_dma_pulse = false;
    bool comp_busy         = false;
    int  comp_latency      = 0;
    bool stream_busy       = false;
    bool pending_stream_pulse = false;

    bool finish_requested = false;
    bool completed        = false;

    std::array<bool, DMASEL_COUNT> dma_seen{};
    std::array<bool, CMP_COUNT>    comp_seen{};
    std::vector<int> dma_history;
    std::vector<int> comp_history;

    std::printf("%-8s %-6s %-6s %-6s | %-12s %-12s %-12s | %-14s\n",
                "Cycle",
                "Start",
                "Reset",
                "Layer",
                "AXIS_valid",
                "AXIS_last",
                "AXIS_ready",
                "State");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        if (cycle == 2) {
            cntrl_reset_n = true;
        }
        if (cntrl_reset_n && !finish_requested) {
            cntrl_start = true;
        }

        dma_done     = pending_dma_pulse;
        stream_done  = pending_stream_pulse;
        pending_dma_pulse    = false;
        pending_stream_pulse = false;

        // SIMULATE LONG COMP TIMES
        compute_done = false;
        if (comp_busy) {
            if (comp_latency > 0) {
                comp_latency--;
                if (comp_latency == 0) {
                    compute_done = true;
                }
            }
        }

        const bool release_comp_busy = compute_done;

        if (dma_done)
            dma_busy = false;
        if (stream_done)
            stream_busy = false;

        wl_ready     = !dma_busy;
        compute_ready= !comp_busy;
        stream_ready = !stream_busy;

        if (!axis_feed_done && cntrl_start && cntrl_reset_n) {
            axis_in_valid = true;
            axis_in_last  = (axis_sent == AXIS_TOKENS - 1);
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        scheduler_hls(
            cntrl_start,
            cntrl_reset_n,
            cntrl_layer_idx,
            axis_in_valid,
            axis_in_last,
            axis_in_ready,
            wl_ready,
            wl_start,
            wl_addr_sel,
            wl_layer,
            wl_head,
            wl_tile,
            dma_done,
            compute_ready,
            compute_done,
            compute_start,
            compute_op,
            stream_ready,
            stream_start,
            stream_done,
            done,
            STATE);

        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            if (axis_sent >= AXIS_TOKENS) {
                axis_feed_done = true;
            }
        }

        if (wl_start) {
            if (!wl_ready) {
                std::fprintf(stderr,
                             "ERROR: wl_start asserted without wl_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            dma_history.push_back(wl_addr_sel);
            pending_dma_pulse = true;
            dma_busy          = true;
            const int idx = wl_addr_sel;
            if (idx >= 0 && static_cast<size_t>(idx) < DMASEL_COUNT)
                dma_seen[idx] = true;
        }

        if (compute_start) {
            if (!compute_ready) {
                std::fprintf(stderr,
                             "ERROR: compute_start asserted without compute_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            comp_history.push_back(compute_op);
            comp_latency      = 2;
            comp_busy         = true;
            const int idx = compute_op;
            if (idx >= 0 && static_cast<size_t>(idx) < CMP_COUNT)
                comp_seen[idx] = true;
        }

        if (stream_start) {
            if (!stream_ready) {
                std::fprintf(stderr,
                             "ERROR: stream_start asserted without stream_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            pending_stream_pulse = true;
            stream_busy          = true;
        }

        if (done && !finish_requested) {
            finish_requested = true;
            cntrl_start      = false;
        } else if (finish_requested) {
            cntrl_start = false;
        }

        std::printf("%-8d %-6d %-6d %-6u | %-12d %-12d %-12d | %-14s\n",
                    cycle,
                    static_cast<int>(cntrl_start),
                    static_cast<int>(cntrl_reset_n),
                    cntrl_layer_idx,
                    static_cast<int>(axis_in_valid),
                    static_cast<int>(axis_in_last),
                    static_cast<int>(axis_in_ready),
                    state_name(STATE));

        if (release_comp_busy)
            comp_busy = false;

        if (done && !cntrl_start && !dma_busy && !comp_busy && !stream_busy) {
            completed = true;
            break;
        }
    }

    if (!completed) {
        std::fprintf(stderr, "ERROR: scheduler did not reach done within %d cycles\n",
                     MAX_CYCLES);
        return EXIT_FAILURE;
    }

    bool dma_ok = true;
    for (size_t i = 0; i < DMASEL_COUNT; ++i) {
        if (!dma_seen[i]) {
            dma_ok = false;
            std::fprintf(stderr, "Missing DMA selector: %s\n",
                         dma_sel_name(static_cast<int>(i)));
        }
    }

    bool comp_ok = true;
    for (size_t i = 1; i < CMP_COUNT; ++i) { // Skip CMP_NONE
        if (!comp_seen[i]) {
            comp_ok = false;
            std::fprintf(stderr, "Missing compute op: %s\n",
                         compute_op_name(static_cast<int>(i)));
        }
    }

    std::printf("\nDMA events observed: %zu\n", dma_history.size());
    for (size_t i = 0; i < dma_history.size(); ++i) {
        std::printf("  #%03zu -> %s\n", i, dma_sel_name(dma_history[i]));
    }

    std::printf("\nCompute ops observed: %zu\n", comp_history.size());
    for (size_t i = 0; i < comp_history.size(); ++i) {
        std::printf("  #%03zu -> %s\n", i, compute_op_name(comp_history[i]));
    }

    if (!dma_ok || !comp_ok) {
        std::fprintf(stderr, "ERROR: scheduler did not exercise all expected steps.\n");
        return EXIT_FAILURE;
    }

    std::puts("\nScheduler testbench completed successfully.");
    return EXIT_SUCCESS;
}
