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
     input [7:0] r_addr;

     output [31:0] r_data;
     reg [7:0] addr_reg;
     reg [31:0] mem [0:31];

     reg [7:0] clk_counter;

     initial begin
         $readmemb("C:/workspace/56_6/samples/sample1.bin", mem);
         addr_reg = 8'b0;
         clk_counter = 8'd0;
     end

     always @(posedge clk) begin
         if (clk_counter == 8'd1) begin
             // 読み出し専用
             addr_reg <= r_addr;           //読み出しアドレスを同��?
         end

         clk_counter = clk_counter + 8'd1;

         if (clk_counter == 8'd8) begin
             clk_counter <= 8'd0;
         end
     end
     assign r_data = mem[addr_reg];
endmodule
