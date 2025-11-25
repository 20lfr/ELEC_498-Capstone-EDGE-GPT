// Minimal testbench for Simple_Scheduler_FSM.
// Mirrors the style of Scheduler_tb_minimal.cpp but against the simplified scheduler interface.
#include <cstdio>
#include <cstdint>
#include <string>

#include "Simple_Scheduler_FSM.hpp"

static const char *state_name(SchedState st) {
    switch (st) {
    case S_IDLE:            return "S_IDLE";
    case S_STREAM_IN:       return "S_STREAM_IN";
    case S_LAYER_COUNT:     return "S_LAYER_COUNT";
    case S_ATTENTION_HEADS: return "S_ATT_HEADS";
    case S_HEAD_CONCAT:     return "S_HEAD_CONCAT";
    case S_OUT_PROJECTION:  return "S_OUT_PROJ";
    case S_RES_ADD_1:       return "S_RES_ADD_1";
    case S_LAYER_NORM_1:    return "S_LN_1";
    case S_FFN:             return "S_FFN";
    case S_RES_ADD_2:       return "S_RES_ADD_2";
    case S_LAYER_NORM_2:    return "S_LN_2";
    case S_LOOP_CHECK:      return "S_LOOP_CHECK";
    case S_STREAM_OUT:      return "S_STREAM_OUT";
    default:                return "UNKNOWN";
    }
}

static const char *op_name(int op_raw) {
    const ComputeOp op = static_cast<ComputeOp>(op_raw);
    switch (op) {
    case CMP_NONE:         return "NONE";
    case CMP_Q:            return "Q";
    case CMP_K:            return "K";
    case CMP_V:            return "V";
    case CMP_ATT_SCORES:   return "ATT_SCORES";
    case CMP_VALUE_SCALE:  return "VALUE_SCALE";
    case CMP_SOFTMAX:      return "SOFTMAX";
    case CMP_ATT_VALUE:    return "ATT_VALUE";
    case CMP_CONCAT:       return "CONCAT";
    case CMP_OUT_PROJ:     return "OUT_PROJ";
    case CMP_RESID0:       return "RESID0";
    case CMP_LN0:          return "LN0";
    case CMP_FFN_W1:       return "FFN_W1";
    case CMP_FFN_ACT:      return "FFN_ACT";
    case CMP_FFN_W2:       return "FFN_W2";
    case CMP_RESID1:       return "RESID1";
    case CMP_LN1:          return "LN1";
    default:               return "UNK";
    }
}

int main() {
    const int MAX_CYCLES = 600;
    const int COMP_LAT   = 3;
    const int AXIS_BEATS = 3;

    bool cntrl_start     = false;
    bool cntrl_reset_n   = false;
    uint32_t cntrl_layer_idx = 0;
    bool cntrl_busy      = false;
    bool cntrl_start_out = false;

    bool wl_ready        = true;
    bool wl_start        = false;
    int  wl_addr_sel     = 0;
    int  wl_layer        = 0;
    int  wl_head         = 0;
    int  wl_tile         = 0;
    bool dma_done        = false;

    bool axis_in_valid   = false;
    bool axis_in_last    = false;
    bool axis_in_ready   = false;
    int  axis_sent       = 0;
    bool axis_feed_done  = false;
    bool axis_drive      = false;

    bool compute_ready   = true;
    bool compute_done    = false;
    bool compute_start   = false;
    int  compute_op      = CMP_NONE;

    bool requant_ready   = true;
    bool requant_done    = false;
    bool requant_start   = false;
    int  requant_op      = RQ_NONE;

    bool stream_ready    = true;
    bool stream_start    = false;
    bool stream_done     = false;

    bool done            = false;
    SchedState STATE     = S_IDLE;

    bool comp_busy       = false;
    int  comp_timer      = 0;
    bool stream_busy     = false;
    bool start_pulsed    = false;
    bool seen_done       = false;
    int  post_done_cycles= 0;
    bool seen_idle_after = false;
    bool seen_attn       = false;
    bool seen_concat     = false;

    std::printf("%-8s %-6s %-6s %-8s | %-16s %-10s %-10s %-10s %-10s %-10s %-10s %-s\n",
                "Cycle", "Start", "Reset", "Busy", "State",
                "AXIS_v", "AXIS_r", "AXIS_last",
                "CmpStart", "CmpReady", "CmpDone", "CmpOp");

    auto dash_or = [](bool v) { return v ? "1" : "-"; };

    for (int cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        // Simple reset release at cycle 2
        if (cycle == 2) cntrl_reset_n = true;
        // Issue a single-cycle start pulse once after reset deasserts
        if (cntrl_reset_n && !start_pulsed) {
            cntrl_start = true;
            start_pulsed = true;
        } else if (cntrl_busy) {
            cntrl_start = false;
        }

        // Complete outstanding compute operations
        compute_done = false;
        if (comp_busy) {
            if (comp_timer == 0) {
                compute_done = true;
                comp_busy    = false;
            } else {
                --comp_timer;
            }
        }

        // Stream completion: single-cycle pulse after start
        stream_done = false;
        if (stream_busy) {
            stream_done = true;
            stream_busy = false;
        }

        // Ready signals depend on busy flags
        compute_ready = !comp_busy && !compute_done;
        stream_ready  = !stream_busy;
        wl_ready      = ((cycle % 9) != 0);
        requant_ready = true;

        // Drive AXIS ingress: send a short burst when ready is asserted
        if (!axis_feed_done && (axis_drive || (cntrl_reset_n && start_pulsed))) {
            axis_drive = true;
            if (!axis_in_valid && axis_in_ready) {
                axis_in_valid = true;
                axis_in_last  = (axis_sent == AXIS_BEATS - 1);
            }
        } else {
            axis_in_valid = false;
            axis_in_last  = false;
        }

        scheduler_hls(
            cntrl_start,
            cntrl_reset_n,
            cntrl_layer_idx,
            cntrl_busy,
            cntrl_start_out,
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

        std::printf("%-8d %-6d %-6d %-8s | %-16s %-10s %-10s %-10s %-10s %-10s %-10s %-s\n",
                    cycle,
                    cntrl_start ? 1 : 0,
                    cntrl_reset_n ? 1 : 0,
                    dash_or(cntrl_busy),
                    state_name(STATE),
                    dash_or(axis_in_valid),
                    dash_or(axis_in_ready),
                    dash_or(axis_in_last),
                    dash_or(compute_start),
                    dash_or(compute_ready),
                    dash_or(compute_done),
                    (compute_op == CMP_NONE ? "-" : op_name(compute_op)));

        // Latch starts into busy trackers
        if (compute_start) {
            comp_busy  = true;
            comp_timer = COMP_LAT - 1;
            if (compute_op == CMP_ATT_SCORES) seen_attn = true;
            if (compute_op == CMP_CONCAT)     seen_concat = true;
        }
        if (stream_start) {
            stream_busy = true;
        }

        // Consume AXIS transfer on handshake
        if (axis_in_valid && axis_in_ready) {
            axis_sent++;
            axis_in_valid = false;
            axis_in_last  = false;
            if (axis_sent >= AXIS_BEATS) {
                axis_feed_done = true;
                axis_drive     = false;
            }
        }

        if (done) {
            seen_done = true;
            cntrl_start = false;
        }
        if (seen_done){
            post_done_cycles++;
            if (post_done_cycles >= 4) {
                seen_idle_after = true;
            }
        }

        if (!cntrl_busy && !cntrl_start && seen_done && seen_idle_after) {
            break;
        }
    }

    bool ok = seen_done && seen_idle_after && seen_attn && seen_concat;
    if (!ok) {
        if (!seen_done)       std::fprintf(stderr, "ERROR: DONE never asserted\n");
        if (!seen_idle_after) std::fprintf(stderr, "ERROR: FSM did not return to IDLE after DONE\n");
        if (!seen_attn)       std::fprintf(stderr, "ERROR: ATT_SCORES compute op never issued\n");
        if (!seen_concat)     std::fprintf(stderr, "ERROR: CONCAT compute op never issued\n");
        return 1;
    }

    std::printf("PASS: DONE observed and FSM returned to IDLE after %d post-done cycles. Layer=%u\n",
                post_done_cycles, cntrl_layer_idx);
    return 0;
}
