#include "Scheduler_FSM.hpp"
#include "ControlMemInterface.hpp"
#include "IRQ_wizard.hpp"

// Temporary top-level wrapper that calls only the mem interface and scheduler (so no inputs rn)
void transformer_top() {
#pragma HLS INLINE off

    // Control Memory Address Space~~~~~~~~
    static ControlMemSpace ctrl_mem; 

    // Placeholder wires for scheduler inputs/outputs.
    bool axis_in_valid  = false;    // AXI-Stream ingress: TVALID
    bool axis_in_last   = false;    // AXI-Stream ingress: TLAST
    bool axis_in_ready  = false;    // AXI-Stream ingress: TREADY
    bool wl_ready       = false;    // Weight loader ready flag
    bool wl_start       = false;    // Scheduler-driven DMA start
    int  wl_addr_sel    = 0;        // Matrix selector for DMA
    int  wl_layer       = 0;        // Layer index for DMA
    int  wl_head        = 0;        // Head index for DMA (-1 for shared ops)
    int  wl_tile        = 0;        // Tile index for DMA
    bool dma_done       = false;    // AXI-FULL interface completion pulse
    bool compute_ready  = false;    // Compute core idle indicator
    bool compute_done   = false;    // Compute completion pulse
    bool compute_start  = false;    // Scheduler trigger for compute core
    int  compute_op     = CMP_NONE; // Which compute op to run
    bool requant_ready  = false;    // Requant engine idle indicator
    bool requant_done   = false;    // Requant engine completion pulse
    bool requant_start  = false;    // Scheduler trigger for requant engine
    int  requant_op     = RQ_NONE;  // Which requant op to run
    bool stream_ready   = false;    // AXI-Stream egress ready flag
    bool stream_start   = false;    // Scheduler trigger for stream-out
    bool stream_done    = false;    // AXI-Stream egress completion pulse
    bool done           = false;    // Scheduler completion output
    bool error          = false;    // Scheduler error flag
    SchedState dbg_state = S_IDLE;

    


    // SCHEDULER FSM~~~~~~~~~~~~~~~~~~~~~~~
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
        dma_done, // <-- needs to come from the AXI-full interface
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
        dbg_state);

    (void)dbg_state;
    

    
    // IRQ WIZARD~~~~~~~~~~~~~~~~~~~~~~~~~~
    bool irq_ps = false;
    irq_wizard(ctrl_mem, dma_done, done, error, irq_ps);
}
