`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 04:53:10 PM
// Design Name: 
// Module Name: alu_tb
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

module alu_tb;

    // Testbench inputs
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] control;

    // Testbench outputs
    wire [31:0] result;
    wire zero;

    // Test counters
    integer pass_count;
    integer fail_count;

    // Instantiate Unit Under Test (UUT)
    alu uut (
        .a(a),
        .b(b),
        .control(control),
        .result(result),
        .zero(zero)
    );

    // Task to check expected results
    task check_result;
        input [31:0] expected_result;
        input expected_zero;
        input integer test_num;

        begin
            #10;

            if ((result !== expected_result) ||
                (zero !== expected_zero)) begin

                $display("FAIL: TEST %0d", test_num);
                $display("Expected result: %h | Actual: %h",
                         expected_result, result);
                $display("Expected zero: %b | Actual: %b",
                         expected_zero, zero);

                fail_count = fail_count + 1;
            end

            else begin
                $display("PASS: TEST %0d | Result: %h | Zero: %b",
                         test_num, result, zero);

                pass_count = pass_count + 1;
            end
        end
    endtask

    initial begin

        pass_count = 0;
        fail_count = 0;

        $display("--------------------------------");
        $display("Starting ALU Testbench");
        $display("--------------------------------");

        // TEST 1: ADD
        a = 32'd10;
        b = 32'd20;
        control = 3'b010;

        check_result(32'd30, 1'b0, 1);

        // TEST 2: ADD - Result should be zero
        a = 32'd0;
        b = 32'd0;
        control = 3'b010;

        check_result(32'd0, 1'b1, 2);

        // TEST 3: SUB
        a = 32'd30;
        b = 32'd10;
        control = 3'b110;

        check_result(32'd20, 1'b0, 3);

        // TEST 4: SUB - Equal operands
        a = 32'd15;
        b = 32'd15;
        control = 3'b110;

        check_result(32'd0, 1'b1, 4);

        // TEST 5: AND
        a = 32'hAAAAAAAA;
        b = 32'h55555555;
        control = 3'b000;

        check_result(32'h00000000, 1'b1, 5);

        // TEST 6: OR
        a = 32'hAAAAAAAA;
        b = 32'h55555555;
        control = 3'b001;

        check_result(32'hFFFFFFFF, 1'b0, 6);

        // TEST 7: SLT - Positive comparison (true)
        a = 32'd5;
        b = 32'd10;
        control = 3'b111;

        check_result(32'd1, 1'b0, 7);

        // TEST 8: SLT - Positive comparison (false)
        a = 32'd15;
        b = 32'd10;
        control = 3'b111;

        check_result(32'd0, 1'b1, 8);

        // TEST 9: SLT - Negative number < Positive number
        a = -32'sd5;
        b = 32'd3;
        control = 3'b111;

        check_result(32'd1, 1'b0, 9);

        // TEST 10: SLT - Positive number > Negative number
        a = 32'd5;
        b = -32'sd3;
        control = 3'b111;

        check_result(32'd0, 1'b1, 10);

        // TEST 11: SLT - Two negative numbers
        a = -32'sd10;
        b = -32'sd5;
        control = 3'b111;

        check_result(32'd1, 1'b0, 11);

        // TEST 12: ADD - Overflow boundary
        a = 32'h7FFFFFFF;
        b = 32'd1;
        control = 3'b010;

        check_result(32'h80000000, 1'b0, 12);

        // TEST 13: Invalid ALU control
        a = 32'd10;
        b = 32'd20;
        control = 3'b011;

        #10;

        if ((result !== 32'bx) || (zero !== 1'bx)) begin
            $display("FAIL: TEST 13 - Invalid control");
            $display("Expected X values, Got result=%h zero=%b",
                     result, zero);
            fail_count = fail_count + 1;
        end
        else begin
            $display("PASS: TEST 13 - Invalid control");
            pass_count = pass_count + 1;
        end

        // Final summary
        $display("--------------------------------");
        $display("ALU TESTBENCH SUMMARY");
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