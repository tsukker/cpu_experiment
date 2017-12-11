`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/12/11 16:02:24
// Design Name:
// Module Name: pc
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


module pc(
        input clk,
        input [31:0] npc,
        output [31:0] pc
    );

    reg [31:0] pc_reg;
    reg [31:0] current_pc;

    reg [7:0] clk_counter;

    initial begin
        pc_reg = 32'd0;
        clk_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (clk_counter == 8'd0) begin
            pc_reg <= npc;
        end

        clk_counter <= clk_counter + 8'd1;

        if (clk_counter == 8'd8) begin
            clk_counter <= 8'd0;
        end
    end

    assign pc = pc_reg;

endmodule
