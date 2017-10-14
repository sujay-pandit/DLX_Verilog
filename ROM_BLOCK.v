`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2017 01:20:37
// Design Name: 
// Module Name: ROM_BLOCK
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


module ROM_BLOCK(data_i,data_o,clk_i);
input [31:0] data_i;
output reg [31:0] data_o;
input clk_i;

    integer i;       
    reg [31:0] inst_memory [0:63];
     initial
      begin   
      
       $readmemb("testp.txt",inst_memory);
        $display("data:");           
        for (i=0; i <20; i=i+1)         
         $display("%d:%b",i,inst_memory[i]); 
         end 
         always@(data_i)
         begin
            data_o<=inst_memory[data_i];
         end
endmodule