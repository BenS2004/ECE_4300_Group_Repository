module fetch_tb #(parameter WIDTH = 32)();

    reg clk, rwn, rst, ex_mem_pc_src;
    reg[WIDTH - 1:0] ex_mem_instr, ex_mem_npc;
    wire[WIDTH - 1:0] if_id_npc, data;

    assign data = rwn ? {WIDTH{1'BZ}} : ex_mem_instr;

    wire [WIDTH - 1:0] pc_out, pc_mux, next_pc, instr_data_mem, instr_data_latch;

    assign instr_data_mem = rwn ? data : {32{1'BZ}};

    assign instr_data_latch = rwn ? {32{1'B0}} : instr_data_mem;

    mux m0 (.y(pc_mux), .a_true(ex_mem_npc), .b_false(next_pc), .sel(ex_mem_pc_src));

    pc pc0(.pc_in(pc_mux), .pc_out(pc_out), .clk(clk));

    incrementer in0(.clk(clk), .rst(rst), .pc_in(pc_out), .pc_out(next_pc));

    instrMem inMem0(.clk(clk), .rst(rst), .rwn(rwn),  .addr(pc_out), .data(instr_data_mem));

    ifIdLatch ifIdLatch0(.clk(clk), .rst(rst), .pc_in(next_pc), .instr_in(instr_data_latch), .pc_out(if_id_npc), .instr_out(data));
/*
    fetch fetch0(.clk(clk), .rst(rst), .rwn(rwn), .ex_mem_pc_src(src),
                .ex_mem_npc(ex_mem_npc),
                .if_id_instr(data), .if_id_npc(if_id_npc));
*/
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer i;

    initial begin
        $dumpfile("fetchTestBenchWaveForm");
        $dumpvars(0, fetch_tb);
        rwn = 1;
        rst = 1;
        ex_mem_pc_src = 0;
        ex_mem_instr = 32'h0;
        ex_mem_npc = 32'h0;
        #10;
        rst = 0;
        rwn = 0;
        for(i = 0; i < 10; i = i + 1)begin
            ex_mem_instr = {(WIDTH/4){i[3:0]}};
            $display("Instr: %h, PC: %h", ex_mem_instr, if_id_npc);
            #10;
        end;
        rwn = 1;
        ex_mem_pc_src = 1;
        #10;
        ex_mem_pc_src = 0;
        for(i = 0; i < 10; i = i + 1)begin
            $display("Instr: %h, PC: %h", data, if_id_npc);
            #10;
        end
        $finish;
    end

endmodule