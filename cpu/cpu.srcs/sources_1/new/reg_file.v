`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/30 05:13:30
// Design Name: 
// Module Name: reg_file
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


module reg_file(
    input clk,
    input rstd,
    input [31:0] wr,
    input [4:0] ra1,
    input [4:0] ra2,
    input [4:0] wa,
    input wren,
    output [31:0] rr1,
    output [31:0] rr2
    );
    reg [31:0] rf [0:31];
    
    assign rr1 = rf [ra1];
    assign rr2 = rf [ra2];
    always @ (negedge rstd or posedge clk)
        if (rstd == 0) rf [0] <= 32'h00000000;
        else if (wren == 0) rf [wa] <= wr;
endmodule
