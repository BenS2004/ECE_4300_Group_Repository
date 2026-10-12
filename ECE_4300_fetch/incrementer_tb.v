module incrementer_tb #(parameter WIDTH = 32)();

    reg clk, rst;
    reg[WIDTH - 1:0] pc_input;
    wire[WIDTH - 1:0] pc_output;

    incrementer in0(
        .clk(clk), .rst(rst), .pc_in(pc_input),
        .pc_out(pc_output)
    );

    initial forever #5 clk = ~clk;

    initial begin
        $dumpfile("IncrementerTestBenchWaveForm");
        $dumpvars(0, incrementer_tb);
        clk = 0;
        rst = 0;
        pc_input = {8{4'b1011}};
        #10;
        rst = 1;
        #20;
        pc_input = pc_output;
        #10;
        pc_input = pc_output;
        #10
        pc_input = pc_output;
        #10;
        $finish;
    end

endmodule