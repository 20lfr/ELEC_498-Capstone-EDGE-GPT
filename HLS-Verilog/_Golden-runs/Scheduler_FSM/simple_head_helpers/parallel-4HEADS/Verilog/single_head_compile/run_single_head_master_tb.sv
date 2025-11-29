`timescale 1ns/1ps

// Master testbench that exercises multiple heads and steps through groups of HEADS_PARALLEL.
// Drives compute_ready/done with per-head latency counters and feeds ctx_o back into ctx_i.
module run_single_head_master_tb;

  localparam int CLK_PERIOD     = 10;
  localparam int NUM_HEADS      = 4;
  localparam int HEADS_PARALLEL = 1; // adjust if C constants change
  localparam int GROUPS         = (NUM_HEADS + HEADS_PARALLEL - 1) / HEADS_PARALLEL;
  localparam int MAX_STEPS      = 256;

  // Phase encodings
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

  typedef struct packed {
    logic [7:0]  compute_op;     // [50:43]
    logic        compute_start;  // [42]
    logic        compute_done;   // [41]
    logic        compute_ready;  // [40]
    logic [7:0]  phase;          // [39:32]
    logic [31:0] layer_stamp;    // [31:0]
  } head_ctx_t;

  // Clock/reset
  logic clk = 1'b0;
  always #(CLK_PERIOD/2) clk = ~clk;

  // DUT arrays
  logic [NUM_HEADS-1:0]        ap_start;
  logic [NUM_HEADS-1:0]        ap_done;
  logic [NUM_HEADS-1:0]        ap_idle;
  logic [NUM_HEADS-1:0]        ap_ready;
  logic [NUM_HEADS-1:0][50:0]  ctx_i_bus;
  logic [NUM_HEADS-1:0][50:0]  ctx_o_bus;
  logic [NUM_HEADS-1:0]        ctx_o_ap_vld;
  logic [NUM_HEADS-1:0][31:0]  layer_idx;
  logic [NUM_HEADS-1:0]        start_r;
  logic [NUM_HEADS-1:0]        ap_return;
  logic [NUM_HEADS-1:0]        ap_rst;

  // Context storage (packed)
  head_ctx_t                   ctx_state   [NUM_HEADS];
  head_ctx_t                   ctx_o       [NUM_HEADS];

  // Unpacked aliases for waveform visibility (ctx_i / ctx_o per head)
  logic [NUM_HEADS-1:0][31:0]  ctx_i_layer_stamp;
  logic [NUM_HEADS-1:0][7:0]   ctx_i_phase;
  logic [NUM_HEADS-1:0]        ctx_i_compute_ready;
  logic [NUM_HEADS-1:0]        ctx_i_compute_done;
  logic [NUM_HEADS-1:0]        ctx_i_compute_start;
  logic [NUM_HEADS-1:0][7:0]   ctx_i_compute_op;

  logic [NUM_HEADS-1:0][31:0]  ctx_o_layer_stamp;
  logic [NUM_HEADS-1:0][7:0]   ctx_o_phase;
  logic [NUM_HEADS-1:0]        ctx_o_compute_ready;
  logic [NUM_HEADS-1:0]        ctx_o_compute_done;
  logic [NUM_HEADS-1:0]        ctx_o_compute_start;
  logic [NUM_HEADS-1:0][7:0]   ctx_o_compute_op;

  // Busy counters per head
  integer                      busy_ctr    [NUM_HEADS];
  logic                        inflight    [NUM_HEADS];

  // Debug mirrors for waveforms
  logic [NUM_HEADS-1:0]        inflight_dbg;
  logic [NUM_HEADS-1:0][3:0]   busy_ctr_dbg;

  // Map struct <-> bus
  genvar gi;
  generate
    for (gi = 0; gi < NUM_HEADS; gi++) begin : GEN_MAP
      assign ctx_i_bus[gi] = ctx_state[gi];
      assign ctx_o[gi]     = ctx_o_bus[gi];

      // Unpack ctx_i
      assign ctx_i_layer_stamp[gi]   = ctx_state[gi].layer_stamp;
      assign ctx_i_phase[gi]         = ctx_state[gi].phase;
      assign ctx_i_compute_ready[gi] = ctx_state[gi].compute_ready;
      assign ctx_i_compute_done[gi]  = ctx_state[gi].compute_done;
      assign ctx_i_compute_start[gi] = ctx_state[gi].compute_start;
      assign ctx_i_compute_op[gi]    = ctx_state[gi].compute_op;

      // Unpack ctx_o
      assign ctx_o_layer_stamp[gi]   = ctx_o[gi].layer_stamp;
      assign ctx_o_phase[gi]         = ctx_o[gi].phase;
      assign ctx_o_compute_ready[gi] = ctx_o[gi].compute_ready;
      assign ctx_o_compute_done[gi]  = ctx_o[gi].compute_done;
      assign ctx_o_compute_start[gi] = ctx_o[gi].compute_start;
      assign ctx_o_compute_op[gi]    = ctx_o[gi].compute_op;

      // Debug mirrors
      assign inflight_dbg[gi]  = inflight[gi];
      assign busy_ctr_dbg[gi]  = busy_ctr[gi][3:0];
    end
  endgenerate

  // Instantiate DUTs
  genvar h;
  generate
    for (h = 0; h < NUM_HEADS; h++) begin : GEN_HEADS
      run_single_head dut (
          .ap_clk       (clk),
          .ap_rst       (ap_rst[h]),
          .ap_start     (ap_start[h]),
          .ap_done      (ap_done[h]),
          .ap_idle      (ap_idle[h]),
          .ap_ready     (ap_ready[h]),
          .ctx_i        (ctx_i_bus[h]),
          .ctx_o        (ctx_o_bus[h]),
          .ctx_o_ap_vld (ctx_o_ap_vld[h]),
          .layer_idx    (layer_idx[h]),
          .start_r      (start_r[h]),
          .ap_return    (ap_return[h])
      );
    end
  endgenerate

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
    int group_idx = 0;
    bit group_complete = 0;
    bit all_done;

    // Reset/init
    for (int i = 0; i < NUM_HEADS; i++) begin
      ap_rst[i]    = 1'b1;
      ap_start[i]  = 1'b0;
      start_r[i]   = 1'b0;
      layer_idx[i] = 32'd0;
      ctx_state[i] = '0;
      ctx_state[i].layer_stamp = layer_idx[i];
      ctx_state[i].phase       = PHASE_IDLE;
      ctx_state[i].compute_op  = CMP_NONE;
      busy_ctr[i] = 0;
      inflight[i] = 1'b0;
    end

    repeat (2) @(posedge clk);
    for (int i = 0; i < NUM_HEADS; i++) begin
      ap_rst[i]   = 1'b0;
    end

    $display("step | group | per-head: [phase|rdy|done|start|op]");

    for (step = 0; step < MAX_STEPS; step++) begin
      // Gate which heads are active BEFORE the clock edge
      for (int i = 0; i < NUM_HEADS; i++) begin
        const bit in_group = (i >= group_idx * HEADS_PARALLEL) &&
                             (i < (group_idx + 1) * HEADS_PARALLEL);
        ap_start[i] = in_group;
        start_r[i]  = in_group;
        
        if (in_group) begin
          // Active head: drive compute handshake based on simulation state
          ctx_state[i].compute_ready = !inflight[i];
          ctx_state[i].compute_done  = (inflight[i] && busy_ctr[i] == 0);
        end else begin
          // Inactive head: clear handshake signals
          ctx_state[i].compute_ready = 1'b0;
          ctx_state[i].compute_done  = 1'b0;
        end
      end

      @(posedge clk);

      // Log current state
      $write("%0d   | %0d     | ", step, group_idx);
      for (int i = 0; i < NUM_HEADS; i++) begin
        $write("%s r%0d d%0d s%0d %s  ",
               phase_name(ctx_o[i].phase),
               ctx_o[i].compute_ready,
               ctx_o[i].compute_done,
               ctx_o[i].compute_start,
               op_name(ctx_o[i].compute_op));
      end
      $write("\n");

      // Completion tracking
      all_done = 1'b1;
      group_complete = 1'b1;
      for (int i = 0; i < NUM_HEADS; i++) begin
        const bit in_group = (i >= group_idx * HEADS_PARALLEL) &&
                             (i < (group_idx + 1) * HEADS_PARALLEL);
        const bit head_done = (ctx_o[i].phase == PHASE_DONE);
        all_done &= head_done;
        if (in_group) group_complete &= head_done;
      end
      if (group_complete && (group_idx + 1 < GROUPS)) begin
        group_idx++;
      end
      if (all_done) begin
        $display("All heads reached DONE at step %0d", step);
        $finish;
      end

      // Arm busy counters on compute_start, otherwise count down
      for (int i = 0; i < NUM_HEADS; i++) begin
        if (ctx_o[i].compute_start && !inflight[i]) begin
          busy_ctr[i] = 3;    // latency cycles (will count 3->2->1->0)
          inflight[i] = 1'b1;
        end else if (inflight[i]) begin
          if (busy_ctr[i] > 0) begin
            busy_ctr[i]--;
          end else begin
            // Done signal has been sampled, clear inflight
            inflight[i] = 1'b0;
          end
        end
      end

      // Feedback ctx_o into ctx_state for next cycle
      for (int i = 0; i < NUM_HEADS; i++) begin
        if (ctx_o_ap_vld[i]) begin
          ctx_state[i] = ctx_o[i];  // Use blocking assignment
          ctx_state[i].compute_start = 1'b0;
        end
      end
    end

    $display("ERROR: heads did not finish within %0d steps", MAX_STEPS);
    $finish;
  end

endmodule