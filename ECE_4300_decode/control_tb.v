module control_tb();

reg clk, rst;
reg[5:0] opcode;
wire[1:0] wb;
wire[2:0] mem;
wire[3:0] ex;

control c0(.clk(clk), .rst(rst), .opcode(opcode), .wb(wb), .mem(mem), .ex(ex));

initial forever #5 clk = ~clk;

initial begin
    $dumpfile("ControlTestBenchWaveForm");
    $dumpvars(0, control_tb);
    clk = 0;
    rst = 0;
    opcode = 6'h00;
    #10;
    $display("Opcode: %b, WriteBack: %b, Memory: %b, Execute: %b", opcode, wb, mem, ex);
    opcode = 6'h23;
    #10;
    $display("Opcode: %b, WriteBack: %b, Memory: %b, Execute: %b", opcode, wb, mem, ex);
    opcode = 6'h2b;
    #10;
    $display("Opcode: %b, WriteBack: %b, Memory: %b, Execute: %b", opcode, wb, mem, ex);
    opcode = 6'h02;
    #10;
    $display("Opcode: %b, WriteBack: %b, Memory: %b, Execute: %b", opcode, wb, mem, ex);
    opcode = 6'h35;
    #10;
    $display("Opcode: %b, WriteBack: %b, Memory: %b, Execute: %b", opcode, wb, mem, ex);
    $finish;

end

endmodule