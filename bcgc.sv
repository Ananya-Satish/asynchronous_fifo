`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.07.2026 14:54:56
// Design Name: 
// Module Name: bcgc
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


module bcgc #(parameter size=4)(B,G);
input logic [size-1:0]B;
output logic [size-1:0]G;
assign G = B ^ (B >> 1);
endmodule
