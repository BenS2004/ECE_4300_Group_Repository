module mux_tb #(parameter WIDTH = 32)();

    reg[WIDTH - 1:0] in_a, in_b;
    reg select;
    wire[WIDTH - 1:0] out_y;

    mux m0(.y(out_y), .sel(select), .a_true(in_a), .b_false(in_b));

    initial begin
        $dumpfile("MuxTestBenchWaveForm.vcd");
        $dumpvars(0, mux_tb);
        in_a = {8{4'b0110}};
        in_b = {8{4'b1010}};
        select = 0;
        #10;
        select = 1;
        #10;
        $finish;
    end

endmodule