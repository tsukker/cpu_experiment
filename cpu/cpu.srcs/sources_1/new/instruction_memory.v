`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/11/30 16:25:55
// Design Name:
// Module Name: instruction_memory
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


module instruction_memory(clk, r_addr, r_data);
     input clk;
     input  [4:0] r_addr;

     output [31:0] r_data;
     reg [4:0] addr_reg;
     reg [31:0] mem [0:31];
     always @(posedge clk) begin
         // 読み出し専用
         addr_reg <= r_addr;           //読み出しアドレスを同期
     end
     assign r_data = mem[addr_reg];
endmodule
