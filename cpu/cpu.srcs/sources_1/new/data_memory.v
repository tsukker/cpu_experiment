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
     input  [31:0] r_addr, w_addr;
     input  [31:0] w_data;
     output [31:0] r_data;

     reg [31:0] addr_reg;
     reg [31:0] mem [0:1023];

     reg [7:0] clk_counter;
     integer i;

     initial begin
         for (i=0;i<1024;i=i+1) begin
             mem[i] = 32'b0;
         end
         clk_counter = 8'd0;
     end

     always @(posedge clk) begin
         if (clk_counter == 8'd6) begin
             if (we) begin
                 mem[w_addr] <= w_data; //書き込みのタイミングを同期
                 if (w_addr == 31'd516) begin
                     //$stop;
                 end
                 //$stop;
             end
             addr_reg <= r_addr;           //読み出しアドレスを同期

         end

         clk_counter = clk_counter + 8'd1;

         if (clk_counter == 8'd10) begin
             clk_counter <= 8'd0;
         end
     end
     assign r_data = mem[addr_reg];
endmodule
