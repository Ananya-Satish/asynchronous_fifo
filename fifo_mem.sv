`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2026 13:51:29
// Design Name: 
// Module Name: fifo_mem
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


module fifo_mem #(parameter DEPTH = 8, WIDTH = 8, ptr_size = 4)
(   input logic wr_clk, wr_en,full,
    input logic [WIDTH-1:0] data_in,
    input logic [ptr_size-1:0] b_wptr,b_rptr,
    output logic [WIDTH-1:0] data_out );

logic [WIDTH-1:0] mem [0:DEPTH-1];

// Write
always_ff @(posedge wr_clk)
begin
    if (wr_en && !full)
        mem[b_wptr[ptr_size-2:0]] <= data_in;
end

// Read (asynchronous)
assign data_out = mem[b_rptr[ptr_size-2:0]];

endmodule