module fetch_tb #(parameter WIDTH = 32)();
     
    reg clk, rst, sel;
    reg [WIDTH - 1:0] pc_input;
    wire [WIDTH - 1:0] data, pc_out_latch;


    fetch f0(.clk(clk), .rst(rst), .ex_mem_pc_src(sel), .if_id_instr(data), .if_id_npc(pc_out_latch), .ex_mem_npc(pc_input));
     
    initial forever #5 clk = ~clk;

    integer i;

    initial begin
        $dumpfile("FetchTestBenchWaveForm");
        $dumpvars(0, fetch_tb);
        clk = 0;
        rst = 1;
        sel = 1;
        pc_input = 0;
        #10;
        rst = 0;
        #10;
        for(i = 0; i < 12; i = i + 1)begin
            pc_input = 0;
            $display("Before Tick Addr_in: %h, Instr_out: %h, Addr_out: %h", pc_input, data, pc_out_latch);
            #10;
            sel = 0;
            $display("After  Tick Addr_in: %h, Instr_out: %h, Addr_out: %h", pc_input, data, pc_out_latch);
        end
        $finish;
    end
endmodule