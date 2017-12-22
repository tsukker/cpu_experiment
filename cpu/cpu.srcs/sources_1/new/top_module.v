`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/11/30 16:12:11
// Design Name:
// Module Name: top_module
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


module top_module(
        input sysclk
    );

    wire [31:0] ins;
    wire [5:0] op;
    wire [5:0] opr_alu;
    wire [4:0] shift;
    wire [4:0] ra1;
    wire [4:0] ra2;
    wire [4:0] wa;
    wire wa_flag;
    wire [31:0] wr;
    wire [31:0] alu_result;
    wire [31:0] npc;
    wire [31:0] pc;

    wire [31:0] imm;
    wire [25:0] addr;
    wire [31:0] inLeft;
    wire [31:0] inRight;

    wire [31:0] r_addr;
    wire [31:0] r_data;
    wire [31:0] w_addr;
    wire [31:0] w_data;
    wire w_enable;

    pc_handler pc_handler0 (
        .clk(sysclk),
        .npc(npc),
        .pc(pc)
    );

    instruction_memory icache0 (
        .clk(sysclk),
        .r_addr(pc[10:0]),
        .r_data(ins)
    );

    decoder decoder0 (
        .clk(sysclk),
        .instruction(ins),
        .op(op),
        .opr_alu(opr_alu),
        .shift(shift),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wa_flag(wa_flag),
        .imm(imm),
        .addr(addr)
    );

    reg_file reg_file0 (
        .clk(sysclk),
        .wr(wr),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wa_flag(wa_flag),
        .op(op),
        .imm(imm),
        .rr1(inLeft),
        .rr2(inRight)
    );

    alu alu0 (
        .clk(sysclk),
        .inLeft(inLeft),
        .inRight(inRight),
        .opr(opr_alu),
        .shift(shift),
        .result(alu_result)
    );

    executor executor0 (
        .clk(sysclk),
        .pc(pc),
        .op(op),
        .rs(inLeft),
        .rt(inRight),
        .imm(imm),
        .addr(addr),
        .alu_result(alu_result),
        .r_data(r_data),
        .wr(wr),
        .npc(npc),
        .r_addr(r_addr),
        .w_addr(w_addr),
        .w_data(w_data),
        .w_enable(w_enable)
    );

    data_memory dcache0 (
        .clk(sysclk),
        .we(w_enable),
        .r_addr(r_addr),
        .r_data(r_data),
        .w_addr(w_addr),
        .w_data(w_data)
    );

endmodule
