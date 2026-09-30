module GPR_sim();
    reg [3:0] D;
    reg [1:0] S;
    reg L_in, R_in, CLK, CLR;
    wire[3:0] Q;

    GPR dut(.Q(Q), .S(S), .D(D), .CLR(CLR), .CLK(CLK), .L_in(L_in), .R_in(R_in));

    initial forever #5 CLK = ~CLK;

    initial begin
        $dumpfile("TestBenchWaveForm.vcd");
        $dumpvars(0, GPR_sim);
        S = 0;
        D = 4'b1100;
        CLR = 0;
        CLK = 0;
        L_in = 0;
        R_in = 0;
        #5 CLR = 1;
        #10 S = 2'd3;
        #10 S = 2'd1;
        #10 S = 2'd2;
        #10 S = 1; L_in = 1;
        #10 S = 2; R_in = 1;
        #10 $finish;
    end
endmodule