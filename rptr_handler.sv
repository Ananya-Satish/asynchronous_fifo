`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 21:51:42
// Design Name: 
// Module Name: rptr_handler
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


module rptr_handler #(parameter ptr_size=4)(rd_clk,reset,rd_en,g_wptr_sync,b_rptr,g_rptr,empty);
input logic rd_clk, reset,rd_en;
input logic [ptr_size-1:0]g_wptr_sync;
output logic [ptr_size-1:0]b_rptr,g_rptr;
output logic empty;

logic [ptr_size-1:0]b_rptr_next;
logic [ptr_size-1:0]g_rptr_next;
logic empty_next;

assign b_rptr_next = (rd_en && (!empty)) ? b_rptr + 1'b1 : b_rptr;
bcgc #(ptr_size) I1(.B(b_rptr_next),
                    .G(g_rptr_next));
assign empty_next = (g_rptr_next == g_wptr_sync);

always_ff@(posedge rd_clk, negedge reset)
begin 
    if(!reset)
    begin
        b_rptr <= '0;
        g_rptr <= '0;
        empty <= 1'b1;
    end
    
    else 
    begin
        b_rptr <= b_rptr_next;
        g_rptr <= g_rptr_next;
        empty <= empty_next;
    end
    
end
endmodule
