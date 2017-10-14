
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2017 11:12:54
// Design Name: 
// Module Name: instfetch
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


`timescale 1ns/100ps

 module instfetch(clock1,alu_branch_in,reset1,branch_en,jump_en,inst_in1,irout1,npcout1,fetchclock);

 input clock1;
 input reset1;
 input branch_en;
 input [31:0] alu_branch_in;
 input [31:0] inst_in1;
 output [31:0] irout1;
 output [31:0] npcout1;
 input jump_en;
 output fetchclock;
 reg [31:0] pc;
 reg [31:0] instmem;
 reg [31:0] instreg;
 wire [31:0] irout1;
 wire [31:0] npcout1;
 
 //wire [31:0] inp1;
 wire [31:0] outp;                                             
 reg [31:0] temp_pc;
 integer  inp1;  
// assign inp1 = pc + 32'b0000_0000_0000_0000_0000_0000_0000_0100;    //  a+b=s=inp1 ,b=4 (PC+4)
 
// assign outp = branch_en ? alu_branch_in : inp1;                             // mux2to1
 assign outp=alu_branch_in;
 assign irout1 = instreg;  // instruction output 
 integer counter;
 assign npcout1 = pc;       //  PC output
 reg fetchclock;
 always @ (posedge clock1)
 begin
        if(~reset1)
        begin
          counter <= 0;
          fetchclock<=1'b0;
          inp1=0;
        end
        else begin
          if(counter >=3)begin
                     counter <= 0;
                     fetchclock<=~fetchclock;
              end
              else begin
                     counter <= counter + 1;
              end
        end
  end

 always@(posedge fetchclock or negedge reset1)
   begin
    
     if(~reset1)
     	 begin
     	   instreg <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
     	   pc      <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; 
     	   inp1=1;    	       	   
     	 end     	                 
     else
     	begin
     		instreg <= inst_in1;
     		if (jump_en==1)
     		begin
     		 pc <= outp;
     		end
     		
     		else if (branch_en==1)
     		begin
     		     inp1 <= outp;
                pc<=inp1;
     		        
     		end
     		else 
     		begin     		     
     		     pc <= inp1;
     		     inp1=inp1+1;
     		end	
     	end       
   end 
 endmodule