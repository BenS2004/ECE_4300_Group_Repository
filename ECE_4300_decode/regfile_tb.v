module regfile_tb #(parameter WIDTH = 32)();

reg clk, rst, regwrite;
reg[4:0] rd, rs, rt;
reg[WIDTH - 1:0] writedata;
wire[WIDTH - 1:0] A_readdat1, B_readdat2;

regfile rf0(.clk(clk), .rst(rst), .regwrite(regwrite),
    .rd(rd), .rs(rs), .rt(rt), .writedata(writedata), 
    .A_readdat1(A_readdat1), .B_readdat2(B_readdat2));

initial forever #5 clk = ~clk;

integer j;

initial begin
    $dumpfile("RegFileTestBenchWaveForm");
    $dumpvars(0, regfile_tb);
    clk = 0;
    regwrite = 0;
    writedata = 0;
    rst = 1;
    rd = 0;
    rs = 0;
    rt = 0;
    #10;
    rst = 0; //read and write data
    regwrite = 1;
    for(j = 0; j < WIDTH; j = j + 1)begin
        writedata = {{4{4'ha}}, {2{j[7:0]}}};
        rd <= j;
        rs <= j;
        rt <= ((WIDTH + j - 1) % WIDTH);
        #10;
        $display("WriteDate: %h, rd: %h, rs: %h, rt: %h, read_A: %h, read_B: %h", writedata, rd, rs, rt, A_readdat1, B_readdat2);
    end
    regwrite = 0;
    writedata = 0;
    for(j = 0; j < WIDTH; j = j + 1)begin
        //writedata = {{4{4'ha}}, {2{j[7:0]}}};
        rd <= j;
        rs <= j;
        rt <= ((WIDTH + j - 1) % WIDTH);
        #10;
        $display("WriteDate: %h, rd: %h, rs: %h, rt: %h, read_A: %h, read_B: %h", writedata, rd, rs, rt, A_readdat1, B_readdat2);
    end

    $finish;
end

endmodule