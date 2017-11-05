`timescale 1ns/100ps

 module memaccess(inst_in4,readmemdata,alu_in4,bin4,clock4,reset4,inst_out4,alu_out4,loadmemdata_out,memaddress);
 
 input [31:0] inst_in4;
 input [31:0] alu_in4;
 input [31:0] bin4;
 input [31:0] readmemdata;
 
 input clock4;
 input reset4; 
 
 output [31:0] alu_out4;
 output [31:0] loadmemdata_out;
 output [31:0] memaddress;
 output [31:0] inst_out4;

  
 reg [31:0] alu_out4;
 reg [31:0] loadmemdata_out;
 reg [31:0] inst_out4;
  
 wire [31:0] memaddress;
 wire [5:0]  opcode;
 
//---------------------------------operation code-------------------------------------	
 parameter	
						LW		  =6'b000101,
						SW		  =6'b001010;
						
 assign opcode = inst_in4[31:26];
 assign memaddress = alu_in4;		    // mem address 	

 always@(posedge clock4 or negedge reset4)
   begin
     if(~reset4)
     	 begin
     	   alu_out4 <= 0; 
     	   loadmemdata_out  <= 0;   
     	   inst_out4  	 <= 0;      	   	   
     	 end     	                 
     else
     	begin
     	  inst_out4 <= inst_in4;               // IR4->IR5   
     	  alu_out4 <= alu_in4;  	     
//---------------------------------------LW-------------------------------------
     		if(opcode==LW)  // read a word from the mem 
   			  begin   			  	
   			  	alu_out4<=readmemdata;    			  	  	  
   			  end    			  		  
//----------------------------------SW------------------------------------
     		else if((opcode==SW))          // write data to mem 
   			  begin   			  	
   			  	alu_out4<=bin4;                                 // enable to write mem    			  	  	  
   			  end    	  
		   		
     	end       
   end 
    
 endmodule