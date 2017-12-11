`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/11/30 16:06:49
// Design Name:
// Module Name: alu
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


module alu(
    input [31:0] inLeft,
    input [31:0] inRight,
    input [5:0] op,
    input [10:0] aux,
    output [31:0] result
    );

    assign result = inLeft + inRight;

endmodule
