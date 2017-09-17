`timescale 1ns/100ps

 module writeback(alu_in5,inst_in5,clock5,reset5,loadmemdata_in,
                  reg_add_out,reg_data_out,reg_write_en);
 
 input [31:0] inst_in5;
 input [31:0] alu_in5;
 input [31:0] loadmemdata_in;
 
 input clock5;
 input reset5;

 output [4:0] reg_add_out;
 output [31:0] reg_data_out;
 output reg_write_en;
 
 reg [31:0] memout;
 reg [31:0] aluout;
 reg [31:0] ir5out;
  
 wire [4:0] reg_add_out;
 wire [5:0] opcode;
 wire [31:0] reg_data_out;
 wire reg_data_choose;
 wire reg_write_en;

 parameter  LB		  =6'b000001,
            LW		  =6'b000101,
            ADDI		=6'b010000,
            SNEI		=6'b011111,
            R_TYPE  =6'b110000;
 
 assign opcode[5:0] = ir5out[31:26];
 
 assign reg_add_out = (opcode==R_TYPE) ? ir5out[15:11] : (((opcode>=LB)&(opcode<=SNEI)) ? ir5out[20:16] : 5'b00000); 
							
 assign reg_data_out = reg_data_choose ? aluout :((~reg_data_choose) ? memout : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz );		
    
 assign reg_data_choose = ((opcode==R_TYPE)|((opcode>=ADDI)&(opcode<=SNEI))) ? 1 :(((opcode>=LB)&(opcode<=LW)) ? 0 : 1'bz);
 
 assign reg_write_en = ((reg_add_out != 0)&((opcode==R_TYPE)|((opcode>=ADDI)&(opcode<=SNEI))|((opcode>=LB)&(opcode<=LW)))) ? 1 : 0;
 
  
 always@(posedge clock5 or negedge reset5)
   begin
     if(~reset5)
     	 begin
     	   memout <= 0; 
     	   aluout <= 0;   
     	   ir5out <= 0;      	   
     	 end     	                 
     else
     	begin
     	  ir5out <= inst_in5;               // IR5->IR6   
     	  memout <= loadmemdata_in;  
     	  aluout <=	alu_in5;     
      end
   end 
    
 endmodule