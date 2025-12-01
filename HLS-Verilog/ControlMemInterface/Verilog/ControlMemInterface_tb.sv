`timescale 1ns/1ps
`default_nettype none

module ControlMemInterface_tb;
    // DUT inputs
    logic         ap_start;
    logic         chip_enable;
    logic  [0:0]  read_control;
    logic  [0:0]  write_control;
    logic  [0:0]  reset_n;
    logic  [31:0] address;
    logic  [31:0] data_in;
    logic         ap_rst; // unused by RTL, tie low
    logic [863:0] mem_i;

    // DUT outputs
    wire         ap_done;
    wire         ap_idle;
    wire         ap_ready;
    wire [863:0] mem_o;
    wire         mem_o_ap_vld;
    wire [31:0]  data_out;
    wire         data_out_ap_vld;

    // Debug view of the control space (mirrors the C struct layout).
    typedef struct packed {
        logic [31:0] control;
        logic [31:0] layer_index;
        logic [31:0] status;
        logic [31:0] irq_status;
        logic [31:0] irq_enable;

        logic [31:0] dma_layer_len;
        logic [31:0] dma_head_len;
        logic [31:0] dma_tile_len;

        logic [31:0] layer_stride;
        logic [31:0] head_stride;
        logic [31:0] tile_stride;

        logic [31:0] wq_base_addr;
        logic [31:0] wk_base_addr;
        logic [31:0] wv_base_addr;
        logic [31:0] wo_base_addr;
        logic [31:0] w1_base_addr;
        logic [31:0] w2_base_addr;

        logic [31:0] k_cache_addr;
        logic [31:0] v_cache_addr;

        logic [31:0] logit_scale_qv;
        logic [31:0] scale_q;
        logic [31:0] zero_point_q;
        logic [31:0] scale_k;
        logic [31:0] zero_point_k;
        logic [31:0] scale_v;
        logic [31:0] zero_point_v;

        logic [31:0] reserved_debug;
    } ControlMemSpace;

    ControlMemSpace dbg_mem;

    // Local storage that mirrors mem_i/mem_o in 27 words (32-bit each).
    logic [31:0] mem_words [0:26];

    // Pack/unpack helpers
    function automatic logic [863:0] pack_words();
        logic [863:0] tmp;
        integer i;
        begin
            tmp = '0;
            for (i = 0; i < 27; i = i + 1) begin
                tmp[i*32 +: 32] = mem_words[i];
            end
            return tmp;
        end
    endfunction

    task automatic unpack_words(input logic [863:0] vec);
        integer i;
        begin
            for (i = 0; i < 27; i = i + 1) begin
                mem_words[i] = vec[i*32 +: 32];
            end
            dbg_mem.control        = mem_words[0];
            dbg_mem.layer_index    = mem_words[1];
            dbg_mem.status         = mem_words[2];
            dbg_mem.irq_status     = mem_words[3];
            dbg_mem.irq_enable     = mem_words[4];

            dbg_mem.dma_layer_len  = mem_words[5];
            dbg_mem.dma_head_len   = mem_words[6];
            dbg_mem.dma_tile_len   = mem_words[7];

            dbg_mem.layer_stride   = mem_words[8];
            dbg_mem.head_stride    = mem_words[9];
            dbg_mem.tile_stride    = mem_words[10];

            dbg_mem.wq_base_addr   = mem_words[11];
            dbg_mem.wk_base_addr   = mem_words[12];
            dbg_mem.wv_base_addr   = mem_words[13];
            dbg_mem.wo_base_addr   = mem_words[14];
            dbg_mem.w1_base_addr   = mem_words[15];
            dbg_mem.w2_base_addr   = mem_words[16];

            dbg_mem.k_cache_addr   = mem_words[17];
            dbg_mem.v_cache_addr   = mem_words[18];

            dbg_mem.logit_scale_qv = mem_words[19];
            dbg_mem.scale_q        = mem_words[20];
            dbg_mem.zero_point_q   = mem_words[21];
            dbg_mem.scale_k        = mem_words[22];
            dbg_mem.zero_point_k   = mem_words[23];
            dbg_mem.scale_v        = mem_words[24];
            dbg_mem.zero_point_v   = mem_words[25];

            dbg_mem.reserved_debug = mem_words[26];
        end
    endtask

    // DUT
    ControlMemInterface dut (
        .ap_start(ap_start),
        .ap_done(ap_done),
        .ap_idle(ap_idle),
        .ap_ready(ap_ready),
        .mem_i(mem_i),
        .mem_o(mem_o),
        .mem_o_ap_vld(mem_o_ap_vld),
        .address(address),
        .data_in(data_in),
        .data_out(data_out),
        .data_out_ap_vld(data_out_ap_vld),
        .read_control(read_control),
        .write_control(write_control),
        .chip_enable(chip_enable),
        .reset_n(reset_n),
        .ap_rst(ap_rst)
    );

    // Simple write: updates local memory mirror using mem_o when valid.
    task automatic do_write(input int unsigned byte_addr, input logic [31:0] value);
        begin
            address       = byte_addr;
            data_in       = value;
            read_control  = 1'b0;
            write_control = 1'b1;
            #1;
            if (!mem_o_ap_vld) begin
                $fatal(1, "Write addr %0d did not assert mem_o_ap_vld", byte_addr);
            end
            unpack_words(mem_o);
            mem_i = pack_words();
            if (mem_words[byte_addr/4] !== value) begin
                $fatal(1, "Write addr %0d expected %h, got %h", byte_addr, value, mem_words[byte_addr/4]);
            end
            write_control = 1'b0;
            data_in       = '0;
            #1;
        end
    endtask

    // Simple read: checks data_out/data_out_ap_vld.
    task automatic do_read(input int unsigned byte_addr, input logic [31:0] exp);
        begin
            address       = byte_addr;
            read_control  = 1'b1;
            write_control = 1'b0;
            #1;
            if (!data_out_ap_vld) begin
                $fatal(1, "Read addr %0d did not assert data_out_ap_vld", byte_addr);
            end
            if (data_out !== exp) begin
                $fatal(1, "Read addr %0d expected %h, got %h", byte_addr, exp, data_out);
            end
            read_control = 1'b0;
            #1;
        end
    endtask

    initial begin
        ap_rst       = 1'b0;
        ap_start     = 1'b0;
        chip_enable  = 1'b0;
        read_control = 1'b0;
        write_control= 1'b0;
        reset_n      = 1'b0;
        address      = '0;
        data_in      = '0;
        for (int i = 0; i < 27; i++) mem_words[i] = '0;
        mem_i = pack_words();

        // Apply reset (active low) then enable the block.
        #2;
        reset_n     = 1'b1;
        chip_enable = 1'b1;
        ap_start    = 1'b1;
        #1;

        // Basic write/readback checks across a couple of addresses.
        do_write(0, 32'h1111_1111);
        do_write(4, 32'h2222_2222);
        do_write(8, 32'h3333_3333);

        do_read(0, 32'h1111_1111);
        do_read(4, 32'h2222_2222);
        do_read(8, 32'h3333_3333);

        $display("ControlMemInterface_tb (SV) : all checks passed");
        $finish;
    end
endmodule

`default_nettype wire
