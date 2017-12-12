`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/12/11 23:10:09
// Design Name:
// Module Name: executor
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


module executor(
        input clk,
        input [31:0] pc,
        input [5:0] op,
        input [25:0] addr,
        input [31:0] alu_result,
        output [31:0] wr,
        output [31:0] npc
    );

    reg [31:0] non_branch;
    reg [31:0] npc_reg;

    reg [7:0] clk_counter;

    initial begin
        npc_reg = 32'd0;
        clk_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (clk_counter == 8'd5) begin
            npc_reg <= pc + 32'd1;
            //$stop;
        end

        clk_counter = clk_counter + 8'd1;

        if (clk_counter == 8'd8) begin
            clk_counter <= 8'd0;
        end
    end

    assign wr = alu_result;
    assign npc = npc_reg;

endmodule
