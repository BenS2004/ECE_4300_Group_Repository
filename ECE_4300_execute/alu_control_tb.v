`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 05:00:48 PM
// Design Name: 
// Module Name: alu_control_tb
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

module alu_control_tb;


    reg [5:0] funct;
    reg [1:0] aluop;

  
    wire [2:0] select;

  
    integer pass_count;
    integer fail_count;


    alu_control uut (
        .funct(funct),
        .aluop(aluop),
        .select(select)
    );


    task check_result;
        input [1:0] test_aluop;
        input [5:0] test_funct;
        input [2:0] expected_select;
        input integer test_num;

        begin
            aluop = test_aluop;
            funct = test_funct;

            #10;

            if (select !== expected_select) begin

                $display("FAIL: TEST %0d", test_num);
                $display("ALUOp: %b | Funct: %b",
                         aluop, funct);
                $display("Expected: %b | Actual: %b",
                         expected_select, select);

                fail_count = fail_count + 1;
            end

            else begin

                $display("PASS: TEST %0d | ALUOp: %b | Funct: %b | Select: %b",
                         test_num, aluop, funct, select);

                pass_count = pass_count + 1;

            end
        end
    endtask

    initial begin

        pass_count = 0;
        fail_count = 0;

        $display("--------------------------------");
        $display("Starting ALU CONTROL Testbench");
        $display("--------------------------------");

        // TEST 1: R-type ADD
        check_result(2'b10, 6'b100000, 3'b010, 1);

        // TEST 2: R-type SUB
        check_result(2'b10, 6'b100010, 3'b110, 2);

        // TEST 3: R-type AND
        check_result(2'b10, 6'b100100, 3'b000, 3);

        // TEST 4: R-type OR
        check_result(2'b10, 6'b100101, 3'b001, 4);

        // TEST 5: R-type SLT
        check_result(2'b10, 6'b101010, 3'b111, 5);

        // TEST 6: LW/SW - ADD
        check_result(2'b00, 6'bXXXXXX, 3'b010, 6);

        // TEST 7: BEQ - SUB
        check_result(2'b01, 6'bXXXXXX, 3'b110, 7);

        // TEST 8: Invalid ALUOp
        check_result(2'b11, 6'bXXXXXX, 3'b011, 8);

        // TEST 9: Unsupported R-type function
        check_result(2'b10, 6'b111111, 3'b011, 9);

        // TEST 10: Verify funct is ignored for LW/SW
        check_result(2'b00, 6'b101010, 3'b010, 10);

        // Final summary
        $display("--------------------------------");
        $display("ALU CONTROL TESTBENCH SUMMARY");
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