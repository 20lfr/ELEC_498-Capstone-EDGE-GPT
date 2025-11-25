`timescale 1ns / 1ps

// Basic connectivity testbench for the HLS-generated run_head_group module.
// Replicates the logic of Scheduler_head_helpers_tb.cpp
module run_head_group_tb;
  localparam int CLK_PERIOD = 10;  // ns

  // Clock/reset
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;

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

  // Memory Simulation for head_ctx_ref
  // The DUT accesses this memory. We need to simulate it.
  // Assuming NUM_HEADS is small enough for this array.
  // Based on C++ code, it seems to access up to NUM_HEADS.
  // The address width is 3 bits, so 8 locations.
  logic [45:0] head_ctx_mem [0:7];

  always_ff @(posedge ap_clk) begin
    if (head_ctx_ref_ce0) begin
        if (head_ctx_ref_we0) begin
            head_ctx_mem[head_ctx_ref_address0] <= head_ctx_ref_d0;
        end
        head_ctx_ref_q0 <= head_ctx_mem[head_ctx_ref_address0];
    end
    if (head_ctx_ref_ce1) begin
        if (head_ctx_ref_we1) begin
            head_ctx_mem[head_ctx_ref_address1] <= head_ctx_ref_d1;
        end
        head_ctx_ref_q1 <= head_ctx_mem[head_ctx_ref_address1];
    end
  end

  // Resource Loopback
  // The C++ code passes `res` by reference. HLS generates input `res_i` and output `res_o`.
  // We need to feed `res_o` back to `res_i` for the next cycle.
  always_ff @(posedge ap_clk) begin
      if (ap_rst) begin
          res_i <= '0;
      end else if (res_o_ap_vld) begin
          res_i <= res_o;
      end
  end

  // Compute Handshake Simulation
  // When compute_start is asserted, we deassert compute_ready, wait, pulse compute_done, then reassert compute_ready.
  initial begin
      compute_ready = 1'b1;
      compute_done = 1'b0;
      forever begin
          @(posedge ap_clk);
          if (compute_start && compute_start_ap_vld) begin
              // Start compute
              compute_ready <= 1'b0;
              
              // Simulate latency (e.g., 3 cycles as in C++ TB)
              repeat(3) @(posedge ap_clk);
              
              // Done
              compute_done <= 1'b1;
              @(posedge ap_clk);
              compute_done <= 1'b0;
              compute_ready <= 1'b1;
          end
      end
  end

  // Main Stimulus
  initial begin
    bit group_finished = 0;
    int cycle_count = 0;

    // Initialize Inputs
    ap_start = 1'b0;
    layer_idx = '0;
    group_idx = '0;
    reset_resources = 1'b0;
    wl_ready = 1'b0; // Not testing WL here
    dma_done = 1'b0;
    requant_ready = 1'b0; // Not testing Requant here
    requant_done = 1'b0;
    
    // Initialize Memory
    for (int i = 0; i < 8; i++) begin
        head_ctx_mem[i] = '0;
    end

    // Reset Sequence
    ap_rst = 1'b1;
    #(5*CLK_PERIOD);
    ap_rst = 1'b0;
    
    // Start the DUT
    // We need to assert reset_resources for the first call (cycle 0 in C++ TB)
    // But HLS design might handle this differently. The C++ `run_head_group` takes `reset_resources` as input.
    // Let's assert it for the first transaction.
    
    @(posedge ap_clk);
    ap_start = 1'b1;
    reset_resources = 1'b1;
    
    // Wait for one cycle, then deassert reset_resources (if it's a pulse)
    // Or keep it high if it's meant to be high for the whole "first call" transaction.
    // In HLS, ap_start starts the function. The arguments are sampled.
    // So we just hold them until ap_done? No, ap_start is a handshake.
    // Let's hold inputs steady.
    
    @(posedge ap_clk);
    reset_resources = 1'b0; // Clear it for subsequent internal loops if any, though HLS function is one call.
    // Actually, `run_head_group` in C++ is called in a loop in the TB.
    // The HLS module likely represents ONE call to the function.
    // BUT, the C++ function has a loop inside: `for (int lane = 0; ...)`
    // And it returns `group_finished`.
    // Wait, the HLS module `run_head_group` seems to implement the whole function logic.
    // Does it return immediately?
    // The C++ function returns `bool`. `ap_return` is 1 bit.
    // If it returns `false`, we need to call it again?
    // The C++ TB calls it in a loop: `while (!group_done)`.
    // So we need to restart the DUT repeatedly until `ap_return` is 1.
    
    // Let's implement the loop structure.
    
    ap_start = 1'b0; // Cancel the previous start attempt to restart properly
    
    // Loop until group is finished
    
    while (!group_finished) begin
        cycle_count++;
        
        // Setup inputs for this call
        ap_start = 1'b1;
        if (cycle_count == 1) reset_resources = 1'b1;
        else reset_resources = 1'b0;
        
        // Wait for Done
        wait(ap_done);
        @(posedge ap_clk);
        
        // Check return value
        group_finished = ap_return;
        
        // Deassert start
        ap_start = 1'b0;
        
        // Wait a bit before next call (optional, but good for waveforms)
        @(posedge ap_clk);
        
        if (cycle_count > 1000) begin
            $display("Error: Timeout waiting for group completion.");
            break;
        end
    end
    
    if (group_finished) begin
        $display("Success: Group finished after %0d calls.", cycle_count);
    end else begin
        $display("Failure: Group did not finish.");
    end

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
