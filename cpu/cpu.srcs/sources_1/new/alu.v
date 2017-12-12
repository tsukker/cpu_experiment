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
    input clk,
    input [31:0] inLeft,
    input [31:0] inRight,
    input [5:0] opr,
    input [4:0] shift,
    output [31:0] result
    );
    reg [31:0] res;

    reg [7:0] clk_counter;

    initial begin
        clk_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (clk_counter == 8'd4) begin
            case (opr)
                6'd0: begin
                    res = inLeft + inRight;
                    //$stop;
                end
                6'd2: res = inLeft - inRight;
                6'd8: res = inLeft & inRight;
                6'd9: res = inLeft | inRight;
                6'd10: begin
                    res = inLeft ^ inRight;
                    //$stop;
                end
                6'd11: res = ~(inLeft | inRight);
                6'd16: res = inLeft << shift;
                6'd17: res = inLeft >> shift;
                6'd18: res = inLeft >>> shift;
                default: $stop;
            endcase
        end

        clk_counter = clk_counter + 8'd1;

        if (clk_counter == 8'd8) begin
            clk_counter <= 8'd0;
        end
    end

    assign result = res;

endmodule
