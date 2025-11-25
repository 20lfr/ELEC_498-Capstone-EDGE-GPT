// Minimal C testbench for simple_head_helpers.cpp.
// Exercises a small number of heads, each with its own compute block.
#include <array>
#include <cassert>
#include <iomanip>
#include <iostream>

// Pull in the DUT declarations
#include "simple_head_helpers.hpp"

static const char* phase_str(int phase) {
    switch (phase) {
        case 0: return "Q";
        case 1: return "K";
        case 2: return "V";
        case 3: return "DONE";
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
    constexpr int HEADS = HEADS_PARALLEL; // simulate two heads by default
    HeadCtx head_ctx[HEADS];
    for (int h = 0; h < HEADS; ++h) init_head_ctx(head_ctx[h], 0);

    // Per-head compute models (use arrays to avoid vector<bool> proxy references)
    std::array<int, HEADS>  busy_ctr{};
    std::array<bool, HEADS> compute_ready{};
    std::array<bool, HEADS> compute_done{};
    std::array<bool, HEADS> compute_start{};
    std::array<int, HEADS>  compute_op{};

    // One row per cycle; each head gets its own set of columns.
    std::cout << std::left << std::setw(6) << "cycle";
    for (int h = 0; h < HEADS; ++h) {
        std::cout << "|" << "h" << h << "_phase" << std::setw(5) << ""
                  << "|" << "rdy"
                  << "|" << "done"
                  << "|" << "start"
                  << "|" << "op ";
    }
    std::cout << "\n";

    bool all_done = false;
    for (int cycle = 0; cycle < 256 && !all_done; ++cycle) {
        // Drive compute_ready/done based on simple latency counters
        for (int h = 0; h < HEADS; ++h) {
            compute_ready[h] = (busy_ctr[h] == 0);
            compute_done[h]  = (busy_ctr[h] == 1);
            if (busy_ctr[h] > 0) busy_ctr[h]--;
        }

        // Call the DUT per head (could be #pragma UNROLL in HLS)
        all_done = true;
        for (int h = 0; h < HEADS; ++h) {
            bool head_done = run_single_head(
                head_ctx[h],
                h,
                0, // layer_idx
                compute_ready[h],
                compute_done[h],
                compute_start[h],
                compute_op[h]);
            all_done &= head_done;
        }

        // Log activity for this cycle (columns per head)
        std::cout << std::left << std::setw(6) << cycle;
        for (int h = 0; h < HEADS; ++h) {
            std::cout << "|"
                      << std::setw(8) << phase_str(head_ctx[h].phase)
                      << "|"
                      << (compute_ready[h] ? "1" : "-") << "  "
                      << "|"
                      << (compute_done[h] ? "1" : "-") << "   "
                      << "|"
                      << (compute_start[h] ? "1" : "-") << "    "
                      << "|"
                      << std::setw(3) << op_str(compute_op[h]);
        }
        std::cout << "\n";

        // On compute_start, arm latency counter (simple fixed latency = 3 cycles)
        for (int h = 0; h < HEADS; ++h) {
            if (compute_start[h]) {
                busy_ctr[h] = 3;
            }
        }
    }

    // Basic checks
    for (int h = 0; h < HEADS; ++h) {
        assert(head_ctx[h].phase == 3 && "head did not reach DONE");
        assert(!head_ctx[h].wait_comp && "head still waiting on compute");
    }

    std::cout << "simple_head_helpers test complete.\n";
    return 0;
}
