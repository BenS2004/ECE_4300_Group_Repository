module instrMem_tb #(parameter WIDTH = 32, parameter DEPTH = 12)();
    
    reg clk, rst;
    reg [WIDTH - 1:0] addr;
    wire[WIDTH - 1:0] data;


    instrMem Mem0(.clk(clk), .rst(rst),
        .addr(addr), .data(data));
    
    initial forever #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("InstrMemTestBenchWaveForm");
        $dumpvars(0, instrMem_tb);
        clk = 0;
        rst = 1;
        addr = 0;
        #10;
        rst = 0;
        #10;
        for(i = 0; i < 12; i = i + 1)begin
            addr = i;
            #10;
            $display("Data: %h", data);
        end
        $finish;
    end

endmodule