#include "Scheduler_FSM.hpp"
#include <cassert>
#include <iomanip>
#include <iostream>
#include <vector>

// Convert enums to strings for table output
static const char* phase_str(HeadPhase p) {
    switch (p) {
        case HeadPhase::Q:               return "Q";
        case HeadPhase::K:               return "K";
        case HeadPhase::K_REQUANT:       return "K_RQ";
        case HeadPhase::K_WRITEBACK:     return "K_WB";
        case HeadPhase::V:               return "V";
        case HeadPhase::V_REQUANT:       return "V_RQ";
        case HeadPhase::V_WRITEBACK:     return "V_WB";
        case HeadPhase::REQUANT_Q:       return "RQ_Q";
        case HeadPhase::ATT_SCORES:      return "ATT_S";
        case HeadPhase::VALUE_SCALE_CLAMP:return "SCALE";
        case HeadPhase::ATT_SOFTMAX:     return "SOFT";
        case HeadPhase::ATT_VALUE:       return "ATT_V";
        case HeadPhase::REQUANT2:        return "RQ2";
        case HeadPhase::DONE:            return "DONE";
        default:                         return "?";
    }
}

static const char* compute_str(int op) {
    switch (op) {
        case CMP_Q:             return "Q";
        case CMP_K:             return "K";
        case CMP_V:             return "V";
        case CMP_ATT_SCORES:    return "ATT_S";
        case CMP_VALUE_SCALE:   return "SCALE";
        case CMP_SOFTMAX:       return "SOFT";
        case CMP_ATT_VALUE:     return "ATT_V";
        default:                return "";
    }
}

// Pretty print table header
void print_header(int heads_in_group) {
    std::cout << std::left
              << std::setw(6) << "cycle" << "|"
              << std::setw(5) << "reset" << "|"
              << std::setw(11) << "rsrc_reset" << "|"
              << std::setw(8) << "comp_rdy" << "|"
              << std::setw(10) << "comp_done" << "|"
              << std::setw(10) << "cmp_start" << "|"
              << std::setw(8) << "cmp_op" << "|"
              << std::setw(10) << "group_done" << "|"
              << std::setw(12) << "comp_busy";
    for (int h = 0; h < heads_in_group; ++h) {
        std::string name = "head" + std::to_string(h) + "_phase";
        std::cout << "|" << std::setw(12) << name;
    }
    std::cout << "\n";
}

// Test run_head_group with a single group; log IO per cycle
void test_run_head_group() {
    HeadCtx head_ctx[NUM_HEADS];
    HeadResources res{};
    for (int i = 0; i < NUM_HEADS; ++i) {
        init_head_ctx(head_ctx[i], 0);
    }

    bool wl_start = false, compute_start = false, requant_start = false;
    int wl_addr_sel = 0, wl_layer = 0, wl_head = 0, wl_tile = 0;
    int compute_op = 0, requant_op = 0;
    bool compute_done = false;
    int  busy_ctr     = 0;   // simulated compute latency counter (cycles)

    const int heads_in_group = std::min(NUM_HEADS - 0, HEADS_PARALLEL);
    bool group_done = false;
    print_header(heads_in_group);

    for (int cycle = 0; cycle < 128 && !group_done; ++cycle) {
        // Inputs this cycle
        bool reset_resources = (cycle == 0);
        // Simple compute model: when busy_ctr > 0, compute_ready=0; pulse compute_done when ctr reaches 1->0
        bool compute_ready   = (busy_ctr == 0);
        compute_done         = (busy_ctr == 1);
        if (busy_ctr > 0) {
            busy_ctr--;
        }

        group_done = run_head_group(
            head_ctx,
            res,
            0,                // layer_idx
            0,                // group_idx
            reset_resources,
            false, false,     // wl_ready, dma_done (unused)
            compute_ready,
            compute_done,
            false, false,     // requant_ready, requant_done
            wl_start,
            wl_addr_sel,
            wl_layer,
            wl_head,
            wl_tile,
            compute_start,
            compute_op,
            requant_start,
            requant_op);

        // Log row
        std::cout << std::left
                  << std::setw(6) << cycle << "|"
                  << std::setw(5) << reset_resources << "|"
                  << std::setw(11) << reset_resources << "|"
                  << std::setw(8) << compute_ready << "|"
                  << std::setw(10) << compute_done << "|"
                  << std::setw(10) << compute_start << "|"
                  << std::setw(8) << compute_str(compute_op) << "|"
                  << std::setw(10) << group_done << "|"
                  << std::setw(12) << res.comp_busy;
        for (int h = 0; h < heads_in_group; ++h) {
            std::cout << "|" << std::left << std::setw(12) << phase_str(head_ctx[h].phase);
        }
        std::cout << "\n";

        // On compute_start, launch a new compute with latency N cycles
        if (compute_start) {
            busy_ctr = 3; // increase delay between phases
        }
    }

    assert(group_done && "run_head_group did not complete");
    for (int h = 0; h < heads_in_group; ++h) {
        assert(head_ctx[h].phase == HeadPhase::DONE && "head did not reach DONE");
    }
}

int main() {
    test_run_head_group();
    std::cout << "run_head_group logging complete.\n";
    return 0;
}
