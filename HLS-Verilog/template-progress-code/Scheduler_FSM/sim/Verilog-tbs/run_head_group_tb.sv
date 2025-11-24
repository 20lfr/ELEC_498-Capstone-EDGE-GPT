`timescale 1ns/1ps

module run_head_group_tb;

  // Clock / reset
  logic ap_clk = 0;
  always #5 ap_clk = ~ap_clk; // 100 MHz
  logic ap_rst;

  // DUT ports
  logic ap_start, ap_done, ap_idle, ap_ready;
  logic [2:0]  head_ctx_ref_address0;
  logic        head_ctx_ref_ce0;
  logic        head_ctx_ref_we0;
  logic [45:0] head_ctx_ref_d0;
  logic [45:0] head_ctx_ref_q0;
  logic [122:0] res_i, res_o;
  logic        res_o_ap_vld;
  logic [31:0] layer_idx, group_idx;
  logic        reset_resources;
  logic        wl_ready, dma_done;
  logic        compute_ready, compute_done;
  logic        requant_ready, requant_done;
  logic        wl_start, wl_start_ap_vld;
  logic [31:0] wl_addr_sel, wl_layer, wl_head, wl_tile;
  logic        compute_start, compute_start_ap_vld;
  logic [31:0] compute_op;
  logic        compute_op_ap_vld;
  logic        requant_start, requant_start_ap_vld;
  logic [31:0] requant_op;
  logic        ap_return;

  // Simple head_ctx memory model (8 entries)
  logic [45:0] head_ctx_mem [0:7];
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      head_ctx_ref_q0 <= '0;
    end else if (head_ctx_ref_ce0) begin
      head_ctx_ref_q0 <= head_ctx_mem[head_ctx_ref_address0];
      if (head_ctx_ref_we0) begin
        head_ctx_mem[head_ctx_ref_address0] <= head_ctx_ref_d0;
      end
    end
  end

  // DUT instance (path relative to sim/Verilog-tbs)
  run_head_group dut (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .head_ctx_ref_address0(head_ctx_ref_address0),
    .head_ctx_ref_ce0(head_ctx_ref_ce0),
    .head_ctx_ref_we0(head_ctx_ref_we0),
    .head_ctx_ref_d0(head_ctx_ref_d0),
    .head_ctx_ref_q0(head_ctx_ref_q0),
    .res_i(res_i),
    .res_o(res_o),
    .res_o_ap_vld(res_o_ap_vld),
    .layer_idx(layer_idx),
    .group_idx(group_idx),
    .reset_resources(reset_resources),
    .wl_ready(wl_ready),
    .dma_done(dma_done),
    .compute_ready(compute_ready),
    .compute_done(compute_done),
    .requant_ready(requant_ready),
    .requant_done(requant_done),
    .wl_start(wl_start),
    .wl_start_ap_vld(wl_start_ap_vld),
    .wl_addr_sel(wl_addr_sel),
    .wl_layer(wl_layer),
    .wl_head(wl_head),
    .wl_tile(wl_tile),
    .compute_start(compute_start),
    .compute_start_ap_vld(compute_start_ap_vld),
    .compute_op(compute_op),
    .compute_op_ap_vld(compute_op_ap_vld),
    .requant_start(requant_start),
    .requant_start_ap_vld(requant_start_ap_vld),
    .requant_op(requant_op),
    .ap_return(ap_return)
  );

  // Default assignments and reset
  initial begin
    ap_rst          = 1'b1;
    ap_start        = 1'b0;
    layer_idx       = 32'd1;
    group_idx       = 0;
    reset_resources = 1'b0;
    wl_ready        = 1'b1;
    dma_done        = 1'b0;
    compute_ready   = 1'b1;
    compute_done    = 1'b0;
    requant_ready   = 1'b1;
    requant_done    = 1'b0;
    wl_addr_sel     = 0;
    wl_layer        = 0;
    wl_head         = 0;
    wl_tile         = 0;
    requant_op      = 0;
    res_i           = '0;
    for (int i = 0; i < 8; i++) head_ctx_mem[i] = '0;

    // Reset pulse
    repeat (4) @(posedge ap_clk);
    ap_rst <= 1'b0;
    @(posedge ap_clk);

    // Start one transaction (hold start for two beats to match ap_ready)
    reset_resources <= 1'b1;
    ap_start        <= 1'b1;
    @(posedge ap_clk);
    @(posedge ap_clk);
    reset_resources <= 1'b0;
    ap_start        <= 1'b0;
  end

  // Simple compute model: deassert ready while busy, pulse done after latency
  initial begin
    forever begin
      @(posedge ap_clk);
      if (ap_rst) begin
        compute_ready <= 1'b1;
        compute_done  <= 1'b0;
      end else if (compute_start_ap_vld) begin
        compute_ready <= 1'b0;
        repeat (3) @(posedge ap_clk);
        compute_done  <= 1'b1;
        @(posedge ap_clk);
        compute_done  <= 1'b0;
        compute_ready <= 1'b1;
      end
    end
  end

  // DMA/Requant complete immediately when started
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      dma_done     <= 1'b0;
      requant_done <= 1'b0;
    end else begin
      dma_done     <= wl_start_ap_vld;
      requant_done <= requant_start_ap_vld;
    end
  end

  // Track compute ops emitted by the DUT to ensure the head phases fire in order.
  localparam int NUM_EXPECTED = 7;
  int expected_ops   [NUM_EXPECTED] = '{1, 2, 3, 4, 5, 6, 7}; // CMP_Q..CMP_ATT_VALUE
  int expected_index = 0;

  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      expected_index <= 0;
    end else if (compute_start_ap_vld) begin
      if (expected_index < NUM_EXPECTED) begin
        if (compute_op !== expected_ops[expected_index]) begin
          $fatal(1, "Unexpected compute_op %0d at step %0d (expected %0d)",
                 compute_op, expected_index, expected_ops[expected_index]);
        end
        expected_index <= expected_index + 1;
      end else begin
        $fatal(1, "Extra compute_start seen after expected phases complete (op=%0d)", compute_op);
      end
    end
  end

  // Finish when ap_done goes high or after timeout; also verify all expected phases fired.
  initial begin
    int cycles = 0;
    while (!ap_done && cycles < 300) begin
      @(posedge ap_clk);
      cycles++;
    end

    if (!ap_done) begin
      $display("Timeout waiting for ap_done");
      $fatal(1);
    end

    if (expected_index != NUM_EXPECTED) begin
      $fatal(1, "Simulation ended early: only saw %0d/%0d compute phases", expected_index, NUM_EXPECTED);
    end

    $display("run_head_group completed. ap_return=%0d, observed %0d compute phases.",
             ap_return, expected_index);
    #20;
    $finish;
  end

  // Optional waveform dump
  initial begin
    $dumpfile("run_head_group_tb.vcd");
    $dumpvars(0, run_head_group_tb);
  end

endmodule
