`timescale 1ns / 1ps

// Basic connectivity testbench for the HLS-generated run_head_group module.
// Reset is held asserted for the entire run; adjust ap_rst if you want the DUT to leave reset.
module run_head_group_tb;
  localparam int CLK_PERIOD = 10;  // ns

  // Clock/reset
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;  // held high for now

  // DUT inputs
  logic ap_start;
  logic [45:0] head_ctx_ref_q0;
  logic [45:0] head_ctx_ref_q1;
  logic [139:0] res_i;
  logic [31:0] layer_idx;
  logic [31:0] group_idx;
  logic reset_resources;
  logic wl_ready;
  logic dma_done;
  logic compute_ready;
  logic compute_done;
  logic requant_ready;
  logic requant_done;

  // DUT outputs
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [2:0] head_ctx_ref_address0;
  logic head_ctx_ref_ce0;
  logic head_ctx_ref_we0;
  logic [45:0] head_ctx_ref_d0;
  logic [2:0] head_ctx_ref_address1;
  logic head_ctx_ref_ce1;
  logic head_ctx_ref_we1;
  logic [45:0] head_ctx_ref_d1;
  logic [139:0] res_o;
  logic res_o_ap_vld;
  logic wl_start;
  logic wl_start_ap_vld;
  logic [31:0] wl_addr_sel;
  logic wl_addr_sel_ap_vld;
  logic [31:0] wl_layer;
  logic wl_layer_ap_vld;
  logic [31:0] wl_head;
  logic wl_head_ap_vld;
  logic [31:0] wl_tile;
  logic wl_tile_ap_vld;
  logic compute_start;
  logic compute_start_ap_vld;
  logic [31:0] compute_op;
  logic compute_op_ap_vld;
  logic requant_start;
  logic requant_start_ap_vld;
  logic [31:0] requant_op;
  logic requant_op_ap_vld;
  logic ap_return;

  // Clock generation
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  // Simple stimulus: drive inputs low while reset stays asserted.
  initial begin
    ap_start = 1'b0;
    head_ctx_ref_q0 = '0;
    head_ctx_ref_q1 = '0;
    res_i = '0;
    layer_idx = '0;
    group_idx = '0;
    reset_resources = 1'b0;
    wl_ready = 1'b0;
    dma_done = 1'b0;
    compute_ready = 1'b0;
    compute_done = 1'b0;
    requant_ready = 1'b0;
    requant_done = 1'b0;

    // Run long enough to observe reset behavior.
    #(50*CLK_PERIOD);
    $finish;
  end

  // DUT instance
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
      .head_ctx_ref_address1(head_ctx_ref_address1),
      .head_ctx_ref_ce1(head_ctx_ref_ce1),
      .head_ctx_ref_we1(head_ctx_ref_we1),
      .head_ctx_ref_d1(head_ctx_ref_d1),
      .head_ctx_ref_q1(head_ctx_ref_q1),
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
      .wl_addr_sel_ap_vld(wl_addr_sel_ap_vld),
      .wl_layer(wl_layer),
      .wl_layer_ap_vld(wl_layer_ap_vld),
      .wl_head(wl_head),
      .wl_head_ap_vld(wl_head_ap_vld),
      .wl_tile(wl_tile),
      .wl_tile_ap_vld(wl_tile_ap_vld),
      .compute_start(compute_start),
      .compute_start_ap_vld(compute_start_ap_vld),
      .compute_op(compute_op),
      .compute_op_ap_vld(compute_op_ap_vld),
      .requant_start(requant_start),
      .requant_start_ap_vld(requant_start_ap_vld),
      .requant_op(requant_op),
      .requant_op_ap_vld(requant_op_ap_vld),
      .ap_return(ap_return)
  );

endmodule
