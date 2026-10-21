module pipe_tb #(parameter WIDTH = 32, parameter DEPTH = 12)();
    reg clk, rst, sel, clk_latch;
    reg [WIDTH - 1:0] pc_input;
    wire[WIDTH - 1:0] data, pc_next, instr_output, pc_out_latch;
    
    ifIdLatch Latch0(.clk(clk), .rst(rst), .pc_in(pc_next), .pc_out(pc_out_latch),
        .instr_in(data), .instr_out(instr_output));

    fetch f0(.clk(clk), .rst(rst), .ex_mem_pc_src(sel), .if_id_instr(data), 
        .if_id_npc(pc_next), .ex_mem_npc(pc_input));
    
    initial forever #5 clk = ~clk;
    initial forever #5 clk_latch = ~clk_latch;

    integer i;

    initial begin
        $dumpfile("PipeTestBenchWaveForm");
        $dumpvars(0, pipe_tb);
        clk = 0;
        clk_latch = 0;
        rst = 1;
        sel = 1;
        pc_input = 0;
        #10;
        rst = 0;
        #10;
        for(i = 0; i < 12; i = i + 1)begin
            pc_input = 0;
            $display("Before Tick Addr_in: %h, Instr_out: %h, Addr_out: %h, Latch_Instr: %h, Latch_Addr: %h", pc_input, data, pc_next, instr_output, pc_out_latch);
            #10;
            sel = 0;
            $display("After  Tick Addr_in: %h, Instr_out: %h, Addr_out: %h, Latch_Instr: %h, Latch_Addr: %h", pc_input, data, pc_next, instr_output, pc_out_latch);
        end
        $finish;
    end

endmodule
