#include "Scheduler_FSM.hpp"

#include <iostream>

// Small helper that turns a "start" pulse into a completion pulse after a fixed
// latency. It lets us emulate DMA/compute/stream engines inside the software TB.
class SingleShotDelay {
  public:
    explicit SingleShotDelay(int latency_cycles)
        : latency(latency_cycles) {}

    bool signal() const { return active && remaining <= 0; }
    bool busy() const { return active; }

    void arm() {
        active = true;
        remaining = (latency > 0) ? (latency - 1) : 0;
    }

    void step() {
        if (!active)
            return;
        if (remaining <= 0) {
            active = false;
            return;
        }
        --remaining;
    }

  private:
    int  latency;
    bool active    = false;
    int  remaining = 0;
};

int main() {
    constexpr bool kVerbose = false;

    // DUT inputs (initialised to safe defaults)
    bool cntrl_start    = false;
    int  cntrl_layer_idx = 0;
    bool axis_in_valid  = false;
    bool axis_in_last   = false;
    bool axis_in_ready  = false;
    bool wl_ready       = true;
    bool wl_start       = false;
    int  wl_addr_sel    = 0;
    int  wl_layer       = 0;
    int  wl_head        = 0;
    int  wl_tile        = 0;
    bool dma_done       = false;
    bool compute_ready  = true;
    bool compute_done   = false;
    bool compute_start  = false;
    int  compute_op     = 0;
    bool stream_ready   = true;
    bool stream_start   = false;
    bool stream_done    = false;
    bool done           = false;
    int  inflight_compute_op = -1;

    // Simple behavioural models for the downstream engines.
    SingleShotDelay dma_model(2);      // DMA completes two cycles after start
    SingleShotDelay compute_model(3);  // compute takes three cycles
    SingleShotDelay stream_model(8);   // stream-out takes eight cycles

    constexpr int kMaxCycles = 20000;
    for (int cycle = 0; cycle < kMaxCycles; ++cycle) {
        bool reset_active = (cycle < 2);
        bool reset_n      = !reset_active;
        cntrl_start   = (reset_n && cycle < 4); // raise start for two cycles after reset
        axis_in_valid = (reset_n && cycle >= 2 && cycle <= 9);
        axis_in_last  = (reset_n && cycle == 9);

        // Fold the helper models into the DUT inputs.
        dma_done      = dma_model.signal();
        compute_done  = compute_model.signal();
        stream_done   = stream_model.signal();
        wl_ready      = !dma_model.busy();
        compute_ready = !compute_model.busy();
        stream_ready  = !stream_model.busy();

        if (compute_done && inflight_compute_op >= 0) {
            if (kVerbose) {
                std::cout << "[cycle " << cycle << "] Compute done op="
                          << inflight_compute_op << "\n";
            }
            inflight_compute_op = -1;
        }

        scheduler_hls(cntrl_start,
                      reset_n,
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
                      done);

        if (wl_start) {
            if (dma_model.busy()) {
                std::cerr << "[cycle " << cycle
                          << "] ERROR: overlapping DMA request\n";
                return 1;
            }
            dma_model.arm();
            if (kVerbose) {
                std::cout << "[cycle " << cycle << "] DMA start sel=" << wl_addr_sel
                          << " layer=" << wl_layer << " head=" << wl_head
                          << " tile=" << wl_tile << "\n";
            }
        }

        if (compute_start) {
            if (compute_model.busy()) {
                std::cerr << "[cycle " << cycle
                          << "] ERROR: overlapping compute request\n";
                return 1;
            }
            compute_model.arm();
            inflight_compute_op = compute_op;
            if (kVerbose) {
                std::cout << "[cycle " << cycle
                          << "] Compute start op=" << compute_op << "\n";
            }
        }

        if (stream_start) {
            if (stream_model.busy()) {
                std::cerr << "[cycle " << cycle
                          << "] ERROR: overlapping stream request\n";
                return 1;
            }
            stream_model.arm();
            if (kVerbose) {
                std::cout << "[cycle " << cycle << "] Stream-out started\n";
            }
        }

        if (done) {
            std::cout << "Scheduler completed after " << cycle + 1 << " cycles\n";
            return 0;
        }

        dma_model.step();
        compute_model.step();
        stream_model.step();
    }

    std::cerr << "ERROR: scheduler did not finish within " << kMaxCycles
              << " cycles\n";
    return 1;
}
