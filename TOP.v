`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2017 20:54:02
// Design Name: 
// Module Name: TOP
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


module TOP(clock,reset_i,regs,strings);
input clock;
input reset_i;
output [15:0]regs;
output [7:0]strings;

 wire reset_i;
 wire [7:0] strings;
//CORE-1================================================================================================================
    reg clock_i_1=1'b0;
  //  wire [4:0]segs;
    wire [31:0] inst_i_1;
    wire [31:0] regs0_1;
    wire [31:0] regs1_1;
    wire [31:0] regs2_1;
    wire [31:0] regs3_1;
    wire [31:0] regs4_1;
    wire [31:0] regs5_1;
    wire [31:0] regs6_1;
    wire [31:0] regs7_1;
    wire [31:0] regs8_1;
    wire [31:0] regs9_1;
    wire [31:0] regs10_1;
    wire [31:0] regs11_1;
    wire [31:0] regs12_1;
    wire [31:0] regs13_1;
    wire [31:0] regs14_1;
    wire [31:0] regs15_1;
    wire [31:0] regs16_1;
    wire [31:0] regs17_1;
    wire [31:0] regs18_1;
    wire [31:0] regs19_1;
    wire [31:0] regs20_1;
    wire [31:0] regs21_1;
    wire [31:0] regs22_1;
    wire [31:0] regs23_1;
    wire [31:0] regs24_1;
    wire [31:0] regs25_1;
    wire [31:0] regs26_1;
    wire [31:0] regs27_1;
    wire [31:0] regs28_1;
    wire [31:0] regs29_1;
    wire [31:0] regs30_1;
    wire [31:0] regs31_1;
    wire [31:0] pc_o_1;
    wire [31:0] mem_addr_o_1;
    wire [31:0] mdata_i_1;
    wire [31:0] mdata_o_1;
    wire mem_en_o_1;
    wire [31:0] mem_addr_in_use_1;
    wire [31:0] mem_addr_in_use_value_1;
    wire branch_en_1;
    wire [31:0] alu_branch_1;
    wire [31:0] alu_out34_1;
    wire jump_en_1;
    wire fetchclock_1;
    wire [4:0] reg_add_1;
    wire [31:0] reg_data_1;
    wire reg_write_en_1;
    wire [31:0] imm_1;
    wire string_en_1;
//CORE-2=====================================================================================================================================
    reg clock_i_2=1'b0;
    wire [31:0] inst_i_2;
    wire [31:0] regs0_2;
    wire [31:0] regs1_2;
    wire [31:0] regs2_2;
    wire [31:0] regs3_2;
    wire [31:0] regs4_2;
    wire [31:0] regs5_2;
    wire [31:0] regs6_2;
    wire [31:0] regs7_2;
    wire [31:0] regs8_2;
    wire [31:0] regs9_2;
    wire [31:0] regs10_2;
    wire [31:0] regs11_2;
    wire [31:0] regs12_2;
    wire [31:0] regs13_2;
    wire [31:0] regs14_2;
    wire [31:0] regs15_2;
    wire [31:0] regs16_2;
    wire [31:0] regs17_2;
    wire [31:0] regs18_2;
    wire [31:0] regs19_2;
    wire [31:0] regs20_2;
    wire [31:0] regs21_2;
    wire [31:0] regs22_2;
    wire [31:0] regs23_2;
    wire [31:0] regs24_2;
    wire [31:0] regs25_2;
    wire [31:0] regs26_2;
    wire [31:0] regs27_2;
    wire [31:0] regs28_2;
    wire [31:0] regs29_2;
    wire [31:0] regs30_2;
    wire [31:0] regs31_2;
    wire [31:0] pc_o_2;
    wire [31:0] mem_addr_o_2;
    wire [31:0] mdata_i_2;
    wire [31:0] mdata_o_2;
    wire mem_en_o_2;
    wire [31:0] mem_addr_in_use_2;
    wire [31:0] mem_addr_in_use_value_2;
    wire branch_en_2;
    wire [31:0] alu_branch_2;
    wire [31:0] alu_out34_2;
    wire jump_en_2;
    wire fetchclock_2;
    wire [4:0] reg_add_2;
    wire [31:0] reg_data_2;
    wire reg_write_en_2;
    wire [31:0] imm_2;
    wire string_en_2;
//================================================
    
    assign regs=regs3_1;
    assign strings=regs29_2;
    integer counter1;
    integer counter2;
    always@(posedge clock)
    begin
        counter1=counter1+1;
        counter2=counter2+1;
        if(counter1==400000)
        begin
        clock_i_1=~clock_i_1;
        counter1=0;
       end
       if(counter2==9000000)
       begin
           clock_i_2=~clock_i_2;
           counter2=0;
      end
    end
   
    dlxpipeline dlx_core1(.clock(clock_i_1),.reset(reset_i),.pc(pc_o_1),.inst_in(inst_i_1),.memdata_in(mdata_i_1),
    
                    .memdata_out(mdata_o_1),.mem_addr(mem_addr_o_1),.mem_en(mem_en_o_1),.regs0(regs0_1),.regs1(regs1_1),.regs2(regs2_1),.regs3(regs3_1),.regs4(regs4_1),.regs5(regs5_1),.regs6(regs6_1),.regs7(regs7_1),.regs8(regs8_1),
                            .regs9(regs9_1),.regs10(regs10_1)
                            ,.regs11(regs11_1),.regs12(regs12_1),.regs13(regs13_1),.regs14(regs14_1),.regs15(regs15_1),.regs16(regs16_1),.regs17(regs17_1),.regs18(regs18_1),
                            .regs19(regs19_1),.regs20(regs20_1)
                            ,.regs21(regs21_1),.regs22(regs22_1),.regs23(regs23_1),.regs24(regs24_1),.regs25(regs25_1),.regs26(regs26_1),.regs27(regs27_1),.regs28(regs28_1),
                             .regs29(regs29_1),.regs30(regs30_1),.regs31(regs31_1),.branch_en(branch_en_1),.alu_branch(alu_branch_1),.alu_out34(alu_out34_1),.jump_en(jump_en_1),.fetchclock(fetchclock_1),.reg_add(reg_add_1),.reg_data(reg_data_1),.reg_write_en(reg_write_en_1),.imm(imm_1),.string_en(string_en_1));
                         
    RAM_BLOCK ram_core1(.adr_i(mem_addr_o_1),.clk_i(clock_i_1),.we_i(mem_en_o_1),.data_i(mdata_o_1),.data_o(mdata_i_1),.mem_addr_in_use(mem_addr_in_use_1),
                                    .mem_addr_in_use_value(mem_addr_in_use_value_1));
    
    ROM_BLOCK1 rom_core1(.reset_i(reset_i),.data_i(pc_o_1),.data_o(inst_i_1));
    
    dlxpipeline dlx_core2(.clock(clock_i_2),.reset(reset_i),.pc(pc_o_2),.inst_in(inst_i_2),.memdata_in(mdata_i_2),
        
                        .memdata_out(mdata_o_2),.mem_addr(mem_addr_o_2),.mem_en(mem_en_o_2),.regs0(regs0_2),.regs1(regs1_2),.regs2(regs2_2),.regs3(regs3_2),.regs4(regs4_2),.regs5(regs5_2),.regs6(regs6_2),.regs7(regs7_2),.regs8(regs8_2),
                                .regs9(regs9_2),.regs10(regs10_2)
                                ,.regs11(regs11_2),.regs12(regs12_2),.regs13(regs13_2),.regs14(regs14_2),.regs15(regs15_2),.regs16(regs16_2),.regs17(regs17_2),.regs18(regs18_2),
                                .regs19(regs19_2),.regs20(regs20_2)
                                ,.regs21(regs21_2),.regs22(regs22_2),.regs23(regs23_2),.regs24(regs24_2),.regs25(regs25_2),.regs26(regs26_2),.regs27(regs27_2),.regs28(regs28_2),
                                 .regs29(regs29_2),.regs30(regs30_2),.regs31(regs31_2),.branch_en(branch_en_2),.alu_branch(alu_branch_2),.alu_out34(alu_out34_2),.jump_en(jump_en_2),.fetchclock(fetchclock_2),.reg_add(reg_add_2),.reg_data(reg_data_2),.reg_write_en(reg_write_en_2),.imm(imm_2),.string_en(string_en_2));
                             
        RAM_BLOCK ram_core2(.adr_i(mem_addr_o_2),.clk_i(clock_i_2),.we_i(mem_en_o_2),.data_i(mdata_o_2),.data_o(mdata_i_2),.mem_addr_in_use(mem_addr_in_use_2),
                                        .mem_addr_in_use_value(mem_addr_in_use_value_2));
        
        ROM_BLOCK2 rom_core2(.reset_i(reset_i),.data_i(pc_o_2),.data_o(inst_i_2));
    
 
    
endmodule
