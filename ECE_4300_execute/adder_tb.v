`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 05:07:34 PM
// Design Name: 
// Module Name: adder_tb
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

module adder_tb;

 
    reg [31:0] add_in1;
    reg [31:0] add_in2;


    wire [31:0] add_out;


    integer pass_count;
    integer fail_count;

  
    adder uut (
        .add_in1(add_in1),
        .add_in2(add_in2),
        .add_out(add_out)
    );


    task check_result;
        input [31:0] input1;
        input [31:0] input2;
        input [31:0] expected;
        input integer test_num;

        begin
            add_in1 = input1;
            add_in2 = input2;

            #10;

            if (add_out !== expected) begin

                $display("FAIL: TEST %0d", test_num);
                $display("Input 1: %h | Input 2: %h",
                         input1, input2);
                $display("Expected: %h | Actual: %h",
                         expected, add_out);

                fail_count = fail_count + 1;

            end

            else begin

                $display("PASS: TEST %0d | %h + %h = %h",
                         test_num, input1, input2, add_out);

                pass_count = pass_count + 1;

            end
        end
    endtask

    initial begin

        pass_count = 0;
        fail_count = 0;

        $display("--------------------------------");
        $display("Starting ADDER Testbench");
        $display("--------------------------------");

        // TEST 1: Basic addition
        check_result(32'd10, 32'd20, 32'd30, 1);

        // TEST 2: Zero inputs
        check_result(32'd0, 32'd0, 32'd0, 2);

        // TEST 3: Addition with zero
        check_result(32'd100, 32'd0, 32'd100, 3);

        // TEST 4: Larger decimal values
        check_result(32'd100, 32'd200, 32'd300, 4);

        // TEST 5: Maximum 32-bit value + 1
        check_result(32'hFFFFFFFF, 32'd1, 32'h00000000, 5);

        // TEST 6: Signed overflow boundary
        check_result(32'h7FFFFFFF, 32'd1, 32'h80000000, 6);

        // TEST 7: Two large hexadecimal values
        check_result(32'hAAAAAAAA, 32'h55555555,
                     32'hFFFFFFFF, 7);

        // TEST 8: Carry propagation
        check_result(32'h000000FF, 32'h00000001,
                     32'h00000100, 8);

        // TEST 9: Multiple carry propagation
        check_result(32'h0000FFFF, 32'h00000001,
                     32'h00010000, 9);

        // TEST 10: Arbitrary values
        check_result(32'h12345678, 32'h11111111,
                     32'h23456789, 10);

        // Final summary
        $display("--------------------------------");
        $display("ADDER TESTBENCH SUMMARY");
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