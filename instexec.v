`timescale 1ns/100ps

 module instexec(ain3,bin3,imin3,inst_in3,npcout3,clock3,reset3,alu_out3,bout3,inst_out3,alu_branch_out,branch_en,mem_wr_en,jump_en);
 input [31:0] ain3;
 input [31:0] bin3;
 input [31:0] imin3;
 input [31:0] inst_in3;
 input [31:0] npcout3;
 input clock3;
 input reset3;
 
 output [31:0] alu_out3;
 output [31:0] bout3;
 output [31:0] inst_out3;
 output [31:0] alu_branch_out;
 output branch_en;
 output mem_wr_en;
 output jump_en;
 
 reg [31:0] alu_out3;
 reg [31:0] bout3;
 reg [31:0] inst_out3;
 reg branch_en;
 reg jump_en;
 reg mem_wr_en;
 
 wire [31:0] alu_branch_out;
 wire [31:0] sum_a_imm;
 wire [31:0] sum_a_npc;
 wire [31:0] sum_a_b;
 wire [31:0] sra_a_imm;
 wire [31:0] sra_a_b;
 wire [31:0] srl_all_one_imm,srl_all_one_b;
 wire [5:0] opcode;
 wire [5:0] func;
 
//---------------------------------operation code-------------------------------------	
 parameter	LB		  =6'b000001,
						LBU		  =6'b000010,
						LH		  =6'b000011,
						LHU		  =6'b000100,
						LW		  =6'b000101,
						SB		  =6'b001000,
						SH		  =6'b001001,
						SW		  =6'b001010,
						ADDI		=6'b010000,
						ADDUI		=6'b010001,
						SUBI		=6'b010010,
						SUBUI		=6'b010011,
						ANDI		=6'b010100,
						ORI		  =6'b010101,
						XORI		=6'b010110,
						LHI		  =6'b000110,
						SLLI		=6'b010111,
						SRLI		=6'b011000,
						SRAI		=6'b011001,
						SLTI		=6'b011010,
						SGTI		=6'b011011,
						SGEI		=6'b011100,
						SEQI		=6'b011101,
						SLEI		=6'b011110,
						SNEI		=6'b011111,
						BEQZ		=6'b100000,
						BNEZ		=6'b100001,
						JR		  =6'b100010,
						JALR		=6'b100011,
						J		    =6'b100100,
						JAL		  =6'b100101,
						TRAP		=6'b100110,
						RFE		  =6'b100111,
						NOP     =6'b000000,
						R_TYPE  =6'b110000;
//---------------------------------function code-------------------------------------					
 parameter	ADD		  =6'b000001,
						ADDU	  =6'b000010,
						SUB			=6'b000011,
						SUBU		=6'b000100,
						AND_ 		=6'b000101,
						OR_  		=6'b000110,
						XOR_ 		=6'b000111,
						SLL 		=6'b001000,
						SRL			=6'b001001,
						SRA			=6'b001010,
						SLT			=6'b001011,
						SGT			=6'b001100,
						SLE			=6'b001101,
						SGE			=6'b001110,
						SEQ			=6'b001111,
						SNE			=6'b010000;
									
 assign alu_branch_out = alu_out3;                                   
 assign opcode[5:0] = inst_in3[31:26];
 assign func[5:0] = inst_in3[5:0]; 
 
 assign sum_a_imm = imin3 + ain3;
 //assign sum_a_npc = imin3 + npcout3;
 assign sum_a_npc=imin3;
 assign sum_a_b = ain3 + bin3;
 assign sra_a_imm = ain3 >> imin3[4:0];
 assign sra_a_b = ain3 >> bin3[4:0];
 assign srl_all_one_imm = 32'b1111_1111_1111_1111_1111_1111_1111_1111 >> imin3[4:0];
 assign srl_all_one_b = 32'b1111_1111_1111_1111_1111_1111_1111_1111 >> bin3[4:0];

 always@(posedge clock3 or negedge reset3)
   begin
     if(~reset3)
     	 begin
     	   alu_out3 <= 0; 
     	   bout3  <= 0;   
     	   inst_out3  	 <= 0;  
     	   branch_en <= 0;  
     	   mem_wr_en <= 0; 	   
     	 end     	                 
     else
     	begin
     	  if(branch_en==1)
     	  branch_en<=0;
     	
     		inst_out3 <= inst_in3;                      // IR3 -> IR4
     		//bout3 <= bin3;                              // B3 ->B4
     		if((opcode!=SB)&(opcode!=SH)&(opcode!=SW))
     		  mem_wr_en <= 0;
     		else if((opcode<BEQZ)|(opcode>RFE))
     			branch_en <= 1'b0;
     			
//------------------------------LB,LBU,LHU,LH,LW-----------------------------------
     		if((opcode==LB)|(opcode==LBU)|(opcode==LH)|(opcode==LHU)|(opcode==LW))
   			  begin
   			  	if(~sum_a_imm[31])
   			  	  alu_out3 <= sum_a_imm;        //  mem address  (should not be negative)   			  	    
   			  end  
//-------------------------------------SB------------------------------------------
     		else if(opcode==SB)
   			  begin
   			  	if(~sum_a_imm[31])               //  mem address  (should not be negative)
   			  		begin
		   			  	bout3 <= {24'b0000_0000_0000_0000_0000_0000,bin3[7:0]}; // store a byte  			  	
		   			  	alu_out3 <= sum_a_imm;  
		   			  	mem_wr_en <= 1; 	 		   			  	
   			      end
   			  end
//-------------------------------------SH------------------------------------------
     		else if(opcode==SH)
   			  begin
   			  	if(~sum_a_imm[31])               //  mem address  (should not be negative)
   			  		begin
		   			  	bout3 <= {16'b0000_0000_0000_0000,bin3[15:0]}; // store a half word  			  	
		   			  	alu_out3 <= sum_a_imm;  
		   			  	mem_wr_en <= 1; 	 		   			  	  
		   			  end
   			  end
//-------------------------------------SW------------------------------------------
     		else if(opcode==SW)
   			  begin
   			  	if(~sum_a_imm[31])               //  mem address  (should not be negative)
   			  		begin
		   			  	bout3 <= bin3;               // store a word  			  	
		   			  	alu_out3 <= sum_a_imm; 
		   			  	mem_wr_en <= 1; 	 		   			  	
		   			  end
   			  end   			  
//---------------------------------ADDI,SUBI----------------------------------------   			  
     		else if((opcode==ADDI)|(opcode==SUBI))	     			   			   
		  	  begin
 			  	  if(~sum_a_imm[31])                          //  positive
 			  	    alu_out3 <= sum_a_imm;
 			  	  else                                        //  negative 			  	   			  	
   			  	  alu_out3 <= {1'b1,~sum_a_imm[30:0]+1'b1}; // complemental code change to original code   			  	
   			  end
//-------------------------------------ADDUI----------------------------------------
     		else if(opcode==ADDUI)
   			  begin   			  	
   			  	alu_out3 <= sum_a_imm;                     // unsigned number
   			  end     			
//-------------------------------------SUBUI----------------------------------------
     		else if(opcode==SUBUI)
   			  begin   			  	
   			  	alu_out3 <= ~sum_a_imm + 1'b1;     // complemental code change to original code
   			  end   
//-------------------------------------ANDI----------------------------------------
     		else if(opcode==ANDI)
   			  begin   			  	
   			  	alu_out3 <= ain3&imin3;     
   			  end   
//-------------------------------------ORI----------------------------------------
     		else if(opcode==ORI)
   			  begin   			  	
   			  	alu_out3 <= ain3|imin3;     
   			  end  
//-------------------------------------XORI----------------------------------------
     		else if(opcode==XORI)
   			  begin   			  	
   			  	alu_out3 <= ain3^imin3;     
   			  end  
//-------------------------------------LHI----------------------------------------
     		else if(opcode==LHI)
   			  begin   			  	
   			  	alu_out3 <= sum_a_imm;    //  sum_a_imm = imm16##0^16 + reg[0];
   			  end  
//------------------------------------SLLI----------------------------------------
     		else if(opcode==SLLI)
   			  begin   			  	
   			  	alu_out3 <= ain3<<imin3[4:0];    //  left shift
   			  end
//------------------------------------SRLI----------------------------------------
     		else if(opcode==SRLI)
   			  begin   			  	
   			  	alu_out3 <= ain3>>imin3[4:0];    //  right shift
   			  end  
//------------------------------------SRAI----------------------------------------
     		else if(opcode==SRAI)
   			  begin   
   			  	if(~ain3[31])		                     // positive 	  	
   			  	  alu_out3 <= sra_a_imm; 
   			  	else                                     // negative
   			  		alu_out3 <= (sra_a_imm|(~srl_all_one_imm));   
   			  end 
//------------------------------------SLTI----------------------------------------
     		else if(opcode==SLTI)
   			  begin 
   			  	if(ain3<imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end   
//------------------------------------SGTI----------------------------------------
     		else if(opcode==SGTI)
   			  begin 
   			  	if(ain3>imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end 
//------------------------------------SGEI----------------------------------------
     		else if(opcode==SGEI)
   			  begin 
   			  	if(ain3>=imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end  
//------------------------------------SEQI----------------------------------------
     		else if(opcode==SEQI)
   			  begin 
   			  	if(ain3==imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end 
//------------------------------------SLEI----------------------------------------
     		else if(opcode==SLEI)
   			  begin 
   			  	if(ain3<=imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end  
//------------------------------------SNEI----------------------------------------
     		else if(opcode==SNEI)
   			  begin 
   			  	if(ain3!=imin3)  			  	
   			  	  alu_out3 <= 1;  
   			  	else
   			  		alu_out3 <= 0;                    
   			  end    
//------------------------------------BEQZ----------------------------------------
     		else if(opcode==BEQZ)
   			  begin 
   			  	if(ain3==0)  	  // ain3 == 0 and inst mem address should not be negative	
   			  		begin   			  			  	
   			  	    alu_out3 <= sum_a_npc;  
   			  	    branch_en <= 1'b1;  
   			  	  end 			  	
   			  end 
//------------------------------------BNEZ----------------------------------------
     		else if(opcode==BNEZ)
   			  begin
   			  		if(ain3!=0)
   			  		begin  			  			  	
   			  	    alu_out3 <= sum_a_npc; 
   			  	    branch_en <= 1'b1;  
                    end    			  	
   			  end  
//----------------------------------JR,JALR----------------------------------------
     		else if((opcode==JR)|(opcode==JALR))
   			  begin 
   			  	if(~sum_a_imm[31])  	                //  inst mem address should not be negative	 
   			  		begin  			  			  	
   			  	    alu_out3 <= sum_a_imm;  
   			  	    branch_en <= 1'b1;   
   			  	  end			  	
   			  end   
//-----------------------------------J,JAL-----------------------------------------
     		else if((opcode==J))//|(opcode==JAL))
   			  begin 
   			  	if(~sum_a_npc[31])  	                //  inst mem address should not be negative	 
   			  		begin  			  			  	
   			  	    alu_out3 <= sum_a_npc;  
   			  	    jump_en <= 1'b1;   
   			  	  end	    			  	
   			  end
//---------------------------------TRAP,RFE---------------------------------------
     		else if((opcode==TRAP)|(opcode==RFE))
   			  begin    			  	  			  			  	
		  	    alu_out3 <= sum_a_npc;        //  ???????????????
		  	    branch_en <= 1'b1;      			  	    			  	
   			  end   
//-------------------------------------NOP---------------------------------------
     		else if(opcode==NOP)
   			  begin    			  	  			  			  	
		  	    
		  	    branch_en <= 1'b0;      	//  ?????????????		  	    			  	
   			  end   
//-----------------------------------R_TYPE---------------------------------------
     		else if(opcode==R_TYPE)
   			  begin 
//-----------------------------------ADD,SUB--------------------------------------   			  	  			  			  	
		  	    if((func==SUB)|(func==ADD)) 
		  	    	begin
		  	    		if(~sum_a_b[31])                // positive 
		  	    		  alu_out3 <= sum_a_b;
		  	    		else                            // negative  
		  	    			alu_out3 <= {1'b1,~sum_a_b[30:0] + 1'b1}; // complemental code change to original code 
		  	    	end 
//-------------------------------------ADDU-----------------------------------------
		     		else if(func==ADDU)
		   			  begin   			  	
		   			  	alu_out3 <= sum_a_b;                     // unsigned number
		   			  end     			
//-------------------------------------SUBU-----------------------------------------
		     		else if(func==SUBU)
		   			  begin   			  	
		   			  	alu_out3 <= ~sum_a_b + 1'b1;     // complemental code change to original code
		   			  end 		  	    	
//-------------------------------------AND---------------------------------------		  	    	
		  	    else if(func==AND_) 
		  	    	begin
		  	    		alu_out3 <= ain3&bin3;
		  	    	end   
//-------------------------------------OR----------------------------------------		  	    	
		  	    else if(func==OR_) 
		  	    	begin
		  	    		alu_out3 <= ain3|bin3;
		  	    	end		
//------------------------------------XOR----------------------------------------		  	    	
		  	    else if(func==XOR_) 
		  	    	begin
		  	    		alu_out3 <= ain3^bin3;
		  	    	end		  	    	
//------------------------------------SLL-----------------------------------------
		     		else if(func==SLL)
		   			  begin   			  	
		   			  	alu_out3 <= ain3<<bin3[4:0];    //  left shift
		   			  end
//------------------------------------SRL-----------------------------------------
		     		else if(func==SRL)
		   			  begin   			  	
		   			  	alu_out3 <= ain3>>bin3[4:0];    //  right shift
		   			  end  
//------------------------------------SRA-----------------------------------------
		     		else if(func==SRA)
		   			  begin   
		   			  	if(~ain3[31])		                     // positive 	  	
		   			  	  alu_out3 <= sra_a_b; 
		   			  	else                                     // negative
		   			  		alu_out3 <= (sra_a_b|(~srl_all_one_b));   
		   			  end 
//------------------------------------SLT-----------------------------------------
		     		else if(func==SLT)
		   			  begin 
		   			  	if(ain3<bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end   
//------------------------------------SGT-----------------------------------------
		     		else if(func==SGT)
		   			  begin 
		   			  	if(ain3>bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end 
//------------------------------------SGE-----------------------------------------
		     		else if(func==SGE)
		   			  begin 
		   			  	if(ain3>=bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end  
//------------------------------------SEQ-----------------------------------------
		     		else if(func==SEQ)
		   			  begin 
		   			  	if(ain3==bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end 
//------------------------------------SLE-----------------------------------------
		     		else if(func==SLE)
		   			  begin 
		   			  	if(ain3<=bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end  
//------------------------------------SNE-----------------------------------------
		     		else if(func==SNE)
		   			  begin 
		   			  	if(ain3!=bin3)  			  	
		   			  	  alu_out3 <= 1;  
		   			  	else
		   			  		alu_out3 <= 0;                    
		   			  end 
		   				  	    		  	    	  	    	 			  	    			  	
   			  end
   		    			  			   			      			   			   			   			    			    			  			   			     			    			     			  			    			   			      			    		  			    			  			    		    		
     	end       
   end 
    
 endmodule