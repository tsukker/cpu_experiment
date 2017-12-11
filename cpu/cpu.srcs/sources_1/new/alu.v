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
    output [31:0] result
    );
    reg [31:0] res;

    case (op)
        5'd0: res = inLeft + inRight;
        5'd2: res = inLeft - inRight;
        5'd8: res = inLeft & inRight;
        5'd9: res = inLeft | inRight;
        5'd10: res = inLeft ^ inRight;
        5'd11: res = ~(inLeft | inRight);
        5'd16: res = inLeft << shift;
        5'd17: res = inLeft >> shift;
        5'd18: res = inLeft >>> shift;
        default: res = 32'hffffffff;
    endcase

    assign result = res;

endmodule
