`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2017/11/30 16:25:55
// Design Name:
// Module Name: data_memory
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


module data_memory(clk, we, r_addr, r_data, w_addr, w_data);
     input clk, we;
     input  [4:0] r_addr, w_addr;
     input  [31:0] w_data;
     output [31:0] r_data;
     reg [4:0] addr_reg;
     reg [31:0] mem [0:31];
     always @(posedge clk) begin
         if(we) mem[w_addr] <= w_data; //書き込みのタイミングを同期
         addr_reg <= r_addr;           //読み出しアドレスを同期
     end
     assign r_data = mem[addr_reg];
endmodule
