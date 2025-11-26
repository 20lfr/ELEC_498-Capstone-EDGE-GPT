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
  initial begin : compute_model
    comp_busy = 1'b0;
    comp_timer = 0;
    compute_done = 1'b0;
    
    forever begin
      @(posedge ap_clk);
      
      // Complete outstanding compute operations
      compute_done <= 1'b0;
      if (comp_busy) begin
        if (comp_timer == 0) begin
          compute_done <= 1'b1;
          comp_busy <= 1'b0;
        end else begin
          comp_timer <= comp_timer - 1;
        end
      end
      
      // Latch new compute start
      if (compute_start && compute_start_ap_vld && !comp_busy) begin
        comp_busy <= 1'b1;
        comp_timer <= COMP_LAT - 1;
        
        // Track specific operations
        if (compute_op == 32'd4) seen_attn <= 1'b1;    // CMP_ATT_SCORES
        if (compute_op == 32'd9) seen_concat <= 1'b1;  // CMP_CONCAT
      end
      
      // Ready signal depends on busy flag
      compute_ready <= !comp_busy && !compute_done;
    end
  end

  // Stream model
  initial begin : stream_model
    stream_busy = 1'b0;
    stream_done = 1'b0;
    
    forever begin
      @(posedge ap_clk);
      
      // Single-cycle pulse after start
      stream_done <= 1'b0;
      if (stream_busy) begin
        stream_done <= 1'b1;
        stream_busy <= 1'b0;
      end
      
      // Latch new stream start
      if (stream_start && stream_start_ap_vld && !stream_busy) begin
        stream_busy <= 1'b1;
      end
      
      stream_ready <= !stream_busy;
    end
  end

  // DMA model for weight loader
  initial begin : dma_model
    dma_busy = 1'b0;
    dma_timer = 0;
    dma_done = 1'b0;
    wl_ready = 1'b1;

    forever begin
      @(posedge ap_clk);

      // Default deassert
      dma_done <= 1'b0;

      // Complete outstanding DMA transfers
      if (dma_busy) begin
        if (dma_timer == 0) begin
          dma_done <= 1'b1;
          dma_busy <= 1'b0;
        end else begin
          dma_timer <= dma_timer - 1;
        end
      end

      // Launch DMA when scheduler requests and we're idle/ready
      if (wl_start && wl_start_ap_vld && wl_ready && !dma_busy) begin
        dma_busy  <= 1'b1;
        dma_timer <= DMA_LAT - 1;
      end

      // Ready asserted when not busy
      wl_ready <= !dma_busy;
    end
  end

  // AXIS ingress driver
  initial begin : axis_driver
    axis_sent = 0;
    axis_feed_done = 1'b0;
    axis_drive = 1'b0;
    axis_in_valid = 1'b0;
    axis_in_last = 1'b0;
    
    forever begin
      @(posedge ap_clk);
      
      // Drive AXIS ingress: send a short burst when ready is asserted
      if (!axis_feed_done && (axis_drive || (cntrl_reset_n && start_pulsed))) begin
        axis_drive <= 1'b1;
        if (!axis_in_valid && axis_in_ready) begin
          axis_in_valid <= 1'b1;
          axis_in_last <= (axis_sent == AXIS_BEATS - 1);
        end
      end else begin
        axis_in_valid <= 1'b0;
        axis_in_last <= 1'b0;
      end
      
      // Consume AXIS transfer on handshake
      if (axis_in_valid && axis_in_ready) begin
        axis_sent <= axis_sent + 1;
        axis_in_valid <= 1'b0;
        axis_in_last <= 1'b0;
        if (axis_sent >= AXIS_BEATS - 1) begin
          axis_feed_done <= 1'b1;
          axis_drive <= 1'b0;
        end
      end
    end
  end

  // Simple static signals
  initial begin
    dma_done = 1'b0;
    requant_ready = 1'b1;
    requant_done = 1'b0;
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

endmodule
