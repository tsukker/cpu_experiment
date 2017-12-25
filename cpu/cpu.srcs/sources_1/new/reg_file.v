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
    input wa_flag,
    input [5:0] op,
    input [31:0] imm,
    input [31:0] imm_0,
    output [31:0] rr1,
    output [31:0] rr2,
    output [31:0] rf8_debug
    );
    reg [31:0] rf [0:31];
    reg [31:0] rr1_reg;
    reg [31:0] rr2_reg;

    integer i;
    reg [3:0] clk_counter;

    initial begin
        for (i=0;i<32;i=i+1) begin
            rf[i] = 32'b0;
        end
        rr2_reg = 32'b0;
        clk_counter = 4'd0;
    end

    always @ (negedge rstd or posedge clk) begin
        if (clk_counter == 4'd2) begin
            rr1_reg = rf[ra1];
            case (op)
                6'd1: begin
                    rr2_reg <= imm;
                end
                6'd4, 6'd5, 6'd6: begin
                    rr2_reg <= imm_0;
                end
                default: begin
                    rr2_reg <= rf [ra2];
                end
            endcase
        end

        if (clk_counter == 4'd7) begin
            if (rstd == 0) begin
                rf [0] <= 32'h00000000;
                //$stop;
            end
            else if (wa_flag == 1'd0) begin
                rf [wa] <= wr;
                //$stop;
            end
            //$stop;
        end

        clk_counter = clk_counter + 4'd1;

        if (clk_counter == 4'd8) begin
            clk_counter <= 4'd0;
        end
    end

    assign rr1 = rr1_reg;
    assign rr2 = rr2_reg;

    assign rf8_debug = rf[8];

endmodule
