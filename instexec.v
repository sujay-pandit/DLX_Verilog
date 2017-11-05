`timescale 1ns/100ps

 module instexec(ain3,bin3,imin3,inst_in3,clock3,reset3,alu_out3,bout3,inst_out3,alu_branch_out,branch_en,mem_en,jump_en);
 input [31:0] ain3;
 input [31:0] bin3;
 input [31:0] imin3;
 input [31:0] inst_in3;
 //input [31:0] npcout3;
 input clock3;
 input reset3;
 
 output [31:0] alu_out3;
 output [31:0] bout3;
 output [31:0] inst_out3;
 output [31:0] alu_branch_out;
 output branch_en;
 output mem_en;
 output jump_en;
 
 reg [31:0] alu_out3;
 reg [31:0] bout3;
 reg [31:0] inst_out3;
 reg branch_en;
 reg jump_en;
 reg mem_en;
 
 reg [31:0] alu_branch_out;
 wire [31:0] sum_a_imm;
 wire [31:0] sum_a_npc;
 wire [31:0] sum_a_b;
 wire [5:0] opcode;
 wire [5:0] func;
 
//---------------------------------operation code-------------------------------------	
 parameter	
						LW		  =6'b000101,
						SW		  =6'b001010,
						ADDI		=6'b010000,
						SUBI		=6'b010010,
						ANDI		=6'b010100,
						ORI		  =6'b010101,
						XORI		=6'b010110,
						SLTI		=6'b011010,
						SGTI		=6'b011011,
						SGEI		=6'b011100,
						SEQI		=6'b011101,
						SLEI		=6'b011110,
						SNEI		=6'b011111,
						BEQZ		=6'b100000,
						BNEZ		=6'b100001,
						J		    =6'b100100,
						R_TYPE  =6'b110000;
//---------------------------------function code-------------------------------------					
 parameter	ADD		  =6'b000001,
						SUB			=6'b000011,
						AND_ 		=6'b000101,
						OR_  		=6'b000110,
						XOR_ 		=6'b000111,
						SLT			=6'b001011,
						SGT			=6'b001100,
						SLE			=6'b001101,
						SGE			=6'b001110,
						SEQ			=6'b001111,
						SNE			=6'b010000;            
									
 //assign alu_branch_out = alu_out3;                                   
 assign opcode[5:0] = inst_in3[31:26];
 assign func[5:0] = inst_in3[5:0]; 
 
 assign sum_a_imm = imin3 + ain3;
 //assign sum_a_npc = imin3 + npcout3;
 assign sum_a_npc=imin3;
 assign sum_a_b = ain3 + bin3;

 always@(posedge clock3 or negedge reset3)
   begin
     if(~reset3)
     	 begin
     	   alu_out3 <= 0; 
     	   bout3 <= 0;   
     	   inst_out3 <= 0;  
     	   branch_en <= 0;  
     	   jump_en<=0;
     	   mem_en <= 0; 	
     	    alu_branch_out<=0;   
     	 end     	                 
     else
     	begin
     	  if(branch_en==1)
     	  branch_en<=0;
     	
     		inst_out3 <= inst_in3;                      // IR3 -> IR4
     		//bout3 <= bin3;                              // B3 ->B4
     		if((opcode!=SW)||(opcode!=LW))
     		  mem_en <= 0;
     		else if((opcode<BEQZ))
     			branch_en <= 1'b0;
     			
//------------------------------LW-----------------------------------
     		if((opcode==LW))
   			  begin
   			  	if(~sum_a_imm[31]) 
   			  	  alu_out3 <= sum_a_imm;        //  mem address  (should not be negative)   
   			  	  mem_en<=1;			  	    
   			  end  


//-------------------------------------SW------------------------------------------
     		else if(opcode==SW)
   			  begin
   			  	if(~sum_a_imm[31])               //  mem address  (should not be negative)
   			  		begin
		   			  	bout3 <= bin3;               // store a word  			  	
		   			  	alu_out3 <= sum_a_imm; 
		   			  	mem_en <= 1; 	 		   			  	
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

//-----------------------------------J-----------------------------------------
     		else if((opcode==J))
   			  begin 
   			  	if(~sum_a_npc[31])  	                //  inst mem address should not be negative	 
   			  		begin  			  			  	
   			  	    alu_out3 <= sum_a_npc;  
   			  	    jump_en <= 1'b1;   
   			  	  end	    			  	
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
   		 alu_branch_out = alu_out3;   			  			   			      			   			   			   			    			    			  			   			     			    			     			  			    			   			      			    		  			    			  			    		    		
     	end       
   end 
    
 endmodule