 
//`include "instfetch.v" 
//`include "instdecode.v" 
//`include "instexec.v" 
//`include "memaccess.v" 
//`include "writeback.v" 
 
`timescale 1ns/100ps 
 
 module dlxpipeline(clock,reset,pc,inst_in,memdata_in,memdata_out,mem_addr,mem_wr_en,regs1,regs2,regs3,regs4,regs5,regs6,regs7,regs8,regs9,regs10
                   ,regs11,regs12,regs13,regs14,regs15,regs16,regs17,regs18,regs19,regs20,regs21,regs22,regs23,regs24,regs25,
                   regs26,regs27,regs28,regs29,regs30,regs31,branch_en,alu_branch,alu_out34); 
  
 input [31:0] inst_in; 
 input [31:0] memdata_in; 
 
 input clock; 
 input reset; 
  
 output [31:0] pc; 
 output [31:0] mem_addr; 
 output [31:0] memdata_out; 
 output mem_wr_en; 
  output  [31:0]regs1;
  output [31:0]regs2;
  output  [31:0]regs3;
  output  [31:0]regs4;
  output  [31:0]regs5;
  output  [31:0]regs6;
  output  [31:0]regs7;
  output  [31:0]regs8;
  output  [31:0]regs9;
  output [31:0]regs10;
  output [31:0]regs11;
   output  [31:0]regs12;
   output  [31:0]regs13;
   output  [31:0]regs14;
   output  [31:0]regs15;
   output  [31:0]regs16;
   output  [31:0]regs17;
   output  [31:0]regs18;
   output  [31:0]regs19;
   output  [31:0]regs20;
   output  [31:0]regs21;
    output  [31:0]regs22;
    output  [31:0]regs23;
    output  [31:0]regs24;
    output  [31:0]regs25;
    output  [31:0]regs26;
    output  [31:0]regs27;
    output  [31:0]regs28;
    output  [31:0]regs29;
    output  [31:0]regs30;
    output  [31:0]regs31;
    output branch_en;
    output [31:0] alu_branch;
   output [31:0] alu_out34;
  
 wire branch_en,reg_write_en,mem_wr_en; 
 wire [4:0]   reg_add; 
 wire [31:0]  pcout,ir12,npc12,ir23,npc23,ir34,ir45,mem_addr,memdata_out,loadmemdata; 
 wire [31:0]  alu_branch,reg_data,a23,b23,b34,im23,alu_out34,alu_out45; 
  
  assign pc = npc12;  // PC output     
   
  assign memdata_out = b34; 
  assign mem_addr= alu_out34;   
  
	instfetch instfetch(.clock1(clock),.alu_branch_in(alu_branch),.reset1(reset), 
	 
	                    .branch_en(branch_en),.inst_in1(inst_in),.irout1(ir12),.npcout1(npc12)); 
	 
	 
	 
	instdecode instdecode(.npc_in2(npc12),.inst_in2(ir12),.clock2(clock),.reg_add_in(reg_add),.reg_data_in(reg_data),.reset2(reset),.reg_write_en(reg_write_en),.irout2(ir23),.aout2(a23),.bout2(b23),.imout2(im23),.npcout2(npc23),.regs1(regs1),.regs2(regs2),.regs3(regs3),.regs4(regs4),.regs5(regs5),.regs6(regs6),.regs7(regs7),.regs8(regs8),.regs9(regs9),.regs10(regs10),.regs11(regs11),.regs12(regs12),.regs13(regs13),.regs14(regs14),.regs15(regs15),.regs16(regs16),.regs17(regs17),.regs18(regs18),.regs19(regs19),.regs20(regs20),.regs21(regs21),.regs22(regs22),.regs23(regs23),.regs24(regs24),.regs25(regs25),.regs26(regs26),.regs27(regs27),.regs28(regs28),.regs29(regs29),.regs30(regs30),.regs31(regs31)); 
                         
	                       
	instexec instexec(.ain3(a23),.bin3(b23),.imin3(im23),.inst_in3(ir23),.npcout3(npc23),.clock3(clock),.reset3(reset),.alu_out3(alu_out34), 
	 
	                  .bout3(b34),.inst_out3(ir34),.alu_branch_out(alu_branch),.branch_en(branch_en),.mem_wr_en(mem_wr_en)); 
	                   
	                   
	memaccess memaccess(.inst_in4(ir34),.readmemdata(memdata_in),.alu_in4(alu_out34),.bin4(b34),.clock4(clock),.reset4(reset), 
	 
	                    .inst_out4(ir45),.alu_out4(alu_out45),.loadmemdata_out(loadmemdata),.memaddress(mem_addr));   
	                     
	                     
	writeback  writeback(.alu_in5(alu_out45),.inst_in5(ir45),.clock5(clock),.reset5(reset),.loadmemdata_in(loadmemdata), 
	 
                       .reg_add_out(reg_add),.reg_data_out(reg_data),.reg_write_en(reg_write_en));      
                            
                      
  endmodule