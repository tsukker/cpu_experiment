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
        input [31:0] rs,
        input [31:0] rt,
        input [31:0] imm,
        input [25:0] addr,
        input [31:0] alu_result,
        input [31:0] r_data,
        output [31:0] wr,
        output [31:0] npc,
        output [31:0] r_addr,
        output [31:0] w_addr,
        output [31:0] w_data,
        output w_enable
    );

    reg [31:0] rs_reg;
    reg [31:0] wr_reg;
    reg [31:0] r_addr_reg;
    reg [31:0] w_addr_reg;
    reg [31:0] w_data_reg;
    reg w_enable_reg;

    reg [31:0] non_branch;
    reg [31:0] npc_reg;

    reg [7:0] clk_counter;

    initial begin
        wr_reg = 32'd0;
        npc_reg = 32'd0;
        clk_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (clk_counter == 8'd5) begin
            rs_reg = rs;
            case (op)
                6'd0, 6'd1, 6'd4, 6'd5, 6'd6: begin
                    wr_reg = alu_result;
                end
                6'd3: begin
                    wr_reg = (imm << 6'd16);
                end
                6'd16: begin
                    r_addr_reg = rs_reg + imm;
                    w_enable_reg = 1'b0;
                    //$stop;
                end
                6'd24: begin
                    w_addr_reg = rs_reg + imm;
                    w_data_reg = rt;
                    w_enable_reg = 1'b1;
                    //$stop;
                end
                default: begin
                    $stop;
                end
            endcase
            //$stop;
        end

        if (clk_counter == 8'd7) begin
            case (op)
                6'd16: begin
                    wr_reg = r_data;
                end
            endcase
            npc_reg = pc + 32'b1;

        end

        clk_counter = clk_counter + 8'd1;

        if (clk_counter == 8'd10) begin
            clk_counter <= 8'd0;
        end
    end

    assign wr = wr_reg;
    assign npc = npc_reg;

    assign r_addr = r_addr_reg;
    assign w_addr = w_addr_reg;
    assign w_data = w_data_reg;
    assign w_enable = w_enable_reg;
endmodule
