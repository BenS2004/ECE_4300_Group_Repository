`timescale 1ns / 1ps

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

    // Memory Stage
    memory uut (
        .clk(clk),
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial values
        ALUResult = 32'h00000004;
        WriteData = 32'h12345678;
        WriteReg = 5'h02;
        WBControl = 2'b01;
        MemWrite = 0;
        MemRead = 1;
        Branch = 0;
        Zero = 0;

        // TEST 1: Memory Read
        #10;

        // TEST 2: Memory Write
        MemWrite = 1;
        MemRead = 0;

        #10; // Allow write to occur

        // TEST 3: Read After Write
        MemWrite = 0;
        MemRead = 1;

        #10; // Verify write by reading back

        // TEST 4: Branch
        Branch = 1;
        Zero = 1;

        #10; // Check PCSrc

        $finish;

    end

endmodule
