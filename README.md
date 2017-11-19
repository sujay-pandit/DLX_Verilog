# DLX_Verilog
Verilog implementation of DLX processor 

The processor works for the following instructions:

//---------------------------------I-type instructions-------------------------------------					
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
						
//---------------------------------J-type instructions with function code-------------------------------------							
            J		    =6'b100100,
//---------------------------------R-type instructions with function code-------------------------------------
R_TYPE  =6'b110000; //Opcode for all instructions s the same
          	ADD		  =6'b000001,
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
