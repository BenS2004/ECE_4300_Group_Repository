`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 05:15:45 PM
// Design Name: 
// Module Name: ex_mem_tb
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

module ex_mem_tb;

  
    reg aluzero;
    reg clk;

    reg [1:0] ctlwb_out;
    reg [2:0] ctlm_out;
    reg [4:0] muxout;

    reg [31:0] adder_out;
    reg [31:0] aluout;
    reg [31:0] readdat2;


    wire [1:0] wb_ctlout;
    wire zero, branch, memread, memwrite;

    wire [31:0] add_result;
    wire [31:0] alu_result;
    wire [31:0] rdata2out;

    wire [4:0] five_bit_muxout;


    integer pass_count;
    integer fail_count;


    ex_mem uut (
        .aluzero(aluzero),
        .clk(clk),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .muxout(muxout),
        .adder_out(adder_out),
        .aluout(aluout),
        .readdat2(readdat2),

        .wb_ctlout(wb_ctlout),
        .zero(zero),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .add_result(add_result),
        .alu_result(alu_result),
        .rdata2out(rdata2out),
        .five_bit_muxout(five_bit_muxout)
    );

  
    always #5 clk = ~clk;

    
    task check_result;
        input [1:0] test_wb;
        input [2:0] test_mem;
        input test_zero;
        input [31:0] test_adder;
        input [31:0] test_alu;
        input [31:0] test_data;
        input [4:0] test_mux;
        input integer test_num;

        begin

     
            @(negedge clk);

            ctlwb_out = test_wb;
            ctlm_out = test_mem;
            aluzero = test_zero;
            adder_out = test_adder;
            aluout = test_alu;
            readdat2 = test_data;
            muxout = test_mux;

 
            @(posedge clk);
            #1;

   
            if (
                (wb_ctlout !== test_wb) ||
                (branch !== test_mem[2]) ||
                (memread !== test_mem[1]) ||
                (memwrite !== test_mem[0]) ||
                (zero !== test_zero) ||
                (add_result !== test_adder) ||
                (alu_result !== test_alu) ||
                (rdata2out !== test_data) ||
                (five_bit_muxout !== test_mux)
            ) begin

                $display("FAIL: TEST %0d", test_num);

                $display("WB Control: Expected %b, Got %b",
                         test_wb, wb_ctlout);

                $display("Branch: Expected %b, Got %b",
                         test_mem[2], branch);

                $display("MemRead: Expected %b, Got %b",
                         test_mem[1], memread);

                $display("MemWrite: Expected %b, Got %b",
                         test_mem[0], memwrite);

                $display("Zero: Expected %b, Got %b",
                         test_zero, zero);

                $display("Adder: Expected %h, Got %h",
                         test_adder, add_result);

                $display("ALU: Expected %h, Got %h",
                         test_alu, alu_result);

                $display("Read Data: Expected %h, Got %h",
                         test_data, rdata2out);

                $display("MUX: Expected %b, Got %b",
                         test_mux, five_bit_muxout);

                fail_count = fail_count + 1;

            end

            else begin

                $display("PASS: TEST %0d - All outputs updated correctly",
                         test_num);

                pass_count = pass_count + 1;

            end

        end
    endtask

    initial begin

        // Initialize inputs
        clk = 0;

        aluzero = 0;
        ctlwb_out = 0;
        ctlm_out = 0;
        muxout = 0;

        adder_out = 0;
        aluout = 0;
        readdat2 = 0;

        pass_count = 0;
        fail_count = 0;

        $display("--------------------------------");
        $display("Starting EX/MEM Testbench");
        $display("--------------------------------");

        // TEST 1: Verify initial values
        #1;

        if (
            (wb_ctlout !== 2'b00) ||
            (branch !== 1'b0) ||
            (memread !== 1'b0) ||
            (memwrite !== 1'b0) ||
            (zero !== 1'b0) ||
            (add_result !== 32'b0) ||
            (alu_result !== 32'b0) ||
            (rdata2out !== 32'b0) ||
            (five_bit_muxout !== 5'b0)
        ) begin

            $display("FAIL: TEST 1 - Initial values");
            fail_count = fail_count + 1;

        end

        else begin

            $display("PASS: TEST 1 - Initial values");
            pass_count = pass_count + 1;

        end

        // TEST 2: Normal data transfer
        check_result(
            2'b01, 3'b001, 1'b0,
            32'h00000010,
            32'h00000020,
            32'h00000030,
            5'b01010, 2
        );

        // TEST 3: Branch and MemRead control
        check_result(
            2'b10, 3'b110, 1'b1,
            32'h12345678,
            32'h87654321,
            32'hAAAAAAAA,
            5'b10101, 3
        );

        // TEST 4: All memory control bits enabled
        check_result(
            2'b11, 3'b111, 1'b0,
            32'hFFFFFFFF,
            32'h00000001,
            32'h55555555,
            5'b11111, 4
        );

        // TEST 5: All memory control bits disabled
        check_result(
            2'b00, 3'b000, 1'b1,
            32'h00000000,
            32'hFFFFFFFF,
            32'h12345678,
            5'b00000, 5
        );

        // TEST 6: Different data patterns
        check_result(
            2'b01, 3'b101, 1'b1,
            32'h7FFFFFFF,
            32'h80000000,
            32'hDEADBEEF,
            5'b11001, 6
        );

        // TEST 7: Verify outputs hold between clock edges
        // Save the previous output values.
        // Change inputs without allowing a positive clock edge.

        @(negedge clk);

        ctlwb_out = 2'b10;
        ctlm_out = 3'b010;
        aluzero = 1'b0;
        adder_out = 32'hAAAAAAAA;
        aluout = 32'hBBBBBBBB;
        readdat2 = 32'hCCCCCCCC;
        muxout = 5'b00111;

        #2;

        if (
            (wb_ctlout !== 2'b01) ||
            (branch !== 1'b1) ||
            (memread !== 1'b0) ||
            (memwrite !== 1'b1) ||
            (zero !== 1'b1) ||
            (add_result !== 32'h7FFFFFFF) ||
            (alu_result !== 32'h80000000) ||
            (rdata2out !== 32'hDEADBEEF) ||
            (five_bit_muxout !== 5'b11001)
        ) begin

            $display("FAIL: TEST 7 - Outputs did not hold previous values");
            fail_count = fail_count + 1;

        end

        else begin

            $display("PASS: TEST 7 - Outputs hold between clock edges");
            pass_count = pass_count + 1;

        end

        // Final summary
        $display("--------------------------------");
        $display("EX/MEM TESTBENCH SUMMARY");
        $display("Passed: %0d", pass_count);
        $display("Failed: %0d", fail_count);
        $display("--------------------------------");

        if (fail_count == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("SOME TESTS FAILED!");

        $finish;

    end

endmodule
