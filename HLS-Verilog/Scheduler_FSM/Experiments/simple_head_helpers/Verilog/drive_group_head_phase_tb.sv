`timescale 1ns/1ps

// Concurrent testbench using always blocks for proper parallel modeling
module drive_group_head_phase_tb;

  localparam int CLK_PERIOD  = 10;
  localparam int MAX_CYCLES  = 1024;
  localparam int HEADS_TOTAL = 2;
  localparam int HEADS_PAR   = 2;
  localparam int GROUPS      = (HEADS_TOTAL + HEADS_PAR - 1) / HEADS_PAR;

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
    logic        att_value_compute_done;   // [65]
    logic        softmax_compute_done;     // [64]
    logic        val_scale_compute_done;   // [63]
    logic        att_scores_compute_done;  // [62]
    logic        v_compute_done;           // [61]
    logic        k_compute_done;           // [60]
    logic        q_compute_done;           // [59]
    logic        att_value_started;        // [58]
    logic        softmax_started;          // [57]
    logic        val_scale_started;        // [56]
    logic        att_scores_started;       // [55]
    logic        v_started;                // [54]
    logic        k_started;                // [53]
    logic        q_started;                // [52]
    logic        start_head;               // [51]
    logic [7:0]  compute_op;               // [50:43]
    logic        compute_start;            // [42]
    logic        compute_done;             // [41]
    logic        compute_ready;            // [40]
    logic [7:0]  phase;                    // [39:32]
    logic [31:0] layer_stamp;              // [31:0]
  } head_ctx_t;

  // Clock/reset
  logic clk = 1'b0;
  logic ap_rst;
  always #(CLK_PERIOD/2) clk = ~clk;

  // DUT interface
  logic        ap_start;
  logic        ap_done;
  logic        ap_idle;
  logic        ap_ready;
  logic [65:0] head_ctx_ref_0_i;
  logic [65:0] head_ctx_ref_0_o;
  logic        head_ctx_ref_0_o_ap_vld;
  logic [65:0] head_ctx_ref_1_i;
  logic [65:0] head_ctx_ref_1_o;
  logic        head_ctx_ref_1_o_ap_vld;
  logic [31:0] group_idx;
  logic [31:0] layer_idx;
  logic        start_r;
  logic [0:0]  ap_return;

  // Per-head compute model state
  logic [3:0] busy_ctr      [0:HEADS_TOTAL-1];
  logic       inflight      [0:HEADS_TOTAL-1];
  logic       done_hold     [0:HEADS_TOTAL-1];
  
  // Shadow: DUT's internal state (from outputs)
  head_ctx_t head_ctx_shadow [0:HEADS_TOTAL-1];
  
  // External compute handshakes (testbench -> DUT)
  logic ext_compute_ready [0:HEADS_TOTAL-1];
  logic ext_compute_done  [0:HEADS_TOTAL-1];

  // Group control
  logic [31:0] cycle_count;
  logic group_done;
  logic all_done;

  // Debug signals
  logic [7:0] head_phase_dbg [0:HEADS_TOTAL-1];
  logic [7:0] head_op_dbg    [0:HEADS_TOTAL-1];
  logic       head_q_started_dbg [0:HEADS_TOTAL-1];
  logic       head_k_started_dbg [0:HEADS_TOTAL-1];
  logic       head_v_started_dbg [0:HEADS_TOTAL-1];
  logic       head_q_compute_done_dbg [0:HEADS_TOTAL-1];
  logic       head_k_compute_done_dbg [0:HEADS_TOTAL-1];
  logic       head_v_compute_done_dbg [0:HEADS_TOTAL-1];

  genvar g;
  generate
    for (g = 0; g < HEADS_TOTAL; g++) begin : DBG_ALIAS
      assign head_phase_dbg[g] = head_ctx_shadow[g].phase;
      assign head_op_dbg[g]    = head_ctx_shadow[g].compute_op;
      assign head_q_started_dbg[g] = head_ctx_shadow[g].q_started;
      assign head_k_started_dbg[g] = head_ctx_shadow[g].k_started;
      assign head_v_started_dbg[g] = head_ctx_shadow[g].v_started;
      assign head_q_compute_done_dbg[g] = head_ctx_shadow[g].q_compute_done;
      assign head_k_compute_done_dbg[g] = head_ctx_shadow[g].k_compute_done;
      assign head_v_compute_done_dbg[g] = head_ctx_shadow[g].v_compute_done;
    end
  endgenerate

  drive_group_head_phase dut (
      .ap_clk              (clk),
      .ap_rst              (ap_rst),
      .ap_start            (ap_start),
      .ap_done             (ap_done),
      .ap_idle             (ap_idle),
      .ap_ready            (ap_ready),
      .head_ctx_ref_0_i    (head_ctx_ref_0_i),
      .head_ctx_ref_0_o    (head_ctx_ref_0_o),
      .head_ctx_ref_0_o_ap_vld(head_ctx_ref_0_o_ap_vld),
      .head_ctx_ref_1_i    (head_ctx_ref_1_i),
      .head_ctx_ref_1_o    (head_ctx_ref_1_o),
      .head_ctx_ref_1_o_ap_vld(head_ctx_ref_1_o_ap_vld),
      .group_idx           (group_idx),
      .layer_idx           (layer_idx),
      .start_r             (start_r),
      .ap_return           (ap_return)
  );

  function string phase_name(input [7:0] phase);
    case (phase)
      PHASE_IDLE: return "IDLE";
      PHASE_Q:    return "Q";
      PHASE_K:    return "K";
      PHASE_K_RQ: return "K_RQ";
      PHASE_K_WB: return "K_WB";
      PHASE_V:    return "V";
      PHASE_V_RQ: return "V_RQ";
      PHASE_V_WB: return "V_WB";
      PHASE_RQ_Q: return "RQ_Q";
      PHASE_ATT_SCORES: return "ATT_SCO";
      PHASE_VAL_SCL:    return "VAL_SCL";
      PHASE_SOFTMAX:    return "SOFT";
      PHASE_ATT_VAL:    return "ATT_VAL";
      PHASE_RQ2:  return "RQ2";
      PHASE_DONE: return "DONE";
      default:    return "?";
    endcase
  endfunction

  function string op_name(input [7:0] op);
    case (op)
      CMP_Q: return "CMP_Q";
      CMP_K: return "CMP_K";
      CMP_V: return "CMP_V";
      CMP_ATT_SCORES: return "CMP_SCO";
      CMP_VAL_SCL:    return "CMP_SCL";
      CMP_SOFTMAX:    return "CMP_SFM";
      CMP_ATT_VAL:    return "CMP_VAL";
      default: return "-";
    endcase
  endfunction

  // ========================================================================
  // COMBINATIONAL: Build DUT inputs from shadow + external handshakes
  // ========================================================================
  always_comb begin
    head_ctx_t temp0, temp1;
    int group_base;
    
    group_base = group_idx * HEADS_PAR;
    
    // Head 0
    temp0 = head_ctx_shadow[0];
    if (0 >= group_base && 0 < group_base + HEADS_PAR) begin
      temp0.compute_ready = ext_compute_ready[0];
      temp0.compute_done  = ext_compute_done[0];
    end else begin
      temp0.compute_ready = 1'b0;
      temp0.compute_done  = 1'b0;
    end
    head_ctx_ref_0_i = temp0;
    
    // Head 1
    temp1 = head_ctx_shadow[1];
    if (1 >= group_base && 1 < group_base + HEADS_PAR) begin
      temp1.compute_ready = ext_compute_ready[1];
      temp1.compute_done  = ext_compute_done[1];
    end else begin
      temp1.compute_ready = 1'b0;
      temp1.compute_done  = 1'b0;
    end
    head_ctx_ref_1_i = temp1;
    
    // Start pulse
    start_r = 1'b0;
    for (int lane = 0; lane < HEADS_PAR; lane++) begin
      int h = group_base + lane;
      if (h < HEADS_TOTAL && head_ctx_shadow[h].phase == PHASE_IDLE) begin
        start_r = 1'b1;
      end
    end
  end

  // ========================================================================
  // COMBINATIONAL: Compute model - generate external handshakes
  // ========================================================================
  always_comb begin
    for (int h = 0; h < HEADS_TOTAL; h++) begin
      ext_compute_ready[h] = !inflight[h];
      ext_compute_done[h]  = ((inflight[h] && (busy_ctr[h] == 0)) || done_hold[h]);
    end
  end

  // ========================================================================
  // SEQUENTIAL: Update shadow from DUT outputs
  // ========================================================================
  always_ff @(posedge clk) begin
    if (ap_rst) begin
      for (int h = 0; h < HEADS_TOTAL; h++) begin
        head_ctx_shadow[h] <= '{
          compute_op: CMP_NONE,
          compute_start: 1'b0,
          compute_done: 1'b0,
          compute_ready: 1'b0,
          start_head: 1'b0,
          q_started: 1'b0,
          k_started: 1'b0,
          v_started: 1'b0,
          att_scores_started: 1'b0,
          val_scale_started: 1'b0,
          softmax_started: 1'b0,
          att_value_started: 1'b0,
          q_compute_done: 1'b0,
          k_compute_done: 1'b0,
          v_compute_done: 1'b0,
          att_scores_compute_done: 1'b0,
          val_scale_compute_done: 1'b0,
          softmax_compute_done: 1'b0,
          att_value_compute_done: 1'b0,
          phase: PHASE_IDLE,
          layer_stamp: layer_idx
        };
      end
    end else if (ap_start) begin
      if (head_ctx_ref_0_o_ap_vld) begin
        head_ctx_shadow[0] <= head_ctx_ref_0_o;
      end
      if (head_ctx_ref_1_o_ap_vld) begin
        head_ctx_shadow[1] <= head_ctx_ref_1_o;
      end
    end
  end

  // ========================================================================
  // SEQUENTIAL: Compute model state machine (per head, in parallel)
  // ========================================================================
  generate
    for (genvar h = 0; h < HEADS_TOTAL; h++) begin : COMPUTE_MODEL
      always_ff @(posedge clk) begin
        if (ap_rst) begin
          busy_ctr[h]  <= 0;
          inflight[h]  <= 1'b0;
          done_hold[h] <= 1'b0;
        end else begin
          int group_base = group_idx * HEADS_PAR;
          logic compute_start_now;
          
          // Sample compute_start from DUT outputs THIS cycle
          if (h == 0 && head_ctx_ref_0_o_ap_vld) begin
            compute_start_now = head_ctx_ref_0_o[42]; // bit 42 is compute_start
          end else if (h == 1 && head_ctx_ref_1_o_ap_vld) begin
            compute_start_now = head_ctx_ref_1_o[42];
          end else begin
            compute_start_now = 1'b0;
          end
          
          // Only update for heads in active group
          if (h >= group_base && h < group_base + HEADS_PAR) begin
            if (compute_start_now && !inflight[h] && !done_hold[h]) begin
              // Start compute
              busy_ctr[h]  <= 3;
              inflight[h]  <= 1'b1;
              done_hold[h] <= 1'b0;
            end else if (inflight[h]) begin
              // Count down
              if (busy_ctr[h] > 0) begin
                busy_ctr[h] <= busy_ctr[h] - 1;
              end else begin
                // Transition to done_hold
                inflight[h]  <= 1'b0;
                done_hold[h] <= 1'b1;
              end
            end else if (done_hold[h]) begin
              // Clear done_hold
              done_hold[h] <= 1'b0;
            end
          end
        end
      end
    end
  endgenerate

  // ========================================================================
  // SEQUENTIAL: Group management
  // ========================================================================
  always_ff @(posedge clk) begin
    if (ap_rst) begin
      group_idx <= 0;
      all_done <= 1'b0;
    end else begin
      // Check if current group is done
      int group_base = group_idx * HEADS_PAR;
      bit gd = 1'b1;
      
      for (int lane = 0; lane < HEADS_PAR; lane++) begin
        int h = group_base + lane;
        if (h < HEADS_TOTAL) begin
          if (head_ctx_shadow[h].phase != PHASE_DONE || inflight[h]) begin
            gd = 1'b0;
          end
        end
      end
      
      if (gd && !all_done) begin
        if (group_idx + 1 >= GROUPS) begin
          all_done <= 1'b1;
        end else begin
          group_idx <= group_idx + 1;
        end
      end
    end
  end

  // ========================================================================
  // SEQUENTIAL: Cycle counter and logging
  // ========================================================================
  always_ff @(posedge clk) begin
    if (ap_rst) begin
      cycle_count <= 0;
    end else begin
      cycle_count <= cycle_count + 1;
      
      // Log every cycle with valid signals
      $display("%0d %3d ret:%b | %-8s  %0d   %0d    %0d   %-5s  %0d   %0d   %0d   %0d   %0d   %0d  vld:%0d | %-8s  %0d   %0d    %0d   %-5s  %0d   %0d   %0d   %0d   %0d   %0d  vld:%0d |",
               cycle_count,
               group_idx,
               ap_return,
               phase_name(head_ctx_shadow[0].phase), 
               ext_compute_ready[0], 
               ext_compute_done[0], 
               head_ctx_shadow[0].compute_start, 
               op_name(head_ctx_shadow[0].compute_op),
               head_ctx_shadow[0].q_started,
               head_ctx_shadow[0].q_compute_done,
               head_ctx_shadow[0].k_started,
               head_ctx_shadow[0].k_compute_done,
               head_ctx_shadow[0].v_started,
               head_ctx_shadow[0].v_compute_done,
               head_ctx_ref_0_o_ap_vld,
               phase_name(head_ctx_shadow[1].phase), 
               ext_compute_ready[1], 
               ext_compute_done[1], 
               head_ctx_shadow[1].compute_start, 
               op_name(head_ctx_shadow[1].compute_op),
               head_ctx_shadow[1].q_started,
               head_ctx_shadow[1].q_compute_done,
               head_ctx_shadow[1].k_started,
               head_ctx_shadow[1].k_compute_done,
               head_ctx_shadow[1].v_started,
               head_ctx_shadow[1].v_compute_done,
               head_ctx_ref_1_o_ap_vld);
      
      // Check completion
      if (all_done) begin
        $display("\n=== SUCCESS: All head groups completed by cycle %0d ===", cycle_count);
        for (int h = 0; h < HEADS_TOTAL; h++) begin
          if (head_ctx_shadow[h].phase != PHASE_DONE) begin
            $error("Head %0d did not reach DONE (phase=%s)", h, phase_name(head_ctx_shadow[h].phase));
          end
        end
        $finish;
      end
      
      if (cycle_count >= MAX_CYCLES) begin
        $error("TIMEOUT: Heads did not complete within %0d cycles", MAX_CYCLES);
        $finish;
      end
    end
  end

  // ========================================================================
  // INITIALIZATION
  // ========================================================================
  initial begin
    ap_rst    = 1'b1;
    ap_start  = 1'b0;
    layer_idx = 32'd0;
    cycle_count = 0;
    
    $display("cycle grp ret| %-8s rdy done strt op    qst qdn kst kdn vst vdn vld | %-8s rdy done strt op    qst qdn kst kdn vst vdn vld |",
             "head0", "head1");
    $display("----------------------------------------------------------------------------------------------------------------------------------------------");
    
    repeat (3) @(posedge clk);
    ap_rst    = 1'b0;
    ap_start  = 1'b1;
  end

endmodule