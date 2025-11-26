`timescale 1ns/1ps

// Parameterizable testbench for run_single_head.
// Drives multiple heads in groups of HEADS_PARALLEL and steps each head
// through the simple Q→K→V→DONE flow by repeatedly invoking the HLS block.
module run_single_head_tb;
  // ----------------------------
  // Tunable parameters
  // ----------------------------
  localparam int HEADS_TOTAL    = 4; // total heads to exercise
  localparam int HEADS_PARALLEL = 1; // active heads per group
  localparam int MAX_CYCLES     = 256;
  localparam int CLK_PERIOD     = 10;

  localparam int GROUPS = (HEADS_TOTAL + HEADS_PARALLEL - 1) / HEADS_PARALLEL;

  // Synthetic clock for pacing the stimulus
  logic clk = 1'b0;
  always #(CLK_PERIOD/2) clk = ~clk;

  // Per-head stimulus/state
  logic [76:0] ctx   [HEADS_TOTAL];
  logic [76:0] ctx_o [HEADS_TOTAL];
  logic        ctx_o_vld [HEADS_TOTAL];
  logic        ap_start  [HEADS_TOTAL];
  logic        ap_done   [HEADS_TOTAL];
  logic        ap_idle   [HEADS_TOTAL];
  logic        ap_ready  [HEADS_TOTAL];
  logic        ap_return [HEADS_TOTAL];
  logic [31:0] head_idx  [HEADS_TOTAL];
  logic [31:0] layer_idx [HEADS_TOTAL];
  logic        ap_rst;

  // Bookkeeping
  logic [HEADS_TOTAL-1:0] head_finished;
  int group_idx;

  // Simple decode helpers
  function string phase_name(input [7:0] phase);
    case (phase)
      8'd0:  phase_name = "Q";
      8'd1:  phase_name = "K";
      8'd4:  phase_name = "V";
      8'd13: phase_name = "DONE";
      default: phase_name = "?";
    endcase
  endfunction

  // DUT instances (one per head, driven in groups)
  genvar h;
  generate
    for (h = 0; h < HEADS_TOTAL; h = h + 1) begin : GEN_DUT
      run_single_head dut (
        .ap_start (ap_start[h]),
        .ap_done  (ap_done[h]),
        .ap_idle  (ap_idle[h]),
        .ap_ready (ap_ready[h]),
        .ctx_i    (ctx[h]),
        .ctx_o    (ctx_o[h]),
        .ctx_o_ap_vld (ctx_o_vld[h]),
        .head_idx (head_idx[h]),
        .layer_idx(layer_idx[h]),
        .ap_return(ap_return[h]),
        .ap_rst   (ap_rst)
      );
    end
  endgenerate

  // Stimulus
  initial begin
    integer cycle;
    integer i;
    integer group_base;
    integer group_end;
    integer group_done;
    ap_rst = 1'b1;
    head_finished = '0;
    group_idx = 0;

    // Initialize contexts: layer_idx = 0, phase = Q (bits [39:32])
    for (i = 0; i < HEADS_TOTAL; i++) begin
      ctx[i]       = '0;
      ctx[i][39:32]= 8'd0; // Q
      head_idx[i]  = i;
      layer_idx[i] = 32'd0;
      ap_start[i]  = 1'b0;
    end

    // Release reset after two cycles
    repeat (2) @(posedge clk);
    ap_rst = 1'b0;

    $display("Cycle  | Group | Head | Phase   | start | done | ret | ctx_o[39:32]");

    begin : finish_loop
      for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
        @(posedge clk);

      // Determine active group
      group_base = group_idx * HEADS_PARALLEL;
      group_end  = (group_base + HEADS_PARALLEL > HEADS_TOTAL) ?
                        HEADS_TOTAL : group_base + HEADS_PARALLEL;

      // Drive starts for active heads, hold others low
      for (i = 0; i < HEADS_TOTAL; i++) begin
        if (!head_finished[i] && i >= group_base && i < group_end) begin
          ap_start[i] <= 1'b1;
        end else begin
          ap_start[i] <= 1'b0;
        end
      end

      // Capture outputs when valid
      for (i = 0; i < HEADS_TOTAL; i++) begin
        if (ctx_o_vld[i]) begin
          ctx[i] <= ctx_o[i];
          if (ap_return[i]) head_finished[i] <= 1'b1;
        end
      end

      // Advance group when all heads in group are finished
      group_done = 1;
      for (i = group_base; i < group_end; i++) begin
        group_done &= head_finished[i];
      end
      if (group_done && group_idx + 1 < GROUPS) begin
        group_idx <= group_idx + 1;
      end

      // Log state
      for (i = 0; i < HEADS_TOTAL; i++) begin
        $display("%0d%7s%2d%7s%8s%8s%6s%6s%6s",
                 cycle,
                 "|", group_idx,
                 "|", $sformatf("h%0d", i),
                 phase_name(ctx[i][39:32]),
                 ap_start[i] ? "1" : "-",
                 ap_done[i]  ? "1" : "-",
                 ap_return[i]? "1" : "-");
      end

        if (&head_finished) begin
          $display("All heads finished at cycle %0d", cycle);
          disable finish_loop;
        end
      end
    end

    if (!(&head_finished)) begin
      $display("ERROR: Not all heads reached DONE within %0d cycles", MAX_CYCLES);
      $finish(1);
    end

    $display("PASS: run_single_head_tb complete.");
    $finish(0);
  end

endmodule
