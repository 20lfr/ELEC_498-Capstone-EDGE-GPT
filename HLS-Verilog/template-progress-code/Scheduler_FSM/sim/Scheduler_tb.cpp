#include <array>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include <iostream>

#include "../Scheduler_FSM.hpp"
#include "Scheduler_tb.hpp"

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

const char *requant_op_name(int op_raw) {
    const RequantOp op = static_cast<RequantOp>(op_raw);
    switch (op) {
        case RQ_NONE:  return "RQ_NONE";
        case RQ_K:     return "RQ_K";
        case RQ_V:     return "RQ_V";
        case RQ_Q:     return "RQ_Q";
        case RQ_FINAL: return "RQ_FINAL";
        default:       return "UNK";
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

bool dma_selector_required(DmaSel sel) {
    switch (sel) {
        case DMASEL_K_WRITE:
        case DMASEL_V_WRITE:
            return false; // K/V writeback skipped in current configuration
        default:
            return true;
    }
}

bool compute_op_required(ComputeOp op) {
    switch (op) {
        case CMP_HEAD_REQUANT:
            return false;
        default:
            return true;
    }
}

} // namespace

int run_scheduler_tb(const char *variant_name,
                     int         dma_latency_cycles,
                     int         compute_latency_cycles,
                     int         requant_latency_cycles) {
    constexpr int   MAX_CYCLES   = 4000;
    constexpr int   AXIS_TOKENS  = 4;
    constexpr size_t DMASEL_COUNT = static_cast<size_t>(DMASEL_WLOGIT) + 1;
    constexpr size_t CMP_COUNT    = static_cast<size_t>(CMP_LOGITS) + 1;
    constexpr size_t RQ_COUNT     = static_cast<size_t>(RQ_FINAL) + 1;

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

    bool requant_ready = true;
    bool requant_done  = false;
    bool requant_start = false;
    int  requant_op    = RQ_NONE;

    bool stream_ready = true;
    bool stream_start = false;
    bool stream_done  = false;

    bool done = false;
    SchedState STATE = S_IDLE;

    bool dma_busy          = false;
    int  dma_latency       = 0;
    bool comp_busy         = false;
    int  comp_latency      = 0;
    bool stream_busy       = false;
    bool pending_stream_pulse = false;
    bool requant_busy      = false;
    int  requant_latency   = 0;

    bool finish_requested = false;
    bool completed        = false;

    bool prev_wl_start    = false;
    int  prev_wl_addr_sel = 0;

    bool prev_compute_start = false;
    int  prev_compute_op    = CMP_NONE;

    bool prev_stream_start = false;

    bool prev_requant_start = false;
    int  prev_requant_op    = RQ_NONE;

    std::array<bool, DMASEL_COUNT> dma_seen{};
    std::array<bool, CMP_COUNT>    comp_seen{};
    std::array<bool, RQ_COUNT>     requant_seen{};
    std::vector<int> dma_history;
    std::vector<int> comp_history;
    std::vector<int> requant_history;

    std::printf("Scheduler TB Variant: %s (DMA=%d, Compute=%d, Requant=%d)\n",
                variant_name,
                dma_latency_cycles,
                compute_latency_cycles,
                requant_latency_cycles);
    std::printf("%-8s %-6s %-6s %-6s | %-18s %-10s %-8s %-8s %-14s %-8s %-14s %-8s\n",
                "Cycle",
                "Start",
                "Reset",
                "Layer",
                "State",
                "DMAReq",
                "DMAUse",
                "DMADone",
                "ComputeOp",
                "CmpDone",
                "RequantOp",
                "RqDone");

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        if (prev_wl_start) {
            dma_history.push_back(prev_wl_addr_sel);
            dma_busy          = true;
            dma_latency       = dma_latency_cycles;
            const int idx = prev_wl_addr_sel;
            if (idx >= 0 && static_cast<size_t>(idx) < DMASEL_COUNT)
                dma_seen[idx] = true;
            prev_wl_start = false;
        }

        if (prev_compute_start) {
            comp_history.push_back(prev_compute_op);
            comp_latency = compute_latency_cycles;
            comp_busy    = true;
            const int idx = prev_compute_op;
            if (idx >= 0 && static_cast<size_t>(idx) < CMP_COUNT)
                comp_seen[idx] = true;
            prev_compute_start = false;
        }

        if (prev_stream_start) {
            pending_stream_pulse = true;
            stream_busy          = true;
            prev_stream_start    = false;
        }

        if (prev_requant_start) {
            requant_history.push_back(prev_requant_op);
            requant_latency = requant_latency_cycles;
            requant_busy    = true;
            const int idx = prev_requant_op;
            if (idx >= 0 && static_cast<size_t>(idx) < RQ_COUNT)
                requant_seen[idx] = true;
            prev_requant_start = false;
        }

        dma_done     = false;
        stream_done  = pending_stream_pulse;
        pending_stream_pulse = false;
        requant_done = false;

        if (dma_busy) {
            if (dma_latency > 0) {
                dma_latency--;
                if (dma_latency == 0) {
                    dma_done = true;
                }
            }
        }

        if (cycle == 2) {
            cntrl_reset_n = true;
        }

        if (cntrl_reset_n && !finish_requested) {
            cntrl_start = true;
        }

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

        requant_done = false;
        if (requant_busy) {
            if (requant_latency > 0) {
                requant_latency--;
                if (requant_latency == 0) {
                    requant_done = true;
                }
            }
        }

        const bool release_comp_busy    = compute_done;
        const bool release_requant_busy = requant_done;

        if (dma_done)
            dma_busy = false;
        if (stream_done)
            stream_busy = false;

        wl_ready     = !dma_busy;
        compute_ready= !comp_busy;
        stream_ready = !stream_busy;
        requant_ready= !requant_busy;

        if (!axis_feed_done && cntrl_start && cntrl_reset_n) {
            axis_in_valid = true;
            axis_in_last  = (axis_sent == AXIS_TOKENS - 1);
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        const bool curr_wl_ready      = wl_ready;
        const bool curr_compute_ready = compute_ready;
        const bool curr_stream_ready  = stream_ready;
        const bool curr_requant_ready = requant_ready;

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
            requant_ready,
            requant_done,
            compute_start,
            compute_op,
            requant_start,
            requant_op,
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

        if (done && !finish_requested) {
            finish_requested = true;
            cntrl_start      = false;
        } else if (finish_requested) {
            cntrl_start = false;
        }

        const char *cycle_dma       = wl_start ? dma_sel_name(wl_addr_sel) : "-";
        const char *cycle_compute   = compute_start ? compute_op_name(compute_op) : "-";
        const char *cycle_requant   = requant_start ? requant_op_name(requant_op) : "-";
        const char *cycle_dma_busy  = dma_busy ? "1" : "-";
        const char *cycle_dma_done  = dma_done ? "1" : "-";
        const char *cycle_comp_done = compute_done ? "1" : "-";
        const char *cycle_rq_done   = requant_done ? "1" : "-";
        std::printf("%-8d %-6d %-6d %-6u | %-18s %-10s %-8s %-8s %-14s %-8s %-14s %-8s\n",
                    cycle,
                    static_cast<int>(cntrl_start),
                    static_cast<int>(cntrl_reset_n),
                    cntrl_layer_idx,
                    state_name(STATE),
                    cycle_dma,
                    cycle_dma_busy,
                    cycle_dma_done,
                    cycle_compute,
                    cycle_comp_done,
                    cycle_requant,
                    cycle_rq_done);

        if (wl_start) {
            if (!curr_wl_ready) {
                std::fprintf(stderr,
                             "ERROR: wl_start asserted without wl_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            prev_wl_start    = true;
            prev_wl_addr_sel = wl_addr_sel;
        }

        if (compute_start) {
            if (!curr_compute_ready) {
                std::fprintf(stderr,
                             "ERROR: compute_start asserted without compute_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            prev_compute_start = true;
            prev_compute_op    = compute_op;
        }

        if (stream_start) {
            if (!curr_stream_ready) {
                std::fprintf(stderr,
                             "ERROR: stream_start asserted without stream_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            prev_stream_start = true;
        }

        if (requant_start) {
            if (!curr_requant_ready) {
                std::fprintf(stderr,
                             "ERROR: requant_start asserted without requant_ready on cycle %d\n",
                             cycle);
                return EXIT_FAILURE;
            }
            prev_requant_start = true;
            prev_requant_op    = requant_op;
        }

        if (release_comp_busy)
            comp_busy = false;
        if (release_requant_busy)
            requant_busy = false;

        if (done && !cntrl_start && !dma_busy && !comp_busy && !stream_busy && !requant_busy) {
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
        if (!dma_selector_required(static_cast<DmaSel>(i)))
            continue;
        if (!dma_seen[i]) {
            dma_ok = false;
            std::fprintf(stderr, "Missing DMA selector: %s\n",
                         dma_sel_name(static_cast<int>(i)));
        }
    }

    bool comp_ok = true;
    for (size_t i = 1; i < CMP_COUNT; ++i) { // Skip CMP_NONE
        if (!compute_op_required(static_cast<ComputeOp>(i)))
            continue;
        if (!comp_seen[i]) {
            comp_ok = false;
            std::fprintf(stderr, "Missing compute op: %s\n",
                         compute_op_name(static_cast<int>(i)));
        }
    }

    bool requant_ok = true;
    for (size_t i = 1; i < RQ_COUNT; ++i) { // Skip RQ_NONE
        if (!requant_seen[i]) {
            requant_ok = false;
            std::fprintf(stderr, "Missing requant op: %s\n",
                         requant_op_name(static_cast<int>(i)));
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

    std::printf("\nRequant ops observed: %zu\n", requant_history.size());
    for (size_t i = 0; i < requant_history.size(); ++i) {
        std::printf("  #%03zu -> %s\n", i, requant_op_name(requant_history[i]));
    }

    if (!dma_ok || !comp_ok || !requant_ok) {
        std::fprintf(stderr, "ERROR: scheduler did not exercise all expected steps.\n");
        return EXIT_FAILURE;
    }

    std::puts("\nScheduler testbench completed successfully.");
    return EXIT_SUCCESS;
}
