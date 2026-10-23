module idExLatch_tb();

    reg clk, rst;
    reg[1:0] ctl_wb;
    reg[2:0] ctl_mem;
    reg[3:0] ctl_ex;
    reg[31:0] npc, readdat1, readdat2, sign_ext;
    reg[4:0] instr_bits_15_11, instr_bits_20_16;

    wire[1:0] wb_out;
    wire[2:0] mem_out;
    wire[3:0] ex_out;
    wire[31:0] npc_out, readdat1_out, readdat2_out, sign_ext_out;
    wire[4:0] instr_bits_15_11_out, instr_bits_20_16_out;

    idExLatch latch0(.clk(clk), .rst(rst), .ctl_wb(ctl_wb), .ctl_mem(ctl_mem), .ctl_ex(ctl_ex),
        .npc(npc), .readdat1(readdat1), .readdat2(readdat2), .sign_ext(sign_ext), 
        .instr_bits_15_11(instr_bits_15_11), .instr_bits_20_16(instr_bits_20_16), 
        .wb_out(wb_out), .mem_out(mem_out), .ex_out(ex_out), 
        .npc_out(npc_out), .readdat1_out(readdat1_out), .readdat2_out(readdat2_out), .sign_ext_out(sign_ext_out),
        .instr_bits_15_11_out(instr_bits_15_11_out), .instr_bits_20_16_out(instr_bits_20_16_out));
    
    integer i;

    initial forever #5 clk = ~clk;

    initial begin
        $dumpfile("IdExLatchTestBenchWaveForm");
        $dumpvars(0, idExLatch_tb);
        clk = 0;
        rst = 0;
        ctl_wb = 2'b01;
        ctl_mem = 3'b010;
        ctl_ex = 4'b1010;
        npc = 32'h0;
        readdat1 = 32'h0;
        readdat2 = 32'h0;
        sign_ext = 32'h0;
        instr_bits_15_11 = 5'h0;
        instr_bits_20_16 = 5'h0;
        #10;
        $display("wb_out: %b, mem_out: %b, ex_out: %b", wb_out, mem_out, ex_out);
        $display("npc_out: %h, readdat1_out: %h, readdat2_out: %h, sign_ext_out: %h", npc_out, readdat1_out, readdat2_out, sign_ext_out);
        $display("instr_bits_15_11_out: %b, instr_bits_20_16_out: %b", instr_bits_15_11_out, instr_bits_20_16_out );
        for(i = 0; i < 10; i = i + 1)begin
            ctl_wb = i[1:0];
            ctl_mem = i[2:0];
            ctl_ex = i[3:0];
            npc = i;
            readdat1 = {8{i[3:0]}};
            readdat2 = {8{i[2:0],i[3]}};
            sign_ext = {{16{i[3]}},{4{i[3:0]}}};
            instr_bits_15_11 = i[4:0];
            instr_bits_20_16 = {i[0], i[4:1]};
            #10;
            $display("wb_out: %b, mem_out: %b, ex_out: %b", wb_out, mem_out, ex_out);
            $display("npc_out: %h, readdat1_out: %h, readdat2_out: %h, sign_ext_out: %h", npc_out, readdat1_out, readdat2_out, sign_ext_out);
            $display("instr_bits_15_11_out: %b, instr_bits_20_16_out: %b", instr_bits_15_11_out, instr_bits_20_16_out );
        end
        $finish;
    end

endmodule