
`include "fetch"
//`include "ECE_4300_Group_Repository/ECE_4300_decode"
`include "ECE_4300_Group_Repository/ECE_4300_decode/idExLatch.v"
`include "ECE_4300_Group_Repository/ECE_4300_decode/signExtend.v"
`include "ECE_4300_Group_Repository/ECE_4300_decode/contol.v"
`include "ECE_4300_Group_Repository/ECE_4300_decode/regfile.v"


module pipe_tb #(parameter WIDTH = 32, parameter DEPTH = 12)();
    reg clk, rst, sel, regWrite;
    reg [4:0] writeReg;
    reg [WIDTH - 1:0] pc_input, writedata;
    wire[WIDTH - 1:0] data, pc_next, readdat1, readdat2, sign_ext;
    wire[1:0] ctl_wb;
    wire[2:0] ctl_mem;
    wire[3:0] ctl_ex

    //external outputs
    wire[1:0] wb_out;
    wire[2:0] mem_out;
    wire[3:0] ex_out;
    wire[WIDTH - 1:0] npc_out, readdat1_out, readdat2_out, sign_ext_out;
    wire[4:0] instr_bits_15_11_out, instr_bits_20_16_out;

    fetch f0(.clk(clk), .rst(rst), .ex_mem_pc_src(sel), .if_id_instr(data), 
        .if_id_npc(pc_next), .ex_mem_npc(pc_input));

    regfile rf0(.clk(clk), .rst(rst), .regWrite(regWrite), 
        .rs(data[25:21]), .rt(data[20:16]), .rd(writeReg), .writedata(writedata), 
        .A_readdat1(readdat1), .B_readdat2(readdat2));
    signExtend se0(.immediate(data[15:0]), .extended(sign_ext));
    control c0(.clk(clk), .rst(rst), .opcode(data[31:26]), .wb(ctl_wb), .mem(ctl_mem), .ex(ctl_ex));
    idExLatch iel0(.clk(clk), .rst(rst), .ctl_wb(ctl_wb), .ctl_mem(ctl_mem), .ctl_ex(ctl_ex),
        .npc(pc_next), .readdat1(readdat1), .readdat2(readdat2), .sign_ext(sign_ext), 
        .instr_bits_15_11(data[15:11]), .instr_bits_20_16(data[20:16]), 
        .wb_out(wb_out), .mem_out(mem_out), .ex_out(ex_out),
        .npc_out(npc_out), .readdat1_out(readdat1_out), .readdat2_out(readdat2_out), .sign_ext_out(sign_ext_out),
        .instr_bits_15_11_out(instr_bits_15_11_out), .instr_bits_20_16_out(instr_bits_20_16_out));
    
    
    
    initial forever #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("PipeTestBenchWaveForm");
        $dumpvars(0, pipe_tb);
        clk = 0;
        clk_latch = 0;
        rst = 1;
        sel = 1;
        regwrite = 0;
        writereg = 0;
        writedata = 32'h0;
        pc_input = 0;
        #10;
        rst = 0;
        #10;
        regwirte = 1;
        for(i = 0; i < 12; i = i + 1)begin
            pc_input = 0;
            writereg = i;
            writedata = {{16'h5a5a}, {4{i[3:0]}}};
            //$display("Before Tick Addr_in: %h, Instr_out: %h, Addr_out: %h", pc_input, data, pc_next);
            #10;
            sel = 0;
            Sdisplay("i = %h", i);
            $display("Addr_in: %h, Instr_out: %h, Addr_out: %h", pc_input, data, pc_next);
            $display("Write Reg: %d, Write Data: %h", writereg, writedata);
            $display("Next PC: %h, Read Data 1: %h, Read Data 2: %h, Sign Ext: %h", npc_out, readdat1_out, readdat2_out, sign_ext_out);
            $display("WriteBack: %b, Memory: %b, Execute: %b", wb_out, mem_out, ex_out)
            #display("Instr Bits 15-11: %b, Instr Bits 20-16: %b", instr_bits_15_11_out, instr_bits_20_16_out);
        end
        $finish;
    end

endmodule
