`timescale 1ns/1ps

module scheduler_tb;
    // Clock / reset
    logic clk = 0;
    logic rst_n = 0;

    // AXI-lite start control (exposed as argument in scheduler_hls)
    logic start;

    // AXIS input interface
    logic axis_in_valid;
    logic axis_in_last;
    logic axis_in_ready;

    // Weight loader interface
    logic        wl_ready;
    logic        wl_start;
    logic [7:0]  wl_addr_sel;
    logic [7:0]  wl_layer;
    logic [7:0]  wl_head;
    logic [7:0]  wl_tile;
    logic        dma_done;

    // Compute interface
    logic compute_ready;
    logic compute_done;
    logic compute_start;
    logic [7:0] compute_op;

    // Stream output
    logic stream_ready;
    logic stream_start;
    logic stream_done;

    // Completion
    logic done;

    // Clock generation
    always #5 clk = ~clk;

    // Wires to capture one-cycle delayed acknowledgements
    logic wl_start_q;
    logic compute_start_q;
    logic stream_start_q;

    // Stimulus defaults
    initial begin
        start          = 0;
        axis_in_valid  = 0;
        axis_in_last   = 0;
        wl_ready       = 0;
        dma_done       = 0;
        compute_ready  = 0;
        compute_done   = 0;
        stream_ready   = 0;
        stream_done    = 0;

        repeat (5) @(posedge clk);
        rst_n = 1'b1;
        @(posedge clk);

        // Allow scheduler to pull in embeddings
        start         = 1'b1;
        axis_in_valid = 1'b1;
        axis_in_last  = 1'b1;
        @(posedge clk);
        axis_in_valid = 0;
        axis_in_last  = 0;

        // Keep start asserted a bit longer, then drop
        repeat (5) @(posedge clk);
        start = 1'b0;

        // Keep resources ready
        wl_ready      = 1'b1;
        compute_ready = 1'b1;
        stream_ready  = 1'b1;
    end

    // Simple handshake emulation: acknowledge wl_start / compute_start / stream_start in the following cycle
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wl_start_q     <= 1'b0;
            compute_start_q<= 1'b0;
            stream_start_q <= 1'b0;
            dma_done       <= 1'b0;
            compute_done   <= 1'b0;
            stream_done    <= 1'b0;
        end else begin
            wl_start_q      <= wl_start;
            compute_start_q <= compute_start;
            stream_start_q  <= stream_start;
            dma_done        <= wl_start_q;
            compute_done    <= compute_start_q;
            stream_done     <= stream_start_q;
        end
    end

    // Stop the simulation once the scheduler asserts done
    initial begin
        wait(done);
        $display("Scheduler completed at time %0t", $time);
        #20;
        $finish;
    end

    // DUT instance: replace port list as needed once RTL is generated
    scheduler_hls dut (
        .ap_clk       (clk),
        .ap_rst_n     (rst_n),
        .start        (start),
        .axis_in_valid(axis_in_valid),
        .axis_in_last (axis_in_last),
        .axis_in_ready(axis_in_ready),
        .wl_ready     (wl_ready),
        .wl_start     (wl_start),
        .wl_addr_sel  (wl_addr_sel),
        .wl_layer     (wl_layer),
        .wl_head      (wl_head),
        .wl_tile      (wl_tile),
        .dma_done     (dma_done),
        .compute_ready(compute_ready),
        .compute_done (compute_done),
        .compute_start(compute_start),
        .compute_op   (compute_op),
        .stream_ready (stream_ready),
        .stream_start (stream_start),
        .stream_done  (stream_done),
        .done         (done)
    );

endmodule
