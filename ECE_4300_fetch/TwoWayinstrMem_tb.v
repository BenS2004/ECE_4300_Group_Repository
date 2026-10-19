module TwoWayinstrMem_tb #(parameter WIDTH = 32, parameter DEPTH = 12)();
    
    reg clk, rst, rwn;
    reg [WIDTH - 1:0] addr, data_in;
    wire[WIDTH - 1:0] data;

    assign data = rwn ? {WIDTH{1'BZ}} : data_in;

    instrMem Mem0(.clk(clk), .rst(rst), .rwn(rwn),
        .addr(addr), .data(data));
    
    initial forever #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("InstrMemTestBenchWaveForm");
        $dumpvars(0, instrMem_tb);
        clk = 0;
        rst = 1;
        rwn = 1;
        addr = 0;
        #10;
        rst = 0;
        #10;
        rwn = 0;
        for(i = 0; i < 10; i = i + 1)begin
            addr = i;
            data_in = {(WIDTH/4){i[3:0]}};
            #10;
            $display("Data: %h", data);
        end
        rwn = 1;
        #10;
        for(i = 0; i < 12; i = i + 1)begin
            addr = i;
            #10;
            $display("Data: %h", data);
        end
        $finish;
    end

endmodule