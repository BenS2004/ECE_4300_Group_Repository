`include "ECE_4300_decode/decode.v"
`include "ECE_4300_fetch/fetch.v"
`include "ECE_4300_execute/execute.v"

/*`include "ECE_4300_execute/adder.v"
`include "ECE_4300_execute/alu_control.v"
`include "ECE_4300_execute/alu.v"
`include "ECE_4300_execute/bottom_mux.v"
`include "ECE_4300_execute/top_mux.v"
`include "ECE_4300_execute/ex_mem.v"*/

module execute_tb();

    //external inputs
    reg clk, rst, ex_mem_pc_src, wb_reg_write;
    reg [4:0] wb_write_reg_location;
    reg[31:0] mem_wb_write_data;

    //internal wires
    wire[31:0] if_id_instr, if_id_npc;

    wire[1:0] id_ex_wb;
    wire[2:0] id_ex_mem;
    wire[3:0] id_ex_execute;
    wire[4:0] id_ex_instr_bits_15_11, id_ex_instr_bits_20_16;
    wire[31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;

    //external outputs
    wire ex_mem_branch, memread, memwrite, zero;
    wire[1:0] wb_ctlout;
    wire[31:0] ex_mem_npc, ex_mem_alu_result, ex_mem_rdata2out;
    wire[4:0] ex_mem_five_bit_muxout;




    fetch f0(.clk(clk), .rst(rst), .ex_mem_pc_src(ex_mem_pc_src),
        .ex_mem_npc(ex_mem_npc), .if_id_instr(if_id_instr), .if_id_npc(if_id_npc));
    
    decode d0(.clk(clk), .rst(rst), .wb_reg_write(wb_reg_write), 
        .wb_write_reg_location(wb_write_reg_location), 
        .mem_wb_write_data(mem_wb_write_data), 
        .if_id_instr(if_id_instr), .if_id_npc(if_id_npc), 
        .id_ex_wb(id_ex_wb), .id_ex_mem(id_ex_mem), .id_ex_execute(id_ex_execute),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11), .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_npc(id_ex_npc), .id_ex_readdat1(id_ex_readdat1), .id_ex_readdat2(id_ex_readdat2), 
        .id_ex_sign_ext(id_ex_sign_ext));

    execute e0(.clk(clk), .wb_ctl(id_ex_wb), .m_ctl(id_ex_mem), 
    .regdst(id_ex_execute[3]), .aluop(id_ex_execute[2:1]), .alusrc(id_ex_execute[0]),
    .npcout(id_ex_npc), .rdata1(id_ex_readdat1), .rdata2(id_ex_readdat2), .s_extendout(id_ex_sign_ext), 
    .instrout_2016(id_ex_instr_bits_20_16), .instrout_1511(id_ex_instr_bits_15_11), 
    .branch(ex_mem_branch), .memread(memread), .memwrite(memwrite), .zero(zero), 
    .wb_ctlout(wb_ctlout), .EX_MEM_NPC(ex_mem_npc), .alu_result(ex_mem_alu_result), .rdata2out(ex_mem_rdata2out),
    .five_bit_muxout(ex_mem_five_bit_muxout));


    

    integer i;

    initial forever #5 clk = ~clk;

    initial begin
        $dumpfile("ECE_4300_execute/DecodeTestBenchWaveForm");
        $dumpvars(0, execute_tb);
        clk = 0;
        rst = 0;
        ex_mem_pc_src = 0;
        wb_reg_write = 0;
        wb_write_reg_location = 5'h0;
        mem_wb_write_data = 32'h0;
        #10;
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 13; i = i + 1)begin
            $display("i = %h", i);
            $display("Ext Mem Pc: %h, If Id Instr: %h, If Id NPc: %h", ex_mem_npc, if_id_instr, if_id_npc);
            $display("Write Reg: %d, Write Data: %h", wb_write_reg_location, mem_wb_write_data);
            $display("Next PC: %h, Read Data 1: %h, Read Data 2: %h, Sign Ext: %h", id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext);
            $display("WriteBack: %b, Memory: %b, Execute: %b", id_ex_wb, id_ex_mem, id_ex_execute);
            $display("Instr Bits 15-11: %b, Instr Bits 20-16: %b", id_ex_instr_bits_15_11, id_ex_instr_bits_20_16);
            $display("Branch: %b, Memread: %b, Memwrite: %b, Zero: %b", ex_mem_branch, memread, memwrite, zero);
            $display("Next PC: %h, Result: %h, Read Data 2: %h", ex_mem_npc, ex_mem_alu_result, ex_mem_rdata2out);
            $display("Writeback Control: %b, Mux Result: %b", wb_ctlout, ex_mem_five_bit_muxout);
            #10;

        end
        $finish;

    end


endmodule