`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2016/09/13 17:14:20
// Design Name:
// Module Name: testbench
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
module testbench();
    reg clk; // input が reg
    wire [31:0] pc_watch;
    wire [5:0] op_watch;
    wire [5:0] opr_alu_watch;
    wire [31:0] inLeft_watch;
    wire [31:0] inRight_watch;
    wire [31:0] alu_result_watch;
    wire [4:0] ra1_watch;
    wire [4:0] ra2_watch;
    wire [31:0] rf8_debug_watch;

    top_module T0( // simulation したいやつを instance 化
        .sysclk(clk),
        .pc_watch(pc_watch),
        .op_watch(op_watch),
        .opr_alu_watch(opr_alu_watch),
        .ra1_watch(ra1_watch),
        .ra2_watch(ra2_watch),
        .inLeft_watch(inLeft_watch),
        .inRight_watch(inRight_watch),
        .alu_result_watch(alu_result_watch),
        .rf8_debug_watch(rf8_debug_watch)
    );

    initial begin
        clk <= 1'b0;
    end

    always #1 begin
        clk = ~clk;
    end


    task wait_posedge_clk;
        input   n;
        integer n;

        begin
            for(n=n; n>0; n=n-1) begin
                @(posedge clk)
                    ;
            end
        end
    endtask

endmodule
