`timescale 1ns / 1ps
/* Memory Stage: This uses the outputs of Execute Stage as well as combining the modules: and, data_memory, and mem_wb.
*/
module memory_tb();
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0] WriteReg;
    reg [1:0] WBControl;
    reg MemWrite, MemRead, Branch, Zero;
wire [31:0] ReadData, ALUResult_out;
wire [4:0] WriteReg_out;

wire MEM_WB_regwrite;
wire MEM_WB_memtoreg;
wire MEM_PCSrc;

memory uut (
    .wb_ctlout(WBControl),
    .branch(Branch),
    .memread(MemRead),
    .memwrite(MemWrite),
    .zero(Zero),
    .alu_result(ALUResult),
    .rdata2out(WriteData),
    .five_bit_muxout(WriteReg),

    // Outputs
    .MEM_PCSrc(MEM_PCSrc),
    .MEM_WB_regwrite(MEM_WB_regwrite),
    .MEM_WB_memtoreg(MEM_WB_memtoreg),
    .read_data(ReadData),
    .mem_alu_result(ALUResult_out),
    .mem_write_reg(WriteReg_out)
);

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
     // Mem Read
    ALUResult = 32'h00000004;
    WriteData = 32'h12345678;
    WriteReg = 5'h02;
    WBControl = 2'b01;
    MemWrite = 0;
    MemRead = 1;
    Branch = 0;
    Zero = 0;

    #10; 

    // Mem Write
    MemWrite = 1;
    MemRead = 0;
    #10; // Allow write to occur
    MemWrite = 0;
    MemRead = 1;
    #10; // Verify write by reading back

    // Branch
    Branch = 1;
    Zero = 1;
    #10; // Check PCSrc

    $finish;
end
endmodule
