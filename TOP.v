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


module TOP(clock_i,reset_i,regs);
input clock_i;
input reset_i;
output [1:0]regs;

    wire clock_i;
    wire reset_i;
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
    wire mem_en_o;
    wire [31:0] mem_addr_in_use;
    wire [31:0] mem_addr_in_use_value;
    wire branch_en;
    wire [31:0] alu_branch;
    wire [31:0] alu_out34;
    wire jump_en;
    wire fetchclock;
    wire [4:0] reg_add;
    wire [31:0] reg_data;
    wire reg_write_en;
    wire [31:0] imm;
    assign regs=regs3;
    dlxpipeline lzy(.clock(clock_i),.reset(reset_i),.pc(pc_o),.inst_in(inst_i),.memdata_in(mdata_i),
    
                    .memdata_out(mdata_o),.mem_addr(mem_addr_o),.mem_en(mem_en_o),.regs1(regs1),.regs2(regs2),.regs3(regs3),.regs4(regs4),.regs5(regs5),.regs6(regs6),.regs7(regs7),.regs8(regs8),
                            .regs9(regs9),.regs10(regs10)
                            ,.regs11(regs11),.regs12(regs12),.regs13(regs13),.regs14(regs14),.regs15(regs15),.regs16(regs16),.regs17(regs17),.regs18(regs18),
                            .regs19(regs19),.regs20(regs20)
                            ,.regs21(regs21),.regs22(regs22),.regs23(regs23),.regs24(regs24),.regs25(regs25),.regs26(regs26),.regs27(regs27),.regs28(regs28),
                             .regs29(regs29),.regs30(regs30),.regs31(regs31),.branch_en(branch_en),.alu_branch(alu_branch),.alu_out34(alu_out34),.jump_en(jump_en),.fetchclock(fetchclock),.reg_add(reg_add),.reg_data(reg_data),.reg_write_en(reg_write_en),.imm(imm));
                         
    RAM_BLOCK ram(.adr_i(mem_addr_o),.clk_i(clock_i),.we_i(mem_en_o),.data_i(mdata_o),.data_o(mdata_i),.mem_addr_in_use(mem_addr_in_use),
                                    .mem_addr_in_use_value(mem_addr_in_use_value));
    
    ROM_BLOCK rom(.reset_i(reset_i),.data_i(pc_o),.data_o(inst_i));
 
    
endmodule
