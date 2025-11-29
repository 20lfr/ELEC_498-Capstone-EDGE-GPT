`timescale 1ns/1ps

// Enhanced testbench for scheduler_hls RTL matching C++ testbench functionality
module scheduler_hls_tb;
  localparam int CLK_PERIOD = 10;
  localparam int MAX_CYCLES = 2000;
  localparam int COMP_LAT = 3;
  localparam int DMA_LAT  = 3;
  localparam int AXIS_BEATS = 3;

  // Clock / reset
  logic ap_clk = 1'b0;
  logic ap_rst = 1'b1;
  always #(CLK_PERIOD/2) ap_clk = ~ap_clk;

  // DUT inputs
  logic ap_start;
  logic [0:0] cntrl_start;
  logic [0:0] cntrl_reset_n;
  logic [0:0] axis_in_valid;
  logic [0:0] axis_in_last;
  logic [0:0] wl_ready;
  logic [0:0] dma_done;
  logic [0:0] compute_ready;
  logic [0:0] compute_done;
  logic [0:0] requant_ready;
  logic [0:0] requant_done;
  logic [0:0] stream_ready;
  logic [0:0] stream_done;

  // DUT outputs
  logic ap_done;
  logic ap_idle;
  logic ap_ready;
  logic [31:0] cntrl_layer_idx;
  logic cntrl_layer_idx_ap_vld;
  logic [0:0] cntrl_busy;
  logic cntrl_busy_ap_vld;
  logic [0:0] cntrl_start_out;
  logic cntrl_start_out_ap_vld;
  logic [0:0] axis_in_ready;
  logic axis_in_ready_ap_vld;
  logic [0:0] wl_start;
  logic wl_start_ap_vld;
  logic [31:0] wl_addr_sel;
  logic wl_addr_sel_ap_vld;
  logic [31:0] wl_layer;
  logic wl_layer_ap_vld;
  logic [31:0] wl_head;
  logic wl_head_ap_vld;
  logic [31:0] wl_tile;
  logic wl_tile_ap_vld;
  logic [0:0] compute_start;
  logic compute_start_ap_vld;
  logic [31:0] compute_op;
  logic compute_op_ap_vld;
  logic [0:0] requant_start;
  logic requant_start_ap_vld;
  logic [31:0] requant_op;
  logic requant_op_ap_vld;
  logic [0:0] stream_start;
  logic stream_start_ap_vld;
  logic [0:0] done;
  logic done_ap_vld;
  logic [31:0] STATE;
  logic STATE_ap_vld;
  logic [31:0] debug_compute_done;
  // Head context interfaces (4 lanes)
  logic [65:0] head_ctx_ref_0_i, head_ctx_ref_0_o;
  logic        head_ctx_ref_0_o_ap_vld;
  logic [65:0] head_ctx_ref_1_i, head_ctx_ref_1_o;
  logic        head_ctx_ref_1_o_ap_vld;
  logic [65:0] head_ctx_ref_2_i, head_ctx_ref_2_o;
  logic        head_ctx_ref_2_o_ap_vld;
  logic [65:0] head_ctx_ref_3_i, head_ctx_ref_3_o;
  logic        head_ctx_ref_3_o_ap_vld;

  // Testbench state variables
  logic comp_busy;
  int comp_timer;
  logic dma_busy;
  int dma_timer;
  logic stream_busy;
  logic start_pulsed;
  logic seen_done;
  int post_done_cycles;
  logic seen_idle_after;
  logic seen_attn;
  logic seen_concat;
  int axis_sent;
  logic axis_feed_done;
  logic axis_drive;
  // Head compute model
  localparam int HEADS_TOTAL = 4;
  localparam int HEADS_PAR   = 4;
  typedef struct packed {
    logic        att_value_compute_done;   // [65]
    logic        softmax_compute_done;     // [64]
    logic        val_scale_compute_done;  // [63]
    logic        att_scores_compute_done; // [62]
    logic        v_compute_done;          // [61]
    logic        k_compute_done;          // [60]
    logic        q_compute_done;          // [59]
    logic        att_value_started;       // [58]
    logic        softmax_started;         // [57]
    logic        val_scale_started;       // [56]
    logic        att_scores_started;      // [55]
    logic        v_started;               // [54]
    logic        k_started;               // [53]
    logic        q_started;               // [52]
    logic        start_head;              // [51]
    logic [7:0]  compute_op;              // [50:43]
    logic        compute_start;           // [42]
    logic        compute_done;            // [41]
    logic        compute_ready;           // [40]
    logic [7:0]  phase;                   // [39:32]
    logic [31:0] layer_stamp;             // [31:0]
  } head_ctx_t;
  // Debug visibility
  logic [7:0] head_phase_dbg   [0:HEADS_TOTAL-1];
  logic [7:0] head_op_dbg      [0:HEADS_TOTAL-1];

  head_ctx_t head_ctx_shadow   [0:HEADS_TOTAL-1];
  logic [3:0] head_busy_ctr    [0:HEADS_TOTAL-1];
  logic       head_inflight    [0:HEADS_TOTAL-1];
  logic       head_done_hold   [0:HEADS_TOTAL-1];
  logic [2:0] head_done_ctr    [0:HEADS_TOTAL-1];
  logic       head_compute_ready [0:HEADS_TOTAL-1];
  logic       head_compute_done  [0:HEADS_TOTAL-1];
  // Main compute done hold
  logic       comp_done_hold;
  logic [2:0] comp_done_ctr;
  // DMA done hold
  logic       dma_done_hold;
  logic [2:0] dma_done_ctr;
  // Stream done hold
  logic       stream_done_hold;
  logic [2:0] stream_done_ctr;
  

  // Helper to decode DMA select
  function string dma_name(input [31:0] sel);
    case (sel)
      32'd0:  return "NONE";
      32'd1:  return "WQ";
      32'd2:  return "WK";
      32'd3:  return "WV";
      32'd4:  return "CTX_K";
      32'd5:  return "CTX_V";
      32'd6:  return "K_WR";
      32'd7:  return "V_WR";
      32'd8:  return "WO";
      32'd9:  return "W1";
      32'd10: return "W2";
      32'd11: return "WLOGIT";
      default: return "UNK";
    endcase
  endfunction


  // Compute model with latency
  always_ff @(posedge ap_clk) begin : compute_model
    if (ap_rst) begin
      comp_busy    <= 1'b0;
      comp_timer   <= 0;
      compute_done <= 1'b0;
      comp_done_hold <= 1'b0;
      comp_done_ctr <= 0;
      compute_ready<= 1'b0;
    end else begin
      compute_done <= 1'b0;
      if (comp_busy) begin
        if (comp_timer == 0) begin
          comp_done_hold <= 1'b1;
          comp_done_ctr  <= 3'd2;
          comp_busy <= 1'b0;
        end else begin
          comp_timer <= comp_timer - 1;
        end
      end
      // Hold compute_done for a few cycles
      if (comp_done_hold) begin
        compute_done <= 1'b1;
        if (comp_done_ctr == 0) begin
          comp_done_hold <= 1'b0;
        end else begin
          comp_done_ctr <= comp_done_ctr - 1;
        end
      end

      if (compute_start && compute_start_ap_vld && !comp_busy) begin
        comp_busy <= 1'b1;
        comp_timer <= COMP_LAT - 1;
        if (compute_op == 32'd4) seen_attn <= 1'b1;    // CMP_ATT_SCORES
        if (compute_op == 32'd9) seen_concat <= 1'b1;  // CMP_CONCAT
      end

      compute_ready <= !comp_busy && !compute_done;
    end
  end

  // Stream model
  always_ff @(posedge ap_clk) begin : stream_model
    if (ap_rst) begin
      stream_busy  <= 1'b0;
      stream_done  <= 1'b0;
      stream_done_hold <= 1'b0;
      stream_done_ctr  <= 0;
      stream_ready <= 1'b0;
    end else begin
      stream_done <= 1'b0;
      if (stream_busy) begin
        stream_busy <= 1'b0;
        stream_done_hold <= 1'b1;
        stream_done_ctr  <= 3'd2; // hold done high for a couple extra cycles
      end
      if (stream_done_hold) begin
        stream_done <= 1'b1;
        if (stream_done_ctr == 0) begin
          stream_done_hold <= 1'b0;
        end else begin
          stream_done_ctr <= stream_done_ctr - 1;
        end
      end
      if (stream_start && stream_start_ap_vld && !stream_busy) begin
        stream_busy <= 1'b1;
      end
      stream_ready <= !stream_busy;
    end
  end

  // DMA model for weight loader
  always_ff @(posedge ap_clk) begin : dma_model
    if (ap_rst) begin
      dma_busy  <= 1'b0;
      dma_timer <= 0;
      dma_done  <= 1'b0;
      dma_done_hold <= 1'b0;
      dma_done_ctr  <= 0;
      wl_ready  <= 1'b0;
    end else begin
      dma_done <= 1'b0;
      if (dma_busy) begin
        if (dma_timer == 0) begin
          dma_busy <= 1'b0;
          dma_done_hold <= 1'b1;
          dma_done_ctr  <= 3'd2; // hold done high for a couple of extra cycles
        end else begin
          dma_timer <= dma_timer - 1;
        end
      end
      if (dma_done_hold) begin
        dma_done <= 1'b1;
        if (dma_done_ctr == 0) begin
          dma_done_hold <= 1'b0;
        end else begin
          dma_done_ctr <= dma_done_ctr - 1;
        end
      end
      if (wl_start && wl_start_ap_vld && wl_ready && !dma_busy) begin
        dma_busy  <= 1'b1;
        dma_timer <= DMA_LAT - 1;
      end
      wl_ready <= !dma_busy;
    end
  end

  // AXIS ingress driver
  always_ff @(posedge ap_clk) begin : axis_driver
    if (ap_rst) begin
      axis_sent      <= 0;
      axis_feed_done <= 1'b0;
      axis_drive     <= 1'b0;
      axis_in_valid  <= 1'b0;
      axis_in_last   <= 1'b0;
    end else begin
      if (!axis_feed_done && (axis_drive || (cntrl_reset_n && start_pulsed))) begin
        axis_drive <= 1'b1;
        if (!axis_in_valid && axis_in_ready) begin
          axis_in_valid <= 1'b1;
          axis_in_last  <= (axis_sent == AXIS_BEATS - 1);
        end
      end else begin
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
      end

      if (axis_in_valid && axis_in_ready) begin
        axis_sent <= axis_sent + 1;
        axis_in_valid <= 1'b0;
        axis_in_last  <= 1'b0;
        if (axis_sent >= AXIS_BEATS - 1) begin
          axis_feed_done <= 1'b1;
          axis_drive     <= 1'b0;
        end
      end
    end
  end

  // Per-head compute model (separate from main compute)
  always_comb begin
    for (int h = 0; h < HEADS_TOTAL; h++) begin
      head_compute_ready[h] = !head_inflight[h] && !head_done_hold[h];
      head_compute_done[h]  = head_done_hold[h];
    end
  end

  // Pack head_ctx_ref_i with current shadow + computed ready/done
  always_comb begin
    head_ctx_t t0, t1, t2, t3;
    t0 = head_ctx_shadow[0];
    t1 = head_ctx_shadow[1];
    t2 = head_ctx_shadow[2];
    t3 = head_ctx_shadow[3];
    t0.compute_ready = head_compute_ready[0];
    t1.compute_ready = head_compute_ready[1];
    t2.compute_ready = head_compute_ready[2];
    t3.compute_ready = head_compute_ready[3];
    t0.compute_done  = head_compute_done[0];
    t1.compute_done  = head_compute_done[1];
    t2.compute_done  = head_compute_done[2];
    t3.compute_done  = head_compute_done[3];
    head_ctx_ref_0_i = t0;
    head_ctx_ref_1_i = t1;
    head_ctx_ref_2_i = t2;
    head_ctx_ref_3_i = t3;
  end

  // Capture DUT head_ctx outputs and drive per-head compute latencies
  generate
    genvar hh;
    for (hh = 0; hh < HEADS_TOTAL; hh++) begin : HEAD_COMPUTE
      always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
          head_ctx_shadow[hh] <= '{default:0};
          head_ctx_shadow[hh].phase <= 0;
          head_busy_ctr[hh] <= 0;
          head_inflight[hh] <= 1'b0;
          head_done_hold[hh] <= 1'b0;
          head_done_ctr[hh] <= 0;
        end else begin
          head_ctx_shadow[hh].compute_start <= 1'b0;
          // update shadow when corresponding output valid
          if (hh == 0 && head_ctx_ref_0_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_0_o;
          if (hh == 1 && head_ctx_ref_1_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_1_o;
          if (hh == 2 && head_ctx_ref_2_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_2_o;
          if (hh == 3 && head_ctx_ref_3_o_ap_vld) head_ctx_shadow[hh] <= head_ctx_ref_3_o;
          head_phase_dbg[hh] <= head_ctx_shadow[hh].phase;
          head_op_dbg[hh]    <= head_ctx_shadow[hh].compute_op;

          // detect compute_start from shadow (from previous cycle)
          if (!head_inflight[hh] && !head_done_hold[hh] && head_ctx_shadow[hh].compute_start) begin
            head_inflight[hh] <= 1'b1;
            head_busy_ctr[hh] <= COMP_LAT - 1;
            head_done_hold[hh] <= 1'b0;
          end else if (head_inflight[hh]) begin
            if (head_busy_ctr[hh] == 0) begin
              head_inflight[hh] <= 1'b0;
              head_done_hold[hh] <= 1'b1;
              head_done_ctr[hh] <= 3'd4;
            end else begin
              head_busy_ctr[hh] <= head_busy_ctr[hh] - 1;
            end
          end else if (head_done_hold[hh]) begin
            if (head_done_ctr[hh] > 0) begin
              head_done_ctr[hh] <= head_done_ctr[hh] - 1;
            end else begin
              head_done_hold[hh] <= 1'b0;
            end
          end
        end
      end
    end
  endgenerate

  // Requant static drives
  always_ff @(posedge ap_clk) begin
    if (ap_rst) begin
      requant_ready <= 1'b0;
      requant_done  <= 1'b0;
    end else begin
      requant_ready <= 1'b1;
      requant_done  <= 1'b0;
    end
  end

  // Main stimulus and control
  initial begin : stimulus
    int cycle;
    
    // Initialize
    ap_start = 1'b0;
    cntrl_start = 1'b0;
    cntrl_reset_n = 1'b0;
    start_pulsed = 1'b0;
    seen_done = 1'b0;
    post_done_cycles = 0;
    seen_idle_after = 1'b0;
    seen_attn = 1'b0;
    seen_concat = 1'b0;

    // Print header
    $display("%-8s %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-6s %-6s %-8s %-6s %-6s | %-8s %-8s %-8s %-6s",
             "Cycle", "Start", "Reset", "Busy", "State",
             "AXIS_v", "AXIS_r", "AXIS_last",
             "WL_rdy", "WL_strt", "WL_addr", "WL_head", "WL_tile",
             "CmpStrt", "CmpRdy", "CmpDone", "CmpOp");

    // Release reset at cycle 2
    repeat(2) @(posedge ap_clk);
    ap_rst = 1'b0;
    cntrl_reset_n = 1'b1;
    ap_start = 1'b1; // Hold high continuously to mirror C++ model calling every cycle
    
    @(posedge ap_clk);

    // Main test loop
    for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
      @(posedge ap_clk);
      
      // Issue a single-cycle start pulse once after reset deasserts
      if (cntrl_reset_n && !start_pulsed) begin
        cntrl_start <= 1'b1;
        start_pulsed <= 1'b1;
      end else if (cntrl_busy) begin
        cntrl_start <= 1'b0;
      end
      
      // Print state
      $display("%-8d %-6s %-6s %-8s | %-12s | %-6s %-6s %-8s | %-6s %-6s %-8s %-6d %-6d | %-8s %-8s %-8s %-6d",
               cycle,
               cntrl_start ? "1" : "-",
               cntrl_reset_n ? "1" : "-",
               cntrl_busy ? "1" : "-",
               state_name(STATE),
               axis_in_valid ? "1" : "-",
               axis_in_ready ? "1" : "-",
               axis_in_last ? "1" : "-",
               wl_ready ? "1" : "-",
               wl_start ? "1" : "-",
               dma_name(wl_addr_sel),
               wl_head,
               wl_tile,
               compute_start ? "1" : "-",
               compute_ready ? "1" : "-",
               compute_done ? "1" : "-",
               compute_op);
      
      // Track done signal
      if (done) begin
        seen_done <= 1'b1;
        cntrl_start <= 1'b0;
      end
      
      if (seen_done) begin
        post_done_cycles <= post_done_cycles + 1;
        if (post_done_cycles >= 4) begin
          seen_idle_after <= 1'b1;
        end
      end
      
      // Exit condition: idle after done
      if (!cntrl_busy && !cntrl_start && seen_done && seen_idle_after) begin
        break;
      end
    end

    // Check results
    if (!seen_done) begin
      $display("ERROR: DONE never asserted");
      $finish(1);
    end
    if (!seen_idle_after) begin
      $display("ERROR: FSM did not return to IDLE after DONE");
      $finish(1);
    end
    if (!seen_attn) begin
      $display("ERROR: ATT_SCORES compute op never issued");
      $finish(1);
    end
    if (!seen_concat) begin
      $display("ERROR: CONCAT compute op never issued");
      $finish(1);
    end

    $display("\nPASS: DONE observed and FSM returned to IDLE after %0d post-done cycles. Layer=%0d",
             post_done_cycles, cntrl_layer_idx);
    $finish(0);
  end

  // Helper function to convert state to string
  function string state_name(input [31:0] st);
    case (st)
      32'd0:  return "S_IDLE";
      32'd1:  return "S_STREAM_IN";
      32'd2:  return "S_LAYER_COUNT";
      32'd3:  return "S_ATT_HEADS";
      32'd4:  return "S_HEAD_CONCAT";
      32'd5:  return "S_OUT_PROJ";
      32'd6:  return "S_RES_ADD_1";
      32'd7:  return "S_LN_1";
      32'd8:  return "S_FFN";
      32'd9:  return "S_RES_ADD_2";
      32'd10: return "S_LN_2";
      32'd11: return "S_LOOP_CHECK";
      32'd12: return "S_STREAM_OUT";
      default: return "UNKNOWN";
    endcase
  endfunction

  // DUT instantiation
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
    .cntrl_busy(cntrl_busy),
    .cntrl_busy_ap_vld(cntrl_busy_ap_vld),
    .cntrl_start_out(cntrl_start_out),
    .cntrl_start_out_ap_vld(cntrl_start_out_ap_vld),
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
    .head_ctx_ref_0_i(head_ctx_ref_0_i),
    .head_ctx_ref_0_o(head_ctx_ref_0_o),
    .head_ctx_ref_0_o_ap_vld(head_ctx_ref_0_o_ap_vld),
    .head_ctx_ref_1_i(head_ctx_ref_1_i),
    .head_ctx_ref_1_o(head_ctx_ref_1_o),
    .head_ctx_ref_1_o_ap_vld(head_ctx_ref_1_o_ap_vld),
    .head_ctx_ref_2_i(head_ctx_ref_2_i),
    .head_ctx_ref_2_o(head_ctx_ref_2_o),
    .head_ctx_ref_2_o_ap_vld(head_ctx_ref_2_o_ap_vld),
    .head_ctx_ref_3_i(head_ctx_ref_3_i),
    .head_ctx_ref_3_o(head_ctx_ref_3_o),
    .head_ctx_ref_3_o_ap_vld(head_ctx_ref_3_o_ap_vld),
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
    .debug_compute_done(debug_compute_done),
    .STATE(STATE),
    .STATE_ap_vld(STATE_ap_vld)
  );

endmodule
