// Minimal C testbench for simple_head_helpers.cpp.
// Exercises a small number of heads, each with its own compute block.
#include <array>
#include <cassert>
#include <iomanip>
#include <iostream>
#include <string>

// Pull in the DUT declarations
#include "simple_head_helpers.hpp"

static const char* phase_str(HeadPhase phase) {
    switch (phase) {
        case HeadPhase::Q: return "Q";
        case HeadPhase::K: return "K";
        case HeadPhase::V: return "V";
        case HeadPhase::DONE: return "DONE";
        default: return "?";
    }
}

static const char* op_str(int op) {
    switch (op) {
        case CMP_Q: return "Q";
        case CMP_K: return "K";
        case CMP_V: return "V";
        default:    return "-";
    }
}

int main() {
    constexpr int HEADS_TOTAL = NUM_HEADS;
    constexpr int PAR = HEADS_PARALLEL;
    constexpr int GROUPS = (HEADS_TOTAL + PAR - 1) / PAR;

    HeadCtx head_ctx[HEADS_TOTAL];
    for (int h = 0; h < HEADS_TOTAL; ++h) init_head_ctx(head_ctx[h], 0);

    // Per-head compute models (use arrays to avoid vector<bool> proxy references)
    std::array<int, HEADS_TOTAL>  busy_ctr{};

    // One row per cycle; each head gets its own set of columns.
    std::cout << std::left << std::setw(6) << "cycle";
    for (int h = 0; h < HEADS_TOTAL; ++h) {
        std::string hdr = "h" + std::to_string(h) + "_phase";
        std::cout << "|" << std::setw(12) << hdr
                  << "|" << std::setw(4) << "rdy"
                  << "|" << std::setw(5) << "done"
                  << "|" << std::setw(6) << "start"
                  << "|" << std::setw(4) << "op"
                  << "  ";
    }
    std::cout << "\n";

    bool all_done = false;
    int  group_idx = 0;

    for (int cycle = 0; cycle < 256 && !all_done; ++cycle) {
        // Drive compute_ready/done based on simple latency counters
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            head_ctx[h].compute_ready = (busy_ctr[h] == 0);
            head_ctx[h].compute_done  = (busy_ctr[h] == 1);
            if (busy_ctr[h] > 0) busy_ctr[h]--;
        }

        // Call the DUT per head (could be #pragma UNROLL in HLS)
        all_done = true;
        bool group_complete = true;
        int group_base = group_idx * PAR;
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            const bool in_group = (h >= group_base) && (h < group_base + PAR);
            // Only allow active group to issue; others hold ready/done low.
            if (!in_group) {
                head_ctx[h].compute_ready = false;
                head_ctx[h].compute_done  = false;
            }

            bool head_done = run_single_head(
                head_ctx[h],
                h,
                0); // layer_idx
            all_done &= head_done;
            if (in_group) group_complete &= head_done;
        }
        if (group_complete && group_idx + 1 < GROUPS) {
            group_idx++;
        }

        // Log activity for this cycle (columns per head)
        std::cout << std::left << std::setw(6) << cycle;
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            std::cout << "|"
                      << std::setw(12) << phase_str(head_ctx[h].phase)
                      << "|" << std::setw(4) << (head_ctx[h].compute_ready ? "1" : "-")
                      << "|" << std::setw(5) << (head_ctx[h].compute_done ? "1" : "-")
                      << "|" << std::setw(6) << (head_ctx[h].compute_start ? "1" : "-")
                      << "|" << std::setw(4) << op_str(head_ctx[h].compute_op)
                      << "  ";
        }
        std::cout << "\n";

        // On compute_start, arm latency counter (simple fixed latency = 3 cycles)
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            if (head_ctx[h].compute_start) {
                busy_ctr[h] = 3;
            }
        }
    }

    // Basic checks
    for (int h = 0; h < HEADS_TOTAL; ++h) {
        assert(head_ctx[h].phase == HeadPhase::DONE && "head did not reach DONE");
        assert(!head_ctx[h].wait_comp && "head still waiting on compute");
    }

    std::cout << "simple_head_helpers test complete.\n";
    return 0;
}
