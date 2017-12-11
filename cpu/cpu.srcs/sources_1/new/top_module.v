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
    wire [31:0] wr;
    wire [31:0] alu_result;
    wire [31:0] npc;
    wire [31:0] pc;

    wire [31:0] imm;
    wire [25:0] addr;
    wire [31:0] inLeft;
    wire [31:0] inRight;
    wire wren;

    pc pc0 (
        .clk(sysclk),
        .npc(npc),
        .pc(pc)
    );

    instruction_memory icache0 (
        .clk(sysclk),
        .r_addr(pc[7:0]),
        .r_data(ins)
    );

    decoder decoder0 (
        .instruction(ins),
        .op(op),
        .opr_alu(opr_alu),
        .shift(shift),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .imm(imm),
        .addr(addr)
    );

    reg_file reg_file0 (
        .clk(sysclk),
        .wr(wr),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wren(wren),
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
        .addr(addr),
        .alu_result(alu_result),
        .wr(wr),
        .npc(npc)
    );

    data_memory dcache0 (

    );

endmodule
