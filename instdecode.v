`timescale 1ns/100ps

 module instdecode(npc_in2,inst_in2,clock2,reg_add_in,reg_data_in,reset2,
                  
                   reg_write_en,irout2,aout2,bout2,imout2,npcout2,regs1,regs2,regs3,regs4,regs5,regs6,regs7,regs8,regs9,regs10
                   ,regs11,regs12,regs13,regs14,regs15,regs16,regs17,regs18,regs19,regs20,regs21,regs22,regs23,regs24,regs25,
                   regs26,regs27,regs28,regs29,regs30,regs31);
 
 input [31:0] npc_in2,inst_in2,reg_data_in;
 input [4:0] reg_add_in;
 input reg_write_en;
 input clock2;
 input reset2;
 output reg [31:0]regs1;
 output reg [31:0]regs2;
 output reg [31:0]regs3;
 output reg [31:0]regs4;
 output reg [31:0]regs5;
 output reg [31:0]regs6;
 output reg [31:0]regs7;
 output reg [31:0]regs8;
 output reg [31:0]regs9;
 output reg [31:0]regs10;
 output reg [31:0]regs11;
  output reg [31:0]regs12;
  output reg [31:0]regs13;
  output reg [31:0]regs14;
  output reg [31:0]regs15;
  output reg [31:0]regs16;
  output reg [31:0]regs17;
  output reg [31:0]regs18;
  output reg [31:0]regs19;
  output reg [31:0]regs20;
  output reg [31:0]regs21;
   output reg [31:0]regs22;
   output reg [31:0]regs23;
   output reg [31:0]regs24;
   output reg [31:0]regs25;
   output reg [31:0]regs26;
   output reg [31:0]regs27;
   output reg [31:0]regs28;
   output reg [31:0]regs29;
   output reg [31:0]regs30;
   output reg [31:0]regs31;
 

 
 output [31:0] aout2,bout2,irout2,imout2,npcout2;
 
 reg [31:0] aout2,bout2,irout2,imout2,npcout2;
 reg [31:0] regs[31:1];    // R1~R31,32bit
 
 //wire [31:0] imm16_32_cpl,imm16_32_sg,imm16_32_ug;
 wire [25:0] offset;
 wire [14:0] imm16_15_cpl,imm16_15;
 wire [15:0] imm16_16_cpl,imm16;
 wire [5:0] opcode,func;
 wire [4:0] rs1,rd_rs2,imm16_5;
 
 
 //---------------------------------operation code-------------------------------------	
 parameter	
						LW		  =6'b00010,
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
 
 assign opcode[5:0] = inst_in2[31:26];                            // opcode
 
 assign imm16[15:0] = inst_in2[15:0];                              // immediate
 
 assign rs1[4:0] = inst_in2[25:21];                               // if I and R type ,it's source reg
 
 assign rd_rs2[4:0] = inst_in2[20:16];                            // if I type ,it's rd;  if R type ,it's rs2 
 
 assign func[5:0] = inst_in2[5:0];             // if R type, it's func code, func code =11'b00000_xxxxxxx , here only get its last 6 bits
  
 assign offset[25:0] = inst_in2[25:0];                             // if J type ,it's offset
 
 assign imm16_15_cpl[14:0] = (~imm16[14:0]+1'b1);
 
 assign imm16_16_cpl[15:0] = (~imm16[15:0]+1'b1);
 
 assign imm16_5[4:0] = imm16[4:0];
 
 assign imm16_15[14:0] = imm16[14:0];  
 

 always@(posedge clock2 or negedge reset2)
   begin
     if(~reset2)
     	 begin
     	 	  aout2<= 0;
					bout2<= 0;
					irout2<= 0;
					imout2<= 0;
					npcout2<= 0;					
     	   // regs[0]<= 0;
     	    regs[1]<= 0; 
     	    regs[2]<= 0; 
     	    regs[3]<= 0; 
     	    regs[4]<= 0; 
     	    regs[5]<= 0; 
     	    regs[6]<= 0; 
     	    regs[7]<= 0;   
     	    regs[8]<= 0;
     	    regs[9]<= 0; 
     	    regs[10]<= 0; 
     	    regs[11]<= 0; 
     	    regs[12]<= 0; 
     	    regs[13]<= 0; 
     	    regs[14]<= 0; 
     	    regs[15]<= 0; 
     	    regs[16]<= 0;
     	    regs[17]<= 0; 
     	    regs[18]<= 0; 
     	    regs[19]<= 0; 
     	    regs[20]<= 0; 
     	    regs[21]<= 0; 
     	    regs[22]<= 0; 
     	    regs[23]<= 0; 
     	    regs[24]<= 0;
     	    regs[25]<= 0; 
     	    regs[26]<= 0; 
     	    regs[27]<= 0; 
     	    regs[28]<= 0; 
     	    regs[29]<= 0; 
     	    regs[30]<= 0; 
     	    regs[31]<= 0;   	       	   
     	 end     	                 
     else
     	 begin     		
     	    regs1 <= regs[1]; 
            regs2 <= regs[2]; 
            regs3 <= regs[3]; 
            regs4 <= regs[4]; 
            regs5 <= regs[5]; 
            regs6 <= regs[6]; 
            regs7 <= regs[7]; 
            regs8 <= regs[8]; 
            regs9 <= regs[9]; 
            regs10 <= regs[10]; 
            regs11 <= regs[11]; 
                        regs12 <= regs[12]; 
                        regs13 <= regs[13]; 
                        regs14 <= regs[14]; 
                        regs15 <= regs[15]; 
                        regs16 <= regs[16]; 
                        regs17 <= regs[17]; 
                        regs18 <= regs[18]; 
                        regs19 <= regs[19]; 
                        regs20 <= regs[20]; 
                        regs21 <= regs[21]; 
                                    regs22 <= regs[22]; 
                                    regs23 <= regs[23]; 
                                    regs24 <= regs[24]; 
                                    regs25 <= regs[25]; 
                                    regs26 <= regs[26]; 
                                    regs27 <= regs[27]; 
                                    regs28 <= regs[28]; 
                                    regs29 <= regs[29]; 
                                    regs30 <= regs[30]; 
                     	            regs31 <= regs[31];  
     	       		 		
     		irout2 <= inst_in2;                                           // IR2 -> IR3
     		npcout2 <= npc_in2;                                           //  NPC2 -> NPC3  
     		if((|reg_add_in)&(reg_write_en))                              // reg_add_in!=0
     			regs[reg_add_in] <= reg_data_in;                            // write back the data                            
//-----------------------------------------LW,ADDI,SLTI,SGEI,SEQI,SLEI,SNEI-----------------------------------
     		if((opcode==LW)|(opcode==ADDI)|((opcode>=SLTI)&(opcode<=SNEI))) 	               
          begin            	
          	if(~imm16[15])                                     /// imm16>0
          		begin
          			imout2 <= {16'b0000_0000_0000_0000,imm16};     //  16 bit immediate extend to 32 bits
          			if(~regs[rs1][31])                             //  regs[rs1]>0
          				aout2 <= regs[rs1];                          //  regs[rs1]->A          			
          			else                                           //  regs[rs1]<0
          				aout2 <= {1'b1,~regs[rs1][30:0]+1};          //  complemental code            				            				
          		end
          	else  
          		begin          		                                  //  imm16<0
	              imout2 <= {1'b1,(~{16'b0000_0000_0000_0000,imm16_15}+1)};   //  complemental code,and extend to 32 bits	
	              if(~regs[rs1][31])
	          				aout2 <= regs[rs1];                           //  imm16>0,regs[rs1]>0,regs[rs1]->A          			
	        			else                                              //  regs[rs1]<0
	        				aout2 <= ~regs[rs1]+1;                          //  complemental code    
	        		end  				               	     				
     			end   
//-------------------------------------------------SUBI-------------------------------------------------------------     			
        else if(opcode==SUBI)	               
          begin            	
          	if(imm16[15])                                       //  imm16<0           
          		begin
          			imout2 <= {17'b00000_0000_0000_0000,imm16_15};  //  subtration change to addition
          			if(~regs[rs1][31])                              //  regs[rs1]>0
          				aout2 <= regs[rs1];                           //  regs[rs1]->A          					
          			else                                            //  regs[rs1]<0
          				aout2 <= {1'b1,~regs[rs1][30:0]+1};           //  complemental code            				            				
          		end
          	else                                                //  imm16>0
          		begin           		                                  
                imout2 <= {1'b1,(~{16'b0000_0000_0000_0000,imm16_15}+1)};   //  complemental code,and extend to 32 bits	 
                if(~regs[rs1][31])                              //  regs[rs1]>0
          				aout2 <= regs[rs1];                           //  regs[rs1]->A          					
          			else                                            //  regs[rs1]<0
          				aout2 <= {1'b1,~regs[rs1][30:0]+1};           //  complemental code   
              end    				               	     				
     			end       			
//------------------------------------SW--------------------------------------------------------------	     			
	     	else if((opcode==SW))         
	     		begin
	     			bout2 <= regs[rd_rs2];                             //  regs[rs2_rd]->B
		     		if(~imm16[15])                                     //  imm16>0
          		begin
          			imout2 <= {16'b0000_0000_0000_0000,imm16};     //  16 bit immediate extend to 32 bits
          			if(~regs[rs1][31])                             //  regs[rs1]>0
          				aout2 <= regs[rs1];                          //  regs[rs1]->A          			
          			else                                           //  regs[rs1]<0
          				aout2 <= {1'b1,~regs[rs1][30:0]+1};          //  complemental code            				            				
          		end
          	else  
          		begin          		                                  //  imm16<0
	              imout2 <= {1'b1,(~{16'b0000_0000_0000_0000,imm16_15}+1)};   //  complemental code,and extend to 32 bits	
	              if(~regs[rs1][31])
	          				aout2 <= regs[rs1];                           //  imm16>0,regs[rs1]>0,regs[rs1]->A          			
	        			else                                              //  regs[rs1]<0
	        				aout2 <= ~regs[rs1]+1;                          //  complemental code    
	        		end  		   				               	     				
	     	  end   
//------------------------------------ANDI,ORI,XORI------------------------------------------------------	   	     			   			
     	  else if((opcode==ANDI)|(opcode==ORI)|(opcode==XORI))              		  
  				begin
  					aout2 <= regs[rs1];                          //  they are unsigned,regs[rs1]->A
  					imout2 <= {16'b0000_0000_0000_0000,imm16};    //  16 bit immediate extend to 32 bits
  				end
//----------------------------------------------BEQZ,BNEZ------------------------------------------------------	   	     			   			
	     	else if((opcode==BEQZ)|(opcode==BNEZ))         
	     		begin
	     			aout2 <= regs[rs1];
	     			imout2<={16'b0000_0000_0000_0000,imm16};end
                                                   //  regs[rs1]->A	     			
		  /*   		if(~imm16[15])     	          		                   //  imm16>0        
        			imout2 <= {16'b0000_0000_0000_0000,imm16};          //  only extend to 32 bits	          		          				
	          else            		                                 //  imm16<0
	            imout2 <= {1'b1,(~{16'b0000_0000_0000_0000,imm16_15}+1)};  //  complemental code,and extend to 32 bits	     				               	     				
	     	  end  */	  
//--------------------------------------------------J----------------------------------------------------------	   	     			   			
	     	else if(opcode==J)  
	     		begin	     	
	     		    imout2<={6'b00_0000,offset[25:0]};
	     			//if(~offset[25])      
	     			 // imout2 <= {6'b00_0000,offset[25:0]};                //  offset -> imout2
	     			//else
	     				//imout2 <= {1'b1,(~{6'b00_0000,offset[24:0]}+1)};    //  complemental code,and extend to 32 bits
	     	  end	 
     		
//-------------------------------------------R type instruction-------------------------------------------------
	     	else if(opcode==R_TYPE)                                                 
	     		  begin
//-------------------------------------------------ADD----------------------------------------------------------	   	     			   				     	  	     		  	
	     		  	if(func==ADD)
	     		  		begin
	     		  			if(~regs[rs1][31])     
			          		begin
			          			if(~regs[rd_rs2][31])
			          				begin
			          					aout2 <= regs[rs1];                           //  regs[rs1]>0,regs[rd_rs2]>0
			          					bout2 <= regs[rd_rs2];                       
			          				end
			          			else                                              //  regs[rd_rs2]<0
			          				bout2 <= {1'b1,~regs[rd_rs2][30:0]}+1;           //  complemental code            				            				
			          		end
			          	else            		                                  
			              aout2 <= {1'b1,~regs[rs1][30:0]+1};                  //  complemental code  
	     		  		end
//---------------------------------------------ADDU,AND,OR,XOR-------------------------------------------------	 
              else if((func==AND_)|(func==OR_)|(func==XOR_))
	     		  		begin
	     		  			aout2 <= regs[rs1];                        //  regs[rs1] -> A
 		  		  	    bout2 <= regs[rd_rs2];                     //  regs[rd_rs2] -> B
	     		  		end
//----------------------------------------------------SUB------------------------------------------------------	 	     		  	
             else if(func==SUB)               	               
			          begin
	     		  			if(regs[rd_rs2][31])     
			          		begin
			          			if(~regs[rs1][31])
			          				begin
			          					aout2 <= regs[rs1];                           //  regs[rs1]>0,regs[rd_rs2]>0
			          					bout2 <= {1'b0,regs[rd_rs2][30:0]};            //  "-" change to "+"              
			          				end
			          			else                                              //  regs[rd_rs2]<0
			          				aout2 <= {1'b1,~regs[rs1][30:0]+1};              //  complemental code            				            				
			          		end
			          	else            		                                  
			              bout2 <= {1'b1,~regs[rd_rs2][30:0]+1};               //  complemental code  
	     		  		end 

//----------------------------------------SLT,SGT,SLE,SGE,SEQ,SNE-----------------------------------------------	   	     			   			
            else if((func==SLT)|(func==SGT)|(func==SLE)|(func==SGE)|(func==SEQ)|(func==SNE)) 
          	  begin	     		  						          			
		          	aout2 <= regs[rs1];                           //  regs[rs1]->A			          					            			          				       		                                  
		            bout2 <= regs[rd_rs2];                        //  regs[rd_rs2]->B 
     		  		end     		  		
            end
      end 
   end 
 endmodule