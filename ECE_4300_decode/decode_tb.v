
`include "ECE_4300_decode/decode.v"
`include "ECE_4300_fetch/fetch.v"

module decode_tb();

    //external inputs
    reg clk, rst, ex_mem_pc_src, wb_reg_write;
    reg [4:0] wb_write_reg_location;
    reg[31:0] ex_mem_npc, mem_wb_write_data;

    //internal wires
    wire[31:0] if_id_instr, if_id_npc;

    //external outputs
    wire[1:0] id_ex_wb;
    wire[2:0] id_ex_mem;
    wire[3:0] id_ex_execute;
    wire[4:0] id_ex_instr_bits_15_11, id_ex_instr_bits_20_16;
    wire[31:0] id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;

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

    integer i;

    initial forever #5 clk = ~clk;

    initial begin
        $dumpfile("ECE_4300_decode/DecodeTestBenchWaveForm");
        $dumpvars(0, decode_tb);
        clk = 0;
        rst = 0;
        ex_mem_npc = 32'h0;
        ex_mem_pc_src = 0;
        wb_reg_write = 0;
        wb_write_reg_location = 5'h0;
        mem_wb_write_data = 32'h0;
        #10;
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 12; i = i + 1)begin
            $display("i = %h", i);
            $display("Ext Mem Pc: %h, If Id Instr: %h, If Id NPc: %h", ex_mem_npc, if_id_instr, if_id_npc);
            $display("Write Reg: %d, Write Data: %h", wb_write_reg_location, mem_wb_write_data);
            $display("Next PC: %h, Read Data 1: %h, Read Data 2: %h, Sign Ext: %h", id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext);
            $display("WriteBack: %b, Memory: %b, Execute: %b", id_ex_wb, id_ex_mem, id_ex_execute);
            $display("Instr Bits 15-11: %b, Instr Bits 20-16: %b", id_ex_instr_bits_15_11, id_ex_instr_bits_20_16);
            #10;

        end
        $finish;

    end


endmodule