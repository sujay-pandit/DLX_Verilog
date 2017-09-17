`timescale 1ns/100ps

module test;

reg clock_i;
reg reset_i;
wire [31:0] inst_i;
wire [31:0] regs1;
wire [31:0] regs2;
wire [31:0] regs3;
wire [31:0] regs4;
wire [31:0] regs5;
wire [31:0] regs6;
wire [31:0] regs7;
wire [31:0] regs8;
wire [31:0] regs9;
wire [31:0] regs10;
wire [31:0] regs11;
wire [31:0] regs12;
wire [31:0] regs13;
wire [31:0] regs14;
wire [31:0] regs15;
wire [31:0] regs16;
wire [31:0] regs17;
wire [31:0] regs18;
wire [31:0] regs19;
wire [31:0] regs20;
wire [31:0] regs21;
wire [31:0] regs22;
wire [31:0] regs23;
wire [31:0] regs24;
wire [31:0] regs25;
wire [31:0] regs26;
wire [31:0] regs27;
wire [31:0] regs28;
wire [31:0] regs29;
wire [31:0] regs30;
wire [31:0] regs31;
wire [31:0] pc_o;
wire [31:0] mem_addr_o;
wire [31:0] mdata_i;
wire [31:0] mdata_o;
wire mem_wr_en_o;
wire [31:0] mem_addr_in_use;
wire [31:0] mem_addr_in_use_value;


dlxpipeline lzy(.clock(clock_i),.reset(reset_i),.pc(pc_o),.inst_in(inst_i),.memdata_in(mdata_i),

                .memdata_out(mdata_o),.mem_addr(mem_addr_o),.mem_wr_en(mem_wr_en_o),.regs1(regs1),.regs2(regs2),.regs3(regs3),.regs4(regs4),.regs5(regs5),.regs6(regs6),.regs7(regs7),.regs8(regs8),
                        .regs9(regs9),.regs10(regs10)
                        ,.regs11(regs11),.regs12(regs12),.regs13(regs13),.regs14(regs14),.regs15(regs15),.regs16(regs16),.regs17(regs17),.regs18(regs18),
                        .regs19(regs19),.regs20(regs20)
                        ,.regs21(regs21),.regs22(regs22),.regs23(regs23),.regs24(regs24),.regs25(regs25),.regs26(regs26),.regs27(regs27),.regs28(regs28),
                         .regs29(regs29),.regs30(regs30),.regs31(regs31));
			         
RAM_BLOCK ram(.adr_i(mem_addr_o),.clk_i(clock_i),.we_i(mem_wr_en_o),.data_i(mdata_o),.data_o(mdata_i),.reset(reset_i),.mem_addr_in_use(mem_addr_in_use),
                                .mem_addr_in_use_value(mem_addr_in_use_value));

ROM_BLOCK rom(.data_i(pc_o),.data_o(inst_i),.clk_i(clock_i));
		       

//reg [31:0] inst_memory [0:63];

 initial
  begin
  /* $readmemb("testp.txt",inst_memory);
    $display("data:");           
    for (i=0; i <5; i=i+1)         
     $display("%d:%b",i,inst_memory[i]);    
  	*/
  	clock_i = 1'b1;
  	reset_i = 1'b1;
  	
                    //  opcode  rs1  rd  imm           //  opcode  rs1  rs2  rd  func            //  opcode   offset
                    //    6      5    5   16           //    6      5    5   5    11             //    6        26
                   
   
    
   
  	
    #30; 	
  	reset_i = 1'b0;
  	#20;
  	reset_i = 1'b1;
  	#40;
  	
  /*	for (i=0; i <6; i=i+1) 
  	begin
  	inst_i=inst_memory[i];
  	#50;
  	end */
  	
  	/* Test Programme-1 
  	a=15;
  	b=a+15;
  	 inst_i = {6'b010000,5'b00001,5'b00010,16'b0000_0000_0000_1111};     //  reg[R1] + imm -> reg[R2]
         //           ADDI      R1       R2            15
         #50;
          inst_i = {6'b010000,5'b00010,5'b00011,16'b0000_0000_0000_1111};     //  reg[R2] + imm -> reg[R3]
            //           ADDI      R2       R3            15
            #50;
            */
            /* Test Programme-2 
                  a=15;
                 b=a+15;
                  c=a;
                  d=c+14;
                   inst_i = {6'b010000,5'b00001,5'b00010,16'b0000_0000_0000_1111};     //  reg[R1] + 15 -> reg[R2]
                     //           ADDI      R1       R2            15
                     #50;
                     inst_i ={6'b001010,5'b01000,5'b00010,16'b0000_0000_0000_1000};     //mem[reg[R8]+8]=reg[R2]
                     //         SW      R8          R2          8
                     #50;
                      inst_i = {6'b010000,5'b00010,5'b00011,16'b0000_0000_0000_1111};     //  reg[R2] + 15 -> reg[R3]
                        //           ADDI      R2       R3            15
                        #50;
                        inst_i={6'b000101, 5'b01000,5'b00100,16'b0000_0000_0000_1000};  //reg[R4]=mem[reg[R8]+8]
                        //          LW      R8      R4          8
                        #50;
                        inst_i = {6'b010000,5'b00100,5'b00101,16'b0000_0000_0000_1110};     //  reg[R4] + 14 -> reg[R5]
                        //          ADDI    R4          R5      14
                        #50;
                        
              */  
                        
                        
  	/* TEST INSTRUCTIONS
  	
    inst_i = {6'b010000,5'b00001,5'b00010,16'b0000_1111_0000_1010};     //  reg[R1] + imm -> reg[R2]
    //           ADDI      R1       R2            3850
    #10;
    
    inst_i = {6'b010010,5'b00011,5'b00100,16'b0000_1111_1111_0110};     //  reg[R3] - imm -> reg[R4]
    //           SUBI      R3       R4             4086
    #10;		
    
    inst_i = {6'b010101,5'b00101,5'b00110,16'b1000_0100_0110_0000};     //  reg[R5] | imm -> reg[R6]
    //            ORI      R5       R6            33888
    #10;	
    
    inst_i = {6'b110000,5'b00111,5'b01000,5'b01001,11'b0000_0001_111};  //  if(reg[R7]==reg[R8]) 1 -> reg[R9] or 0 -> reg[R9]
    //           SEQ       R7       R8       R9           15
    #10;
    
    inst_i = {6'b100000,5'b01010,5'b00000,16'b0000_0000_0000_1110};     //  if(reg[R10]==0) PC + imm16 + 4 ->PC
    //           BEQZ      R10                        14
    #10;
    
    inst_i = {6'b100011,5'b01011,5'b00000,16'b0000_0000_0000_0000};     //   PC + 8-> reg[R31], reg[R11] -> PC
    //           JALR      R11                    
    #10;	
    
          			
    inst_i = {6'b010111,5'b00010,5'b01100,16'b0000_0000_0000_0101};     //  reg[R2] << imm -> reg[R12]
    //           SLLI      R2       R12             5
    #10;		
    
    inst_i = {6'b001010,5'b011010,5'b00110,16'b0000_0000_0000_1000};     //   reg[R6] -> Mem[8 + reg[R26]]
    //             SW       R26       R6             #8
    #50;
        
   
    inst_i = {6'b000101,5'b10001,5'b10110,16'b0000_0000_0001_0111};     //   Mem[imm + reg[R17]] -> reg[R22]
    //             LW       R17       R22           #23
    #10;
    
    
    inst_i = {6'b011001,5'b00100,5'b11100,16'b0000_0000_0000_0101};     //  sign>> imm ## reg[R2] >> imm -> reg[R28]
    //           SRAI      R4       R28             5
    #10;
    		*/
    
    
    #20000;
    
  
   $stop;    
  end
  


always #5   clock_i = ~clock_i; 

endmodule