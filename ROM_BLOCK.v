`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2017 01:20:37
// Design Name: 
// Module Name: ROM_BLOCK
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


module ROM_BLOCK(reset_i,data_i,data_o);
input [31:0] data_i;
output reg [31:0] data_o;
input reset_i;

    integer i;       
    reg [31:0] inst_memory [0:63];
   /*  initial
      begin         
       $readmemb("testp.txt",inst_memory);
        $display("data:");           
        for (i=0; i <20; i=i+1)         
         $display("%d:%b",i,inst_memory[i]); 
         end */
         
      /*   always@(posedge clk_i)
         begin 
            if( i==0)
                    begin
                        inst_memory[0]=32'b01000000001000100000000000000000; 
                        inst_memory[1]=32'b01000000001000110000000000000000; 
                        inst_memory[2]=32'b01000000001001100000000000000000; 
                        inst_memory[3]=32'b01000000001001110000000000000000; 
                        inst_memory[4]=32'b01101000010001000000000000001010; 
                        inst_memory[5]=32'b01000000010001010000000000000001; 
                        inst_memory[6]=32'b10000000100000000000000000001111; 
                        inst_memory[7]=32'b01000000010001010000000000000001; 
                        inst_memory[8]=32'b01000000010001100000000000000000; 
                        inst_memory[9]=32'b01000000110000100000000000000001; 
                        inst_memory[10]=32'b01000000010001010000000000000001; 
                        inst_memory[11]=32'b01000000011001110000000000000000; 
                        inst_memory[12]=32'b11000000010001110001100000000001; 
                        inst_memory[13]=32'b01000000010001010000000000000001; 
                        inst_memory[14]=32'b10000100100000000000000000000010; 
                        inst_memory[15]=32'b01000000010001010000000000000001; 
                        inst_memory[16]=32'b00101000001001010000000000001000;
                        inst_memory[17]=32'b01000000001111100000000000000111; 
                        inst_memory[18]=32'b01000000001111000000000000000111; 
                        inst_memory[19]=32'b00010100001010000000000000001000;
                        inst_memory[20]=32'b01000000001111000000000000000111; 
                        i=1;             
                    end
         end */
         always@(data_i or reset_i)
         begin
            if(~reset_i)
            begin
                data_o<=32'b00000000000000000000000000000000;
            end
            case(data_i)
          // SUM OF FIRST N NATURAL NUMBERS
            /*
            32'b00000000000000000000000000000000: data_o=32'b01000000001000100000000000000000;
            32'b00000000000000000000000000000001: data_o=32'b01000000001000110000000000000000;
            32'b00000000000000000000000000000010: data_o=32'b01000000001001100000000000000000; 
            32'b00000000000000000000000000000011: data_o=32'b01000000001001110000000000000000; 
            32'b00000000000000000000000000000100: data_o=32'b01101000010001000000000000001010; 
            32'b00000000000000000000000000000101: data_o=32'b01000000010001010000000000000001;
            32'b00000000000000000000000000000110: data_o=32'b10000000100000000000000000001111; 
            32'b00000000000000000000000000000111: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000001000: data_o=32'b01000000010001100000000000000000; 
            32'b00000000000000000000000000001001: data_o=32'b01000000110000100000000000000001; 
            32'b00000000000000000000000000001010: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000001011: data_o=32'b01000000011001110000000000000000;  
            32'b00000000000000000000000000001100: data_o=32'b11000000010001110001100000000001; 
            32'b00000000000000000000000000001101: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000001110: data_o=32'b10000100100000000000000000000010; 
            32'b00000000000000000000000000001111: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000010000: data_o=32'b00101000001001010000000000001000;
            32'b00000000000000000000000000010001: data_o=32'b01000000001111100000000000000111; 
            32'b00000000000000000000000000010010: data_o=32'b01000000001111000000000000000111; 
            32'b00000000000000000000000000010011: data_o=32'b00010100001010000000000000001000;
            32'b00000000000000000000000000010100: data_o=32'b01000000001111000000000000000111; 
            */
            //Nth FIBONACCI NUMBER
            /*
               32'b00000000000000000000000000000000: data_o=32'b01000000000000010000000000000000;
               32'b00000000000000000000000000000001: data_o=32'b01000000000000100000000000000001;
               32'b00000000000000000000000000000010: data_o=32'b01000000000000110000000000000000; 
               32'b00000000000000000000000000000011: data_o=32'b01000000000001000000000000000000; 
               32'b00000000000000000000000000000100: data_o=32'b01101000100001010000000000010000; 
               32'b00000000000000000000000000000101: data_o=32'b10000000101000000000000000001111;
              // 32'b00000000000000000000000000000110: data_o=32'b01000000000110000000000000000000;
               32'b00000000000000000000000000000110: data_o=32'b11000000010000010001100000000001; 
               32'b00000000000000000000000000000111: data_o=32'b01000000010000010000000000000000; 
               32'b00000000000000000000000000001000: data_o=32'b01000000011000100000000000000000; 
               32'b00000000000000000000000000001001: data_o=32'b01000000100001100000000000000000; 
               32'b00000000000000000000000000001010: data_o=32'b01000000110001000000000000000001; 
               32'b00000000000000000000000000001011: data_o=32'b10000100101000000000000000000100;  
                              
                
            */
            //STRING HELLO-SUJAY
            32'b00000000000000000000000000000000: data_o=32'b11111100000000000000000001001000;
            32'b00000000000000000000000000000001: data_o=32'b11111100000000000000000000000110;
            32'b00000000000000000000000000000010: data_o=32'b11111100000000000000000001000111; 
            32'b00000000000000000000000000000011: data_o=32'b11111100000000000000000001000111; 
            32'b00000000000000000000000000000100: data_o=32'b11111100000000000000000000000001; 
            32'b00000000000000000000000000000101: data_o=32'b11111100000000000000000001111110;
            32'b00000000000000000000000000000110: data_o=32'b11111100000000000000000000010010; 
            32'b00000000000000000000000000000111: data_o=32'b11111100000000000000000001000001; 
            32'b00000000000000000000000000001000: data_o=32'b11111100000000000000000001110001; 
            32'b00000000000000000000000000001001: data_o=32'b11111100000000000000000000001000; 
            32'b00000000000000000000000000001010: data_o=32'b11111100000000000000000001010000;
            
            32'b00000000000000000000000000001011: data_o=32'b01000000001000100000000000000000;
            32'b00000000000000000000000000001100: data_o=32'b01000000001000110000000000000000;
            32'b00000000000000000000000000001101: data_o=32'b01000000001001100000000000000000; 
            32'b00000000000000000000000000001110: data_o=32'b01000000001001110000000000000000; 
            32'b00000000000000000000000000001111: data_o=32'b01101000010001000000000000001010; 
            32'b00000000000000000000000000010000: data_o=32'b01000000010001010000000000000001;
            32'b00000000000000000000000000010001: data_o=32'b10000000100000000000000000111111; 
            32'b00000000000000000000000000010010: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000010011: data_o=32'b01000000010001100000000000000000; 
            32'b00000000000000000000000000010100: data_o=32'b01000000110000100000000000000001; 
            32'b00000000000000000000000000010101: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000010110: data_o=32'b01000000011001110000000000000000;  
            32'b00000000000000000000000000010111: data_o=32'b11000000010001110001100000000001; 
            32'b00000000000000000000000000011000: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000011001: data_o=32'b10000100100000000000000000001101; 
            32'b00000000000000000000000000011010: data_o=32'b01000000010001010000000000000001; 
            32'b00000000000000000000000000011011: data_o=32'b00101000001001010000000000001000;
            32'b00000000000000000000000000011100: data_o=32'b01000000001111100000000000000111; 
            32'b00000000000000000000000000011101: data_o=32'b01000000001111000000000000000111; 
            32'b00000000000000000000000000011110: data_o=32'b00010100001010000000000000001000;
            32'b00000000000000000000000000011111: data_o=32'b01000000001111000000000000000111;  
            
            endcase                
                //data_o<=inst_memory[data_i];
         end
endmodule