`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/11/30 16:32:20
// Design Name:
// Module Name: decoder
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


module decoder(
        input clk,
        input [31:0] instruction,
        output [5:0] op,
        output [5:0] opr_alu,
        output [4:0] shift,
        output [4:0] ra1,
        output [4:0] ra2,
        output [4:0] wa,
        output wa_flag,
        output [31:0] imm,
        output [25:0] addr
    );

    reg [5:0] op_reg;
    reg [5:0] opr_alu_reg;
    reg [5:0] func_reg;

    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [4:0] wa_reg;
    reg wa_flag_reg;
    //reg [5:0] func,

    reg [15:0] imm_reg;

    reg [7:0] clk_counter;

    initial begin
        op_reg = 6'd0;
        opr_alu_reg = 6'd0;
        func_reg = 6'd0;
        rs = 5'd0;
        rt = 5'd0;
        rd = 5'd0;
        wa_reg = 5'd0;
        wa_flag_reg = 1'd0;
        imm_reg = 16'd0;
        clk_counter = 8'd0;
    end

    always @(posedge clk) begin
        if (clk_counter == 8'd2) begin
            rs = instruction[25:21];
            rt = instruction[20:16];
            rd = instruction[15:11];

            op_reg = instruction[31:26];
            func_reg = instruction[5:0];
            case (op_reg)
                6'd0: opr_alu_reg = func_reg;
                6'd1: opr_alu_reg = 6'd0;
                6'd4: opr_alu_reg = 6'd8;
                6'd5: opr_alu_reg = 6'd9;
                6'd6: opr_alu_reg = 6'd10;
                default: opr_alu_reg = 6'd63;
            endcase

            imm_reg <= instruction[15:0];

            case (op_reg)
                6'd0: begin
                    wa_reg = rd;
                    wa_flag_reg = 1'd0;
                end
                6'd1, 6'd3, 6'd4, 6'd5, 6'd6, 6'd16: begin
                    wa_reg = rt;
                    wa_flag_reg = 1'd0;
                end
                6'd41: begin
                    wa_reg = 5'd31;
                    wa_flag_reg = 1'd0;
                end
                default: begin
                    wa_reg = 5'd0;
                    wa_flag_reg = 1'd1;
                end
            endcase
            if (op_reg == 6'd0) begin
                wa_reg <= rd;
            end
            else begin
                wa_reg <= rt;
            end
            // TODO
        end

        clk_counter = clk_counter + 8'd1;

        if (clk_counter == 8'd10) begin
            clk_counter <= 8'd0;
        end
    end

    assign op = op_reg;
    assign opr_alu = opr_alu_reg;
    assign shift = instruction[10:6];
    assign ra1 = rs;
    assign ra2 = rt;
    assign wa = wa_reg;
    assign wa_flag = wa_flag_reg;

    assign imm = {{16{imm_reg[15]}}, imm_reg[15:0]};
    assign addr = instruction[25:0];
endmodule
