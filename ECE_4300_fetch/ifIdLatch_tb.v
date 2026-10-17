module ifIdLatch_tb #(parameter WIDTH = 32)();

    reg clk, rst;
    reg[WIDTH - 1:0] instr_in, pc_in;
    wire[WIDTH - 1:0] instr_out, pc_out;

    ifIdLatch latch0(.clk(clk), .rst(rst), 
            .instr_in(instr_in), .instr_out(instr_out),
            .pc_in(pc_in), .pc_out(pc_out));

    initial begin
        clk = 0; 
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("ifIdLatchTestBenchWaveForm");
        $dumpvars(0, ifIdLatch_tb);
        rst = 1;
        pc_in = {4{8'haa}};
        instr_in = {4{8'h66}};
        #10;
        rst = 0;
        #10;
        pc_in = pc_in << 1;
        instr_in = instr_in << 1;
        #10
        pc_in = pc_in << 1;
        instr_in = instr_in << 1;
        #10
        $finish;
    end


endmodule