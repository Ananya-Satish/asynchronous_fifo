`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 15:49:37
// Design Name: 
// Module Name: ff_synch
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


module ff_synch #(parameter size=4)(d,clk,reset,q);
input logic [size-1:0]d;
input logic clk,reset;
output logic [size-1:0]q;
logic [size-1:0]n;

always_ff@(posedge clk, negedge reset)
begin
    if(!reset)
    begin
        n<= '0;
        q<= '0;
    end
    
    else
    
    begin
        n<=d;
        q<=n;
    end
    
end
endmodule
