`timescale 1ns/100ps

module RAM_BLOCK (
		adr_i,
		clk_i,
		we_i,
		data_i,
		data_o,
		mem_addr_in_use,
		mem_addr_in_use_value
	//	reset
);
   // input reset;
	input [31:0] adr_i;
	input [31:0] data_i;
	output reg [31:0] data_o;
	input clk_i;
	input we_i;
	output reg [31:0] mem_addr_in_use;
	output reg [31:0] mem_addr_in_use_value;
//	output reg [31:0] memory [65535:0];
  
	//reg [31:0] memory[2**31:0];
	
	reg [31:0] memory[0:63];
	integer i;
	
	
	//assign data_o = memory[adr_i];
	always @ (posedge clk_i)
	begin
	   mem_addr_in_use <= adr_i;
	   mem_addr_in_use_value <= memory[adr_i];
	  
		if (we_i==1'b1)
		begin
			memory[adr_i] <= data_i;     // ?????????
			data_o <= memory[adr_i];
		end
	end
/*	always @(posedge reset)
	begin               
                  for (i=0; i<65535; i=i+1) memory[i] <= 32'b00000000000000000000000000000000;
    end */
    
endmodule