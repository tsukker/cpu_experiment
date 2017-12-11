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
    sysclk
    );

    input sysclk;
    wire ins;
    wire op;
    wire rs;
    wire rt;
    wire rd;
    wire aux;



    decoder decoder0 (
        .instruction(ins),
        .op(op),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .aux(aux)
    );

    alu alu0 (
        .inLeft(inLeft),
        .inRight(inRight),
        .op(op),
        .aux(aux),
        .result(result)
    );

    reg_file reg_file0 (
        .clk(sysclk),
        .wr(result),
        .ra1(rs),
        .ra2(rt),
        .wa(rd),
        .wren(wren),
        .rr1(inLeft),
        .rr2(inRight)
    );

    instruction_memory icache0 (
    );

    data_memory dcache0 (

    );

endmodule
