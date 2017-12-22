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
    wire [32:0] pc_watch_wire;

    top_module T0( // simulation したいやつを instance 化
        .sysclk(clk),
        .pc_watch_wire(pc_watch_wire)
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
