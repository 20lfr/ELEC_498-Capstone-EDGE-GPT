`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2025 12:53:42 PM
// Design Name: 
// Module Name: axi_stream_loopback
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module axi_stream_loopback #(
    parameter DATA_WIDTH = 32, 
    parameter SEND = 1'b0,
    parameter RECEIVE = 1'b1
) (
    input wire ACLK,
    input wire ARESETn,

    // axi slave stream interface
    input wire [DATA_WIDTH-1:0] S_AXIS_TDATA,
    input wire S_AXIS_TLAST,
    input wire S_AXIS_TVALID,
    output reg S_AXIS_TREADY,

    // axi master stream interface
    output reg [DATA_WIDTH-1:0] M_AXIS_TDATA,
    output reg M_AXIS_TLAST,
    output reg M_AXIS_TVALID,
    input wire M_AXIS_TREADY
);

    reg [DATA_WIDTH-1:0]  data_reg;
    reg                   last_reg;
    reg                   data_valid_reg;

    reg state = RECEIVE;

    // fsm logic here
    always @(posedge ACLK) begin
      if(!ARESETn) begin
        data_reg <= 0;
        data_valid_reg <= 0;
        M_AXIS_TVALID <= 0;
        S_AXIS_TREADY <= 1;
        state <= RECEIVE;
      end
      else begin
        if(state == SEND) begin
          M_AXIS_TDATA <= data_reg;
          M_AXIS_TLAST <= last_reg;
          M_AXIS_TVALID <= 1;

          // If DMA accepts the data
          if (M_AXIS_TREADY) begin
            M_AXIS_TVALID <= 0;
            data_valid_reg <= 0;
            S_AXIS_TREADY <= 1;
            state <= RECEIVE;
          end
        end
        if(state == RECEIVE) begin
          S_AXIS_TREADY <= 1;
          
          // If we get valid data
          if(S_AXIS_TREADY & S_AXIS_TVALID) begin
            data_reg <= S_AXIS_TDATA;
            last_reg <= S_AXIS_TLAST;
            data_valid_reg <= 1;
            S_AXIS_TREADY <= 0; // stop accepting data till we send it
            state <= SEND;
          end
        end
      end
    end
  endmodule
