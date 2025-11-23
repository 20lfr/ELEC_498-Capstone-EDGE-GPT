`timescale 1ns/1ps

module scheduler_hls_min_tb;
  // Clock and reset
  reg ap_clk   = 0;
  reg ap_rst   = 1;
  always #5 ap_clk = ~ap_clk; // 100 MHz

  // Control
  reg  ap_start = 0;
  wire ap_done;
  wire ap_idle;
  wire ap_ready;

  reg  cntrl_start    = 0;
  reg  cntrl_reset_n  = 0;
  wire [31:0] cntrl_layer_idx;
  wire cntrl_layer_idx_ap_vld;

  // AXIS ingress
  reg  axis_in_valid  = 0;
  reg  axis_in_last   = 0;
  wire axis_in_ready;
  wire axis_in_ready_ap_vld;

  // Weight loader
  reg  wl_ready       = 1;
  wire wl_start;
  wire wl_start_ap_vld;
  wire [31:0] wl_addr_sel;
  wire wl_addr_sel_ap_vld;
  wire [31:0] wl_layer;
  wire wl_layer_ap_vld;
  wire [31:0] wl_head;
  wire wl_head_ap_vld;
  wire [31:0] wl_tile;
  wire wl_tile_ap_vld;
  reg  dma_done       = 0;

  // Compute
  reg  compute_ready  = 1;
  reg  compute_done   = 0;
  reg  requant_ready  = 1;
  reg  requant_done   = 0;
  wire compute_start;
  wire compute_start_ap_vld;
  wire [31:0] compute_op;
  wire compute_op_ap_vld;
  wire requant_start;
  wire requant_start_ap_vld;
  wire [31:0] requant_op;
  wire requant_op_ap_vld;

  // Stream out
  reg  stream_ready   = 1;
  wire stream_start;
  wire stream_start_ap_vld;
  reg  stream_done    = 0;

  wire done;
  wire done_ap_vld;
  wire [31:0] STATE;
  wire STATE_ap_vld;

  // DUT
  scheduler_hls dut (
      .ap_clk(ap_clk),
      .ap_rst(ap_rst),
      .ap_start(ap_start),
      .ap_done(ap_done),
      .ap_idle(ap_idle),
      .ap_ready(ap_ready),
      .cntrl_start(cntrl_start),
      .cntrl_reset_n(cntrl_reset_n),
      .cntrl_layer_idx(cntrl_layer_idx),
      .cntrl_layer_idx_ap_vld(cntrl_layer_idx_ap_vld),
      .axis_in_valid(axis_in_valid),
      .axis_in_last(axis_in_last),
      .axis_in_ready(axis_in_ready),
      .axis_in_ready_ap_vld(axis_in_ready_ap_vld),
      .wl_ready(wl_ready),
      .wl_start(wl_start),
      .wl_start_ap_vld(wl_start_ap_vld),
      .wl_addr_sel(wl_addr_sel),
      .wl_addr_sel_ap_vld(wl_addr_sel_ap_vld),
      .wl_layer(wl_layer),
      .wl_layer_ap_vld(wl_layer_ap_vld),
      .wl_head(wl_head),
      .wl_head_ap_vld(wl_head_ap_vld),
      .wl_tile(wl_tile),
      .wl_tile_ap_vld(wl_tile_ap_vld),
      .dma_done(dma_done),
      .compute_ready(compute_ready),
      .compute_done(compute_done),
      .requant_ready(requant_ready),
      .requant_done(requant_done),
      .compute_start(compute_start),
      .compute_start_ap_vld(compute_start_ap_vld),
      .compute_op(compute_op),
      .compute_op_ap_vld(compute_op_ap_vld),
      .requant_start(requant_start),
      .requant_start_ap_vld(requant_start_ap_vld),
      .requant_op(requant_op),
      .requant_op_ap_vld(requant_op_ap_vld),
      .stream_ready(stream_ready),
      .stream_start(stream_start),
      .stream_start_ap_vld(stream_start_ap_vld),
      .stream_done(stream_done),
      .done(done),
      .done_ap_vld(done_ap_vld),
      .STATE(STATE),
      .STATE_ap_vld(STATE_ap_vld)
  );

  // Simple compute/stream latency emulation
  integer comp_lat = 0;

  always @(posedge ap_clk) begin
    if (ap_rst) begin
      comp_lat      <= 0;
      compute_done  <= 0;
      stream_done   <= 0;
      dma_done      <= 0;
    end else begin
      compute_done  <= 0;
      stream_done   <= 0;
      dma_done      <= 0;

      // Trigger compute latency of 2 cycles when compute_start pulses
      if (compute_start) begin
        comp_lat <= 2;
      end else if (comp_lat > 0) begin
        comp_lat <= comp_lat - 1;
        if (comp_lat == 1)
          compute_done <= 1'b1;
      end

      // Stream start completes in 1 cycle
      if (stream_start)
        stream_done <= 1'b1;
    end
  end

  // Stimulus
  initial begin
    $display("Starting minimal Verilog TB");
    ap_rst       = 1;
    ap_start     = 0;
    cntrl_start  = 0;
    cntrl_reset_n= 0;
    repeat (4) @(posedge ap_clk);
    ap_rst       = 0;
    cntrl_reset_n= 1;
    cntrl_start  = 1;
    ap_start     = 1;

    // Stream in three beats, tlast on third
    axis_in_valid= 0;
    axis_in_last = 0;
    repeat (2) @(posedge ap_clk); // initial gap
    axis_in_valid= 1;
    axis_in_last = 0;
    @(posedge ap_clk);
    axis_in_last = 0;
    @(posedge ap_clk);
    axis_in_last = 1'b1;
    @(posedge ap_clk);
    axis_in_valid= 0;
    axis_in_last = 0;

    // Run for a fixed budget
    repeat (400) @(posedge ap_clk);
    $display("DONE=%0d, STATE=0x%0h, layer_idx=%0d", done, STATE, cntrl_layer_idx);
    $finish;
  end

endmodule
