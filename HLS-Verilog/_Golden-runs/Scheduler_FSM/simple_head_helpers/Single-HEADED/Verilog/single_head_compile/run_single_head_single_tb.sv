`timescale 1ns/1ps

// Clocked single-head testbench for the HLS-generated run_single_head RTL.
// Drives compute_ready/compute_done with a simple latency counter and feeds
// ctx_o back into ctx_i each cycle.
module run_single_head_single_tb;

  localparam int CLK_PERIOD = 10;
  localparam int MAX_STEPS  = 64;

  // Phase encodings (HeadPhase enum)
  localparam int PHASE_IDLE = 0;
  localparam int PHASE_Q    = 1;
  localparam int PHASE_K    = 2;
  localparam int PHASE_K_RQ = 3;
  localparam int PHASE_K_WB = 4;
  localparam int PHASE_V    = 5;
  localparam int PHASE_V_RQ = 6;
  localparam int PHASE_V_WB = 7;
  localparam int PHASE_RQ_Q = 8;
  localparam int PHASE_ATT_SCORES = 9;
  localparam int PHASE_VAL_SCL = 10;
  localparam int PHASE_SOFTMAX = 11;
  localparam int PHASE_ATT_VAL = 12;
  localparam int PHASE_RQ2  = 13;
  localparam int PHASE_DONE = 14;

  // ComputeOp encodings
  localparam int CMP_NONE = 0;
  localparam int CMP_Q    = 1;
  localparam int CMP_K    = 2;
  localparam int CMP_V    = 3;
  localparam int CMP_ATT_SCORES = 4;
  localparam int CMP_VAL_SCL    = 5;
  localparam int CMP_SOFTMAX    = 6;
  localparam int CMP_ATT_VAL    = 7;

  // Packed view of HeadCtx matching actual bit layout:
  // ctx_i[31:0]   → layer_stamp
  // ctx_i[39:32]  → phase
  // ctx_i[40]     → compute_ready
  // ctx_i[41]     → compute_done
  // ctx_i[42]     → compute_start
  // ctx_i[50:43]  → compute_op
  typedef struct packed {
    logic [7:0]  compute_op;      // [50:43]
    logic        compute_start;   // [42]
    logic        compute_done;    // [41]
    logic        compute_ready;   // [40]
    logic [7:0]  phase;           // [39:32]
    logic [31:0] layer_stamp;     // [31:0]
  } head_ctx_t;

  // Clock/reset
  logic clk = 1'b0;
  always #(CLK_PERIOD/2) clk = ~clk;

  // DUT interface
  logic        ap_start;
  logic        ap_done;
  logic        ap_idle;
  logic        ap_ready;
  logic [50:0] ctx_i_bus;
  logic [50:0] ctx_o_bus;
  logic        ctx_o_ap_vld;
  logic [31:0] layer_idx;
  logic        start_r;
  logic        ap_return;
  logic        ap_rst;

  // Context state (packed)
  head_ctx_t   ctx_i;
  head_ctx_t   ctx_o;

  // Handshake debug signals for waveform visibility
  logic        inflight_dbg;
  logic [3:0]  busy_ctr_dbg;

  // Unpacked signal aliases for waveform visibility (ctx_i)
  logic [31:0] ctx_i_layer_stamp;
  logic [7:0]  ctx_i_phase;
  logic        ctx_i_compute_ready;
  logic        ctx_i_compute_done;
  logic        ctx_i_compute_start;
  logic [7:0]  ctx_i_compute_op;

  // Unpacked signal aliases for waveform visibility (ctx_o)
  logic [31:0] ctx_o_layer_stamp;
  logic [7:0]  ctx_o_phase;
  logic        ctx_o_compute_ready;
  logic        ctx_o_compute_done;
  logic        ctx_o_compute_start;
  logic [7:0]  ctx_o_compute_op;

  // Map struct <-> bus
  assign ctx_i_bus = ctx_i;
  assign ctx_o     = ctx_o_bus;

  // Unpack ctx_i for waveform readability
  assign ctx_i_layer_stamp   = ctx_i.layer_stamp;
  assign ctx_i_phase         = ctx_i.phase;
  assign ctx_i_compute_ready = ctx_i.compute_ready;
  assign ctx_i_compute_done  = ctx_i.compute_done;
  assign ctx_i_compute_start = ctx_i.compute_start;
  assign ctx_i_compute_op    = ctx_i.compute_op;

  // Unpack ctx_o for waveform readability
  assign ctx_o_layer_stamp   = ctx_o.layer_stamp;
  assign ctx_o_phase         = ctx_o.phase;
  assign ctx_o_compute_ready = ctx_o.compute_ready;
  assign ctx_o_compute_done  = ctx_o.compute_done;
  assign ctx_o_compute_start = ctx_o.compute_start;
  assign ctx_o_compute_op    = ctx_o.compute_op;

  // DUT instance
  run_single_head dut (
      .ap_clk       (clk),
      .ap_rst       (ap_rst),
      .ap_start     (ap_start),
      .ap_done      (ap_done),
      .ap_idle      (ap_idle),
      .ap_ready     (ap_ready),
      .ctx_i        (ctx_i_bus),
      .ctx_o        (ctx_o_bus),
      .ctx_o_ap_vld (ctx_o_ap_vld),
      .layer_idx    (layer_idx),
      .start_r      (start_r),
      .ap_return    (ap_return)
  );

  function string phase_name(input [7:0] phase);
    case (phase)
      PHASE_IDLE: phase_name = "IDLE";
      PHASE_Q:    phase_name = "Q";
      PHASE_K:    phase_name = "K";
      PHASE_K_RQ: phase_name = "K_RQ";
      PHASE_K_WB: phase_name = "K_WB";
      PHASE_V:    phase_name = "V";
      PHASE_V_RQ: phase_name = "V_RQ";
      PHASE_V_WB: phase_name = "V_WB";
      PHASE_RQ_Q: phase_name = "RQ_Q";
      PHASE_ATT_SCORES: phase_name = "ATT_SCO";
      PHASE_VAL_SCL:    phase_name = "VAL_SCL";
      PHASE_SOFTMAX:    phase_name = "SOFT";
      PHASE_ATT_VAL:    phase_name = "ATT_VAL";
      PHASE_RQ2:  phase_name = "RQ2";
      PHASE_DONE: phase_name = "DONE";
      default:    phase_name = "?";
    endcase
  endfunction

  function string op_name(input [7:0] op);
    case (op)
      CMP_Q: op_name = "Q";
      CMP_K: op_name = "K";
      CMP_V: op_name = "V";
      CMP_ATT_SCORES: op_name = "SCO";
      CMP_VAL_SCL:    op_name = "SCL";
      CMP_SOFTMAX:    op_name = "SFM";
      CMP_ATT_VAL:    op_name = "VAL";
      default: op_name = "-";
    endcase
  endfunction

  initial begin
    int step;
    int busy_ctr = 0;
    bit inflight = 1'b0;

    // Debug signal assignments
    assign inflight_dbg = inflight;
    assign busy_ctr_dbg = busy_ctr[3:0];

    // Reset/init
    ap_rst    = 1'b1;
    ap_start  = 1'b0;
    start_r   = 1'b0;
    layer_idx = 32'd0;
    ctx_i     = '0;
    ctx_i.layer_stamp = layer_idx;
    ctx_i.phase       = PHASE_IDLE;
    ctx_i.compute_op  = CMP_NONE;

    repeat (2) @(posedge clk);
    ap_rst   = 1'b0;
    ap_start = 1'b1;
    start_r  = 1'b1;

    $display("step | phase | ready done start op | inflight busy");
    for (step = 0; step < MAX_STEPS; step++) begin
      @(posedge clk);

      // Log after clock edge using current ctx_o
      $display("%0d   | %-4s |   %0d     %0d    %0d   %s   |    %0d      %0d",
               step,
               phase_name(ctx_o.phase),
               ctx_o.compute_ready,
               ctx_o.compute_done,
               ctx_o.compute_start,
               op_name(ctx_o.compute_op),
               inflight,
               busy_ctr);

      // Completion check
      if (ctx_o.phase == PHASE_DONE) begin
        $display("Head reached DONE at step %0d", step);
        $finish;
      end

      // Track inflight op and latency based on what DUT just output
      if (ctx_o.compute_start && !inflight) begin
        busy_ctr = 3;  // latency cycles (will count down 3->2->1->0)
        inflight = 1'b1;
      end else if (inflight) begin
        if (busy_ctr > 0) begin
          busy_ctr--;
        end else begin
          // Done signal has been sampled, clear inflight
          inflight = 1'b0;
        end
      end

      // Feedback ctx_o into ctx_i for next cycle
      if (ctx_o_ap_vld) begin
        ctx_i = ctx_o;  // Use blocking assignment
        // Clear compute_start to avoid retriggering
        ctx_i.compute_start = 1'b0;
        // Override handshake signals with testbench state
        ctx_i.compute_ready = !inflight;
        ctx_i.compute_done  = (inflight && busy_ctr == 0);
      end
    end

    $display("ERROR: head did not reach DONE within %0d steps", MAX_STEPS);
    $finish;
  end

endmodule
