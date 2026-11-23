`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2026 02:31:53 PM
// Design Name: 
// Module Name: data_memory_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 1ps

module data_memory_tb();

    // Inputs
    reg clk;
    reg [31:0] addr;
    reg [31:0] write_data;
    reg memread, memwrite;

    // Output
    wire [31:0] read_data;

    // Instantiate Data Memory
    data_memory uut (
        .clk(clk),
        .addr(addr),
        .write_data(write_data),
        .memread(memread),
        .memwrite(memwrite),
        .read_data(read_data)
    );

    // Clock Generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial Values
        addr = 32'd4;
        write_data = 32'h12345678;
        memread = 0;
        memwrite = 0;

        #2;

        // =================================
        // TEST 1: INITIAL MEMORY READ
        // =================================

        $display("--------------------------------");
        $display("TEST 1: INITIAL MEMORY READ");
        $display("--------------------------------");

        memread = 1;
        #1;

        $display("Address:    %h", addr);
        $display("Memory Index: %d", addr[9:2]);
        $display("Expected:   00000001");
        $display("Actual:     %h", read_data);

        if (read_data === 32'h00000001)
            $display("PASS: Initial Memory Read");
        else
            $display("FAIL: Initial Memory Read");


        // =================================
        // TEST 2: MEMORY WRITE
        // =================================

        $display("\n--------------------------------");
        $display("TEST 2: MEMORY WRITE");
        $display("--------------------------------");

        @(negedge clk);

        memread = 0;
        memwrite = 1;

        @(posedge clk);
        #1;

        $display("Address:    %h", addr);
        $display("Write Data: %h", write_data);
        $display("Expected:   12345678");
        $display("Actual:     %h", uut.DMEM[1]);

        if (uut.DMEM[1] === 32'h12345678)
            $display("PASS: Memory Write");
        else
            $display("FAIL: Memory Write");


        // =================================
        // TEST 3: READ AFTER WRITE
        // =================================

        $display("\n--------------------------------");
        $display("TEST 3: READ AFTER WRITE");
        $display("--------------------------------");

        memwrite = 0;
        memread = 1;

        #1;

        $display("Expected:   12345678");
        $display("Actual:     %h", read_data);

        if (read_data === 32'h12345678)
            $display("PASS: Read After Write");
        else
            $display("FAIL: Read After Write");


        // =================================
        // FINISH SIMULATION
        // =================================

        $display("\n--------------------------------");
        $display("DATA MEMORY TESTING COMPLETE");
        $display("--------------------------------");

        $finish;

    end

endmodule

