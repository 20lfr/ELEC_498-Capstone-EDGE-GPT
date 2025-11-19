#include "Scheduler_FSM.hpp"
#include "ControlMemInterface.hpp"

// Temporary top-level wrapper that calls only the mem interface and scheduler (so no inputs rn)
void transformer_top() {
#pragma HLS INLINE off
    static ControlMemSpace ctrl_mem; // define Memory Space

    // Placeholder wires for scheduler inputs/outputs.
    bool axis_in_valid  = false;
    bool axis_in_last   = false;
    bool axis_in_ready  = false;
    bool wl_ready       = false;
    bool wl_start       = false;
    int  wl_addr_sel    = 0;
    int  wl_layer       = 0;
    int  wl_head        = 0;
    int  wl_tile        = 0;
    bool dma_done       = false;
    bool compute_ready  = false;
    bool compute_done   = false;
    bool compute_start  = false;
    int  compute_op     = CMP_NONE;
    bool stream_ready   = false;
    bool stream_start   = false;
    bool stream_done    = false;
    bool done           = false;

    // Invoke the scheduler with the control register bits. All other signals are
    // currently stubbed and will be replaced with real interfaces in top.cpp later.
    scheduler_hls(
        ctrl_start(ctrl_mem),
        ctrl_reset_n(ctrl_mem),
        ctrl_mem.layer_index,
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

    ctrl_set_status(ctrl_mem, STATUS_DONE_BIT, done);
}
