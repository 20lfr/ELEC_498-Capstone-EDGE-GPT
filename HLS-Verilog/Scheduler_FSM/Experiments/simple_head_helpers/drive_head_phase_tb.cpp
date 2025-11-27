// Testbench for drive_head_phase: exercises grouped heads through all phases.
#include <array>
#include <cassert>
#include <iomanip>
#include <iostream>
#include <string>

#include "simple_head_helpers.hpp"

static const char* phase_str(HeadPhase phase) {
    switch (phase) {
        case HeadPhase::IDLE: return "IDLE";
        case HeadPhase::Q: return "Q";
        case HeadPhase::K: return "K";
        case HeadPhase::K_REQUANT: return "K_RQ";
        case HeadPhase::K_WRITEBACK: return "K_WB";
        case HeadPhase::V: return "V";
        case HeadPhase::V_REQUANT: return "V_RQ";
        case HeadPhase::V_WRITEBACK: return "V_WB";
        case HeadPhase::REQUANT_Q: return "RQ_Q";
        case HeadPhase::ATT_SCORES: return "ATT_SCO";
        case HeadPhase::VALUE_SCALE_CLAMP: return "VAL_SCL";
        case HeadPhase::ATT_SOFTMAX: return "SOFT";
        case HeadPhase::ATT_VALUE: return "ATT_VAL";
        case HeadPhase::REQUANT2: return "RQ2";
        case HeadPhase::DONE: return "DONE";
        default: return "?";
    }
}

static const char* op_str(int op) {
    switch (op) {
        case CMP_Q: return "Q";
        case CMP_K: return "K";
        case CMP_V: return "V";
        case CMP_ATT_SCORES: return "SCO";
        case CMP_VALUE_SCALE: return "SCL";
        case CMP_SOFTMAX: return "SFM";
        case CMP_ATT_VALUE: return "VAL";
        default: return "-";
    }
}

int main() {
    constexpr int HEADS_TOTAL = NUM_HEADS;
    constexpr int PAR = HEADS_PARALLEL;
    constexpr int GROUPS = (HEADS_TOTAL + PAR - 1) / PAR;
    constexpr int NUM_LAYERS = 1; // adjust if you want to iterate layers

    HeadCtx head_ctx[HEADS_TOTAL];
    for (int h = 0; h < HEADS_TOTAL; ++h) init_head_ctx(head_ctx[h], 0);

    // Per-head compute models (use arrays to avoid vector<bool> proxy references)
    std::array<int, HEADS_TOTAL> busy_ctr{};

    std::cout << std::left << std::setw(6) << "cycle";
    for (int h = 0; h < HEADS_TOTAL; ++h) {
        std::string hdr = "h" + std::to_string(h) + "_phase";
        std::cout << "|" << std::setw(12) << hdr
                  << "|" << std::setw(4) << "hstrt"
                  << "|" << std::setw(4) << "rdy"
                  << "|" << std::setw(4) << "done"
                  << "|" << std::setw(6) << "start"
                  << "|" << std::setw(4) << "op"
                  << "  ";
    }
    std::cout << "\n";

    bool all_done = false;
    int layer_idx = 0;
    int cycle = 0;
    int group_idx = 0;

    // Start each group sequentially; only the active group gets ready/done pulses.
    while (!all_done && layer_idx < NUM_LAYERS && cycle < 512) {
        const int group_base = group_idx * PAR;

        // Default all compute signals low
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            head_ctx[h].compute_ready = false;
            head_ctx[h].compute_done  = false;
        }

        // Drive compute_ready/done for the active group only
        for (int lane = 0; lane < PAR; ++lane) {
            const int h = group_base + lane;
            if (h >= HEADS_TOTAL) break;
            head_ctx[h].compute_ready = (busy_ctr[h] == 0);
            head_ctx[h].compute_done  = (busy_ctr[h] == 1);
            if (busy_ctr[h] > 0) busy_ctr[h]--;
        }

        // Start pulse for any idle head in the active group
        bool start_pulse = false;
        for (int lane = 0; lane < PAR; ++lane) {
            const int h = group_base + lane;
            if (h >= HEADS_TOTAL) break;
            if (head_ctx[h].phase == HeadPhase::IDLE) {
                start_pulse = true;
                break;
            }
        }

        // Call the grouped driver for the active group
        bool group_finished = drive_group_head_phase(
            head_ctx,
            group_idx,
            layer_idx,
            start_pulse);

        // Log activity for this cycle (columns per head)
        std::cout << std::left << std::setw(6) << cycle;
        for (int h = 0; h < HEADS_TOTAL; ++h) {
            std::cout << "|"
                      << std::setw(12) << phase_str(head_ctx[h].phase)
                      << "|" << std::setw(4) << (head_ctx[h].start_head ? "1" : "-")
                      << "|" << std::setw(4) << (head_ctx[h].compute_ready ? "1" : "-")
                      << "|" << std::setw(4) << (head_ctx[h].compute_done ? "1" : "-")
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

        // If the active group finished, move to next
        if (group_finished) {
            group_idx++;
            if (group_idx >= GROUPS) {
                all_done = true;
            }
        }

        cycle++;
    }

    for (int h = 0; h < HEADS_TOTAL; ++h) {
        assert(head_ctx[h].phase == HeadPhase::DONE && "head did not reach DONE");
    }

    std::cout << "drive_head_phase test complete.\n";
    return 0;
}
