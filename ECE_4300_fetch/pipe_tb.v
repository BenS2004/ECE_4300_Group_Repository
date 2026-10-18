module pipe_tb #(parameter WIDTH = 32, parameter DEPTH = 12)();
    reg clk, rst, rwn, sel;
    reg [WIDTH - 1:0] data_in, pc_input;
    wire[WIDTH - 1:0] data, instr_input, instr_output, pc_next, pc_output, pc_out_latch, addr;

    assign data = rwn ? {WIDTH{1'BZ}} : data_in;
    //mux m1(.sel(rwn), .y(data), .a_true({WIDTH{1'BZ}}), .b_false(data_in));

    assign instr_input = rwn ? data : {WIDTH{1'B0}};
    //mux m2(.sel(rwn), .y(instr_input), .a_true(data), .b_false({WIDTH{1'B0}}));
    
    //mux m0(.sel(sel), .y(addr), .a_true(pc_input), .b_false(pc_next));
    assign addr = sel ? pc_input : pc_next;

    instrMem Mem0(.clk(clk), .rst(rst), .rwn(rwn),
        .addr(pc_output), .data(data));
    
    ifIdLatch Latch0(.clk(clk), .rst(rst), .pc_in(pc_next), .pc_out(pc_out_latch),
        .instr_in(instr_input), .instr_out(instr_output));

    pc programcounter(.pc_in(addr), .pc_out(pc_output), .clk(clk));

    incrementer inc0(.clk(clk), .rst(rst), .pc_in(pc_output), .pc_out(pc_next));
    
    initial forever #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("PipeTestBenchWaveForm");
        $dumpvars(0, pipe_tb);
        clk = 0;
        rst = 1;
        rwn = 1;
        sel = 1;
        pc_input = 0;
        #20;
        rst = 0;
        #10;
        rwn = 0;
        for(i = 0; i < 10; i = i + 1)begin
            pc_input = i;
            data_in = {(WIDTH/4){i[3:0]}};
            $display("Before Tick Data: %h, Instr_in: %h, Instr_out: %h, Addr: %h, PC_input: %h, PC_output: %h, PC_next: %h, Latch_output: %h", data, instr_input, instr_output, addr, pc_input, pc_output, pc_next, pc_out_latch);
            #10;
            $display("After  Tick Data: %h, Instr_in: %h, Instr_out: %h, Addr: %h, PC_input: %h, PC_output: %h, PC_next: %h, Latch_output: %h", data, instr_input, instr_output, addr, pc_input, pc_output, pc_next, pc_out_latch);

        end
        rwn = 1;
        sel = 1;
        #10;
        for(i = 0; i < 12; i = i + 1)begin
            pc_input = 0;
            $display("Before Tick Data: %h, Instr_in: %h, Instr_out: %h, Addr: %h, PC_input: %h, PC_output: %h, PC_next: %h, Latch_output: %h", data, instr_input, instr_output, addr, pc_input, pc_output, pc_next, pc_out_latch);            
            #10;
            sel = 0;
            $display("After  Tick Data: %h, Instr_in: %h, Instr_out: %h, Addr: %h, PC_input: %h, PC_output: %h, PC_next: %h, Latch_output: %h", data, instr_input, instr_output, addr, pc_input, pc_output, pc_next, pc_out_latch);            
        end
        $finish;
    end

endmodule
