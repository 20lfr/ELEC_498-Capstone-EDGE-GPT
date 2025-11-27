`timescale 1ns/1ps

// Grouped-head testbench mirroring drive_head_phase_tb.cpp behavior.
// Models compute_ready/compute_done with a simple latency counter per head and
// walks through head groups sequentially.
module drive_group_head_phase_tb;

  localparam int CLK_PERIOD  = 10;
  localparam int MAX_CYCLES  = 512;
  localparam int HEADS_TOTAL = 4;
  localparam int HEADS_PAR   = 1;
  localparam int GROUPS      = (HEADS_TOTAL + HEADS_PAR - 1) / HEADS_PAR;

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

  // Packed view of HeadCtx
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
  logic [1:0]  head_ctx_ref_address0;
  logic        head_ctx_ref_ce0;
  logic        head_ctx_ref_we0;
  logic [50:0] head_ctx_ref_d0;
  logic [50:0] head_ctx_ref_q0;
  logic [31:0] group_idx;
  logic [31:0] layer_idx;
  logic        start_r;
  logic [0:0]  ap_return;
  logic        ap_rst;

  // Context memory model + busy counters
  head_ctx_t head_ctx_mem   [0:HEADS_TOTAL-1];
  logic [3:0] busy_ctr      [0:HEADS_TOTAL-1];
  logic       inflight      [0:HEADS_TOTAL-1];

  // Memory read logic - combinational
  assign head_ctx_ref_q0 = head_ctx_mem[head_ctx_ref_address0];

  // Memory write logic - on clock edge
  always @(posedge clk) begin
    if (head_ctx_ref_ce0 && head_ctx_ref_we0) begin
      head_ctx_mem[head_ctx_ref_address0] <= head_ctx_ref_d0;
    end
  end

  drive_group_head_phase dut (
      .ap_clk              (clk),
      .ap_rst              (ap_rst),
      .ap_start            (ap_start),
      .ap_done             (ap_done),
      .ap_idle             (ap_idle),
      .ap_ready            (ap_ready),
      .head_ctx_ref_address0(head_ctx_ref_address0),
      .head_ctx_ref_ce0    (head_ctx_ref_ce0),
      .head_ctx_ref_we0    (head_ctx_ref_we0),
      .head_ctx_ref_d0     (head_ctx_ref_d0),
      .head_ctx_ref_q0     (head_ctx_ref_q0),
      .group_idx           (group_idx),
      .layer_idx           (layer_idx),
      .start_r             (start_r),
      .ap_return           (ap_return)
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

  task automatic init_ctx_mem();
    for (int h = 0; h < HEADS_TOTAL; ++h) begin
      head_ctx_mem[h] = '{compute_op: CMP_NONE,
                          compute_start: 1'b0,
                          compute_done: 1'b0,
                          compute_ready: 1'b0,
                          phase: PHASE_IDLE,
                          layer_stamp: layer_idx};
      busy_ctr[h] = 0;
      inflight[h] = 1'b0;
    end
  endtask

  // Drive reset/init
  initial begin
    ap_rst    = 1'b1;
    ap_start  = 1'b0;
    start_r   = 1'b0;
    group_idx = 32'd0;
    layer_idx = 32'd0;
    init_ctx_mem();
    repeat (3) @(posedge clk);
    ap_rst    = 1'b0;
    ap_start  = 1'b1;
  end

  // Cycle-by-cycle stimulus
  initial begin
    integer cycle;
    bit done_all;
    
    @(negedge ap_rst);
    
    $display("cycle | grp | head0_phase (rdy done start op) | head1_phase (rdy done start op) | head2_phase (rdy done start op) | head3_phase (rdy done start op)");
    
    done_all = 1'b0;
    for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
      int group_base;
      bit start_pulse;
      bit group_done;
      
      // BEFORE clock edge: Set up handshake signals for active group
      group_base = group_idx * HEADS_PAR;
      
      for (int h = 0; h < HEADS_TOTAL; ++h) begin
        if (h >= group_base && h < group_base + HEADS_PAR) begin
          // Active head: update handshake based on compute model
          head_ctx_mem[h].compute_ready = !inflight[h];
          head_ctx_mem[h].compute_done  = (inflight[h] && busy_ctr[h] == 0);
        end else begin
          // Inactive head: clear handshake
          head_ctx_mem[h].compute_ready = 1'b0;
          head_ctx_mem[h].compute_done  = 1'b0;
        end
      end
      
      // Check if any head in group is still IDLE to generate start pulse
      start_pulse = 1'b0;
      for (int lane = 0; lane < HEADS_PAR; ++lane) begin
        int h = group_base + lane;
        if (h < HEADS_TOTAL && head_ctx_mem[h].phase == PHASE_IDLE) begin
          start_pulse = 1'b1;
        end
      end
      start_r = start_pulse;
      
      @(posedge clk);
      
      // AFTER clock edge: Update internal state based on what DUT did
      for (int h = 0; h < HEADS_TOTAL; ++h) begin
        if (h >= group_base && h < group_base + HEADS_PAR) begin
          // Track compute_start from DUT output
          if (head_ctx_mem[h].compute_start && !inflight[h]) begin
            busy_ctr[h] = 3;  // Set latency
            inflight[h] = 1'b1;
          end else if (inflight[h]) begin
            if (busy_ctr[h] > 0) begin
              busy_ctr[h]--;
            end else begin
              // Done signal was asserted, clear inflight
              inflight[h] = 1'b0;
            end
          end
        end
      end
      
      // Log current state
      $display("%0d    | %0d   | %-6s (%0d   %0d   %0d   %s) | %-6s (%0d   %0d   %0d   %s) | %-6s (%0d   %0d   %0d   %s) | %-6s (%0d   %0d   %0d   %s)",
               cycle,
               group_idx,
               phase_name(head_ctx_mem[0].phase), head_ctx_mem[0].compute_ready, head_ctx_mem[0].compute_done, head_ctx_mem[0].compute_start, op_name(head_ctx_mem[0].compute_op),
               phase_name(head_ctx_mem[1].phase), head_ctx_mem[1].compute_ready, head_ctx_mem[1].compute_done, head_ctx_mem[1].compute_start, op_name(head_ctx_mem[1].compute_op),
               phase_name(head_ctx_mem[2].phase), head_ctx_mem[2].compute_ready, head_ctx_mem[2].compute_done, head_ctx_mem[2].compute_start, op_name(head_ctx_mem[2].compute_op),
               phase_name(head_ctx_mem[3].phase), head_ctx_mem[3].compute_ready, head_ctx_mem[3].compute_done, head_ctx_mem[3].compute_start, op_name(head_ctx_mem[3].compute_op));
      
      // Check if current group is done
      group_done = 1'b1;
      for (int lane = 0; lane < HEADS_PAR; ++lane) begin
        int h = group_base + lane;
        if (h >= HEADS_TOTAL) continue;
        if (head_ctx_mem[h].phase != PHASE_DONE || inflight[h]) begin
          group_done = 1'b0;
        end
      end
      
      // Advance to next group if current group is done
      if (group_done && !done_all) begin
        if (group_idx + 1 >= GROUPS) begin
          done_all = 1'b1;
        end else begin
          group_idx = group_idx + 1;
        end
      end
      
      // Check if all heads are done
      if (done_all) begin
        $display("All head groups completed by cycle %0d", cycle);
        for (int h = 0; h < HEADS_TOTAL; ++h) begin
          if (head_ctx_mem[h].phase != PHASE_DONE) begin
            $fatal(1, "Head %0d did not reach DONE", h);
          end
        end
        $finish;
      end
    end
    
    $fatal(1, "Timeout: heads did not reach DONE by %0d cycles", MAX_CYCLES);
  end

endmodule