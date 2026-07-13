
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 23:54:36
// Design Name: 
// Module Name: fifo_top_module_tb
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


`timescale 1ns/1ps

module fifo_top_module_tb;

parameter DEPTH = 8;
parameter WIDTH = 8;
parameter ptr_size = 4;

logic wr_clk;
logic rd_clk;
logic reset;
logic wr_en;
logic rd_en;
logic [WIDTH-1:0] data_in;
logic [WIDTH-1:0] data_out;
logic full;
logic empty;

// DUT
fifo_top_module #(
    .DEPTH(DEPTH),
    .WIDTH(WIDTH),
    .ptr_size(ptr_size)
) DUT (
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// Write clock
initial wr_clk = 0;
always #5 wr_clk = ~wr_clk;

// Read clock
initial rd_clk = 0;
always #8 rd_clk = ~rd_clk;

initial
begin

    reset = 0;
    wr_en = 0;
    rd_en = 0;
    data_in = 0;

    //--------------------------
    // Reset
    //--------------------------
    #20;
    reset = 1;

    //--------------------------
    // Write one value
    //--------------------------
    @(posedge wr_clk);
    wr_en = 1;
    data_in = 8'd55;

    @(posedge wr_clk);
    wr_en = 0;

    //--------------------------
    // Wait for synchronizer
    //--------------------------
    repeat(4) @(posedge rd_clk);

    //--------------------------
    // Read one value
    //--------------------------
    @(posedge rd_clk);
    rd_en = 1;

    #2;

    $display("--------------------------------");
    $display("Expected = 55");
    $display("Received = %0d", data_out);
    $display("FULL     = %0b", full);
    $display("EMPTY    = %0b", empty);
    $display("--------------------------------");

    @(posedge rd_clk);
    rd_en = 0;

    #50;
    $finish;

end

endmodule