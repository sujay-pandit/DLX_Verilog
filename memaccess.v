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
 wire [7:0]  readmemdata_8;
 wire [15:0] readmemdata_16;
 wire [5:0]  opcode;
 
//---------------------------------operation code-------------------------------------	
 parameter	LB		  =6'b000001,
						LBU		  =6'b000010,
						LH		  =6'b000011,
						LHU		  =6'b000100,
						LW		  =6'b000101,
						SB		  =6'b001000,
						SH		  =6'b001001,
						SW		  =6'b001010;
						
 assign opcode = inst_in4[31:26];
 assign memaddress = alu_in4;		    // mem address 
 
 //  	datafake is mem data in-and-out port
// assign datafake = memwriteenable ? bin4 : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;	

 //assign datafake = 32'b1111_1111_1111_1111_1111_1111_1111_1111;
 //assign readmemdata = datafake;		
 
 assign readmemdata_8 =	readmemdata[7:0];
 assign readmemdata_16 = readmemdata[15:0];	

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
//---------------------------------------LB-------------------------------------
     		if(opcode==LB)  // read 1 byte from the mem and extend to 32 bits with sign
   			  begin
   			  	if(~readmemdata[7])              // positive
   			  	  loadmemdata_out <= {24'b0000_0000_0000_0000_0000_0000,readmemdata_8}; 
   			  	else                             //negative
   			  		loadmemdata_out <= {25'b1000_0000_0000_0000_0000_00000,readmemdata_8[6:0]};   			  	  
   			  end
//---------------------------------------LBU------------------------------------
     		else if(opcode==LBU)  // read 1 byte from the mem and extend to 32 bits without sign
   			  begin   			  	
   			  	loadmemdata_out <= {24'b0000_0000_0000_0000_0000_0000,readmemdata_8};    			  	  	  
   			  end   			  
//---------------------------------------LH-------------------------------------
     		else if(opcode==LH)  // read 16 bits from the mem and extend to 32 bits with sign
   			  begin
   			  	if(~readmemdata[15])              // positive
   			  	  loadmemdata_out <= {16'b0000_0000_0000_0000,readmemdata_16}; 
   			  	else                             //negative
   			  		loadmemdata_out <= {17'b1000_0000_0000_0000_0,readmemdata_16[14:0]};   			  	  
   			  end
//---------------------------------------LHU------------------------------------
     		else if(opcode==LBU)  // read 16 bits from the mem and extend to 32 bits without sign
   			  begin   			  	
   			  	loadmemdata_out <= {16'b0000_0000_0000_0000,readmemdata_16};    			  	  	  
   			  end   	
//---------------------------------------LW-------------------------------------
     		else if(opcode==LW)  // read a word from the mem 
   			  begin   			  	
   			  	loadmemdata_out <= readmemdata;    			  	  	  
   			  end    			  		  
//----------------------------------SB,SH,SW------------------------------------
     	/*	else if((opcode==SB)|(opcode==SH)|(opcode==SW))          // write data to mem 
   			  begin   			  	
   			  	//memwriteenable <= 1;                                 // enable to write mem    			  	  	  
   			  end    	  */
//-----------ADDI~SNEI,BNEZ~JAL,TRAP,RFE,NOP,R_TYPE needn't access mem----------
		   		
     	end       
   end 
    
 endmodule