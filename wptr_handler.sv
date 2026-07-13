`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 17:54:44
// Design Name: 
// Module Name: wptr_handler
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


module wptr_handler #(parameter ptr_size=4)(wr_clk,reset,wr_en,g_rptr_sync,b_wptr,g_wptr,full);
input logic wr_clk, reset, wr_en;
input logic [ptr_size-1:0]g_rptr_sync;
output logic [ptr_size-1:0]b_wptr,g_wptr;
output logic full;

logic [ptr_size-1:0]b_wptr_next;
logic [ptr_size-1:0]g_wptr_next;
logic full_next;

assign b_wptr_next = (wr_en && (!full)) ? b_wptr + 1'b1 : b_wptr;
bcgc #(ptr_size) I1 (.B(b_wptr_next),
                 .G(g_wptr_next));
assign full_next=(g_wptr_next == {~g_rptr_sync[ptr_size-1:ptr_size-2],g_rptr_sync[ptr_size-3:0]});

always_ff@(posedge wr_clk, negedge reset)
begin
    if(!reset)
    begin
        b_wptr <= '0;
        g_wptr <= '0;
        full <= 1'b0;
    end
        
    else 
    begin
        b_wptr <= b_wptr_next;
        g_wptr <= g_wptr_next;
        full <= full_next;
    end
end

endmodule


