`timescale 1ns / 1ps

module scheduler_hls_tb;
    localparam int MAX_CYCLES   = 4000;
    localparam int AXIS_TOKENS  = 4;
    localparam int DMA_LATENCY  = 2;
    localparam int COMP_LATENCY = 3;
    localparam int STRM_LATENCY = 8;
    localparam int RQ_LATENCY   = 3;

    // Clock / reset / control
    reg ap_clk = 0;
    reg ap_rst = 1;
    reg ap_start = 0;
    wire ap_done;
    wire ap_idle;
    wire ap_ready;

    reg        cntrl_start = 0;
    wire [31:0] cntrl_layer_idx;
    wire        cntrl_layer_idx_ap_vld;

    // AXI ingress
    reg axis_in_valid = 0;
    reg axis_in_last  = 0;
    wire axis_in_ready;
    wire axis_in_ready_ap_vld;

    // DMA / compute / stream interfaces
    reg        wl_ready = 0;
    wire       wl_start;
    wire       wl_start_ap_vld;
    wire [31:0] wl_addr_sel;
    wire        wl_addr_sel_ap_vld;
    wire [31:0] wl_layer;
    wire        wl_layer_ap_vld;
    wire [31:0] wl_head;
    wire        wl_head_ap_vld;
    wire [31:0] wl_tile;
    wire        wl_tile_ap_vld;

    reg  dma_done = 0;

    reg  compute_ready = 1;
    reg  compute_done  = 0;
    wire compute_start;
    wire compute_start_ap_vld;
    wire [31:0] compute_op;
    wire        compute_op_ap_vld;

    reg  requant_ready = 1;
    reg  requant_done  = 0;
    wire requant_start;
    wire requant_start_ap_vld;
    wire [31:0] requant_op;
    wire        requant_op_ap_vld;

    reg  stream_ready = 1;
    wire stream_start;
    wire stream_start_ap_vld;
    reg  stream_done  = 0;

    wire done;
    wire done_ap_vld;
    wire [31:0] STATE;
    wire STATE_ap_vld;

    // DUT --------------------------------------------------------------------
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

    // Clock gen
    always #5 ap_clk = ~ap_clk; // 100 MHz

    // AXIS ingress driver ----------------------------------------------------
    reg axis_feed_done = 0;
    int axis_sent = 0;

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            axis_in_valid  <= 0;
            axis_in_last   <= 0;
            axis_feed_done <= 0;
            axis_sent      <= 0;
        end else begin
            if (!axis_feed_done && cntrl_start) begin
                axis_in_valid <= 1;
                axis_in_last  <= (axis_sent == AXIS_TOKENS - 1);
                if (axis_in_valid && axis_in_ready) begin
                    axis_sent <= axis_sent + 1;
                    if (axis_sent == AXIS_TOKENS - 1) begin
                        axis_feed_done <= 1;
                        axis_in_valid  <= 0;
                        axis_in_last   <= 0;
                    end
                end
            end else begin
                axis_in_valid <= 0;
                axis_in_last  <= 0;
            end
        end
    end

    // DMA responder ----------------------------------------------------------
    bit dma_busy = 0;
    int dma_timer = 0;

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            wl_ready <= 0;
            dma_busy <= 0;
            dma_timer<= 0;
            dma_done <= 0;
        end else begin
            wl_ready <= !dma_busy;
            dma_done <= 0;
            if (dma_busy) begin
                if (dma_timer == 0) begin
                    dma_done <= 1;
                    dma_busy <= 0;
                end else begin
                    dma_timer <= dma_timer - 1;
                end
            end
            if (wl_start_ap_vld && wl_start) begin
                if (dma_busy) begin
                    $error("DMA overlap detected at time %0t", $time);
                end else begin
                    dma_busy  <= 1;
                    dma_timer <= DMA_LATENCY - 1;
                end
            end
        end
    end

    // Compute responder ------------------------------------------------------
    bit comp_busy = 0;
    int comp_timer = 0;

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            compute_ready <= 1;
            compute_done  <= 0;
            comp_busy     <= 0;
            comp_timer    <= 0;
        end else begin
            compute_ready <= !comp_busy;
            compute_done  <= 0;
            if (comp_busy) begin
                if (comp_timer == 0) begin
                    compute_done <= 1;
                    comp_busy    <= 0;
                end else begin
                    comp_timer <= comp_timer - 1;
                end
            end
            if (compute_start_ap_vld && compute_start) begin
                if (comp_busy) begin
                    $error("Compute overlap detected at time %0t", $time);
                end else begin
                    comp_busy  <= 1;
                    comp_timer <= COMP_LATENCY - 1;
                end
            end
        end
    end

    // Requant responder -----------------------------------------------------
    bit rq_busy = 0;
    int rq_timer = 0;

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            requant_ready <= 1;
            requant_done  <= 0;
            rq_busy       <= 0;
            rq_timer      <= 0;
        end else begin
            requant_ready <= !rq_busy;
            requant_done  <= 0;
            if (rq_busy) begin
                if (rq_timer == 0) begin
                    requant_done <= 1;
                    rq_busy      <= 0;
                end else begin
                    rq_timer <= rq_timer - 1;
                end
            end
            if (requant_start_ap_vld && requant_start) begin
                if (rq_busy) begin
                    $error("Requant overlap detected at time %0t", $time);
                end else begin
                    rq_busy  <= 1;
                    rq_timer <= RQ_LATENCY - 1;
                end
            end
        end
    end

    // Stream responder -------------------------------------------------------
    bit strm_busy = 0;
    int strm_timer = 0;

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            stream_ready <= 1;
            stream_done  <= 0;
            strm_busy    <= 0;
            strm_timer   <= 0;
        end else begin
            stream_ready <= !strm_busy;
            stream_done  <= 0;
            if (strm_busy) begin
                if (strm_timer == 0) begin
                    stream_done <= 1;
                    strm_busy   <= 0;
                end else begin
                    strm_timer <= strm_timer - 1;
                end
            end
            if (stream_start_ap_vld && stream_start) begin
                if (strm_busy) begin
                    $error("Stream overlap detected at time %0t", $time);
                end else begin
                    strm_busy  <= 1;
                    strm_timer <= STRM_LATENCY - 1;
                end
            end
        end
    end

    // Control stimulus -------------------------------------------------------
    initial begin
        // hold reset for a few cycles
        repeat (8) @(posedge ap_clk);
        ap_rst       <= 0;
        ap_start     <= 1;
        cntrl_start  <= 1;
    end

    always_ff @(posedge ap_clk) begin
        if (ap_rst) begin
            cntrl_start   <= 0;
            cntrl_reset_n <= 0;
        end else begin
            cntrl_reset_n <= 1;
            if (done_ap_vld && done) begin
                cntrl_start <= 0;
            end
        end
    end

    // Monitoring -------------------------------------------------------------
    function string state_name(input logic [31:0] st_code);
        case (st_code[3:0])
            4'd0:  state_name = "S_IDLE";
            4'd1:  state_name = "S_START";
            4'd2:  state_name = "S_LAYER_CNT";
            4'd3:  state_name = "S_ATT_HEAD";
            4'd4:  state_name = "S_HEAD_CON";
            4'd5:  state_name = "S_OUT_PROJ";
            4'd6:  state_name = "S_RES1";
            4'd7:  state_name = "S_LN1";
            4'd8:  state_name = "S_FFN";
            4'd9:  state_name = "S_RES2";
            4'd10: state_name = "S_LN2";
            4'd11: state_name = "S_LOOP";
            4'd12: state_name = "S_STREAM";
            default: state_name = $sformatf("0x%0h", st_code);
        endcase
    endfunction

    initial begin : monitor_loop
        bit done_seen = 0;
        int cycle;
        @(negedge ap_rst); // wait for reset deassert
        $display("Cycle  Start  Reset  Layer | AXIS_valid AXIS_last  AXIS_ready | State");
        for (cycle = 0; cycle < MAX_CYCLES; cycle++) begin
            @(posedge ap_clk);
            $display("%5d    %0b      %0b      %0d   |     %0b         %0b           %0b      | %s",
                     cycle,
                     cntrl_start,
                     cntrl_reset_n,
                     cntrl_layer_idx,
                     axis_in_valid,
                     axis_in_last,
                     axis_in_ready,
                     state_name(STATE));
            if (done_ap_vld && done) begin
                $display("Scheduler completed at cycle %0d", cycle);
                done_seen = 1;
                break;
            end
        end

        if (!done_seen) begin
            $error("Scheduler did not complete within %0d cycles", MAX_CYCLES);
        end
        #50;
        $finish;
    end

endmodule
