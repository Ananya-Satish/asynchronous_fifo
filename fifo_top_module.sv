`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 22:39:35
// Design Name: 
// Module Name: fifo_top_module
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


module fifo_top_module #(parameter DEPTH = 8, WIDTH = 8, ptr_size = 4)
(   input  logic wr_clk, rd_clk,
    input  logic reset,
    input  logic wr_en, rd_en,
    input  logic [WIDTH-1:0] data_in,
    output logic [WIDTH-1:0] data_out,
    output logic full, empty  );

//Pointer signals 
logic [ptr_size-1:0] b_wptr, g_wptr;
logic [ptr_size-1:0] b_rptr, g_rptr;

logic [ptr_size-1:0] g_wptr_sync;
logic [ptr_size-1:0] g_rptr_sync;

//Write Pointer handlers
wptr_handler #(ptr_size) I1 (.wr_clk(wr_clk),
                             .reset(reset),
                             .wr_en(wr_en),
                             .g_rptr_sync(g_rptr_sync),
                             .b_wptr(b_wptr),
                             .g_wptr(g_wptr),
                             .full(full)  );

//Read Pointer Handlers 
rptr_handler #(ptr_size) I2 ( .rd_clk(rd_clk),
                              .reset(reset),
                              .rd_en(rd_en),
                              .g_wptr_sync(g_wptr_sync),
                              .b_rptr(b_rptr),
                              .g_rptr(g_rptr),
                              .empty(empty)  );

//Write Pointer Synchronizer
ff_synch #(ptr_size) I3 ( .d(g_wptr),
                          .clk(rd_clk),
                          .reset(reset),
                          .q(g_wptr_sync) );

//Read Pointer Synchronizer
ff_synch #(ptr_size) I4 ( .d(g_rptr),
                          .clk(wr_clk),
                          .reset(reset),
                          .q(g_rptr_sync) );

//FIFO Memory
fifo_mem #( .DEPTH(DEPTH),
            .WIDTH(WIDTH),
            .ptr_size(ptr_size)) 
            
mem_inst ( .wr_clk(wr_clk),
           .wr_en(wr_en),
           .full(full),
           .data_in(data_in),
           .b_wptr(b_wptr),
           .b_rptr(b_rptr),
           .data_out(data_out) );

endmodule