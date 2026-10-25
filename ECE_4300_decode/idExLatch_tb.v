`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2026 01:38:38 PM
// Design Name: 
// Module Name: idExlatch_tb
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

module idExLatch_tb;

    reg clk, rst;

    reg [1:0]  ctl_wb;
    reg [2:0]  ctl_mem;
    reg [3:0]  ctl_ex;

    reg [31:0] npc;
    reg [31:0] readdat1;
    reg [31:0] readdat2;
    reg [31:0] sign_ext;

    reg [4:0] instr_bits_20_16;
    reg [4:0] instr_bits_15_11;

    wire [1:0]  wb_out;
    wire [2:0]  mem_out;
    wire [3:0]  ctl_out;

    wire [31:0] npc_out;
    wire [31:0] readdat1_out;
    wire [31:0] readdat2_out;
    wire [31:0] sign_ext_out;

    wire [4:0] instr_bits_20_16_out;
    wire [4:0] instr_bits_15_11_out;

    reg [146:0] expected;
    wire [146:0] actual;

    integer errors;

    assign actual = {
        wb_out,
        mem_out,
        ctl_out,
        npc_out,
        readdat1_out,
        readdat2_out,
        sign_ext_out,
        instr_bits_20_16_out,
        instr_bits_15_11_out
    };


    idExLatch dut (
        .clk(clk),
        .rst(rst),

        .ctl_wb(ctl_wb),
        .ctl_mem(ctl_mem),
        .ctl_ex(ctl_ex),

        .npc(npc),
        .readdat1(readdat1),
        .readdat2(readdat2),
        .sign_ext(sign_ext),

        .instr_bits_20_16(instr_bits_20_16),
        .instr_bits_15_11(instr_bits_15_11),

        .wb_out(wb_out),
        .mem_out(mem_out),
        .ctl_out(ctl_out),

        .npc_out(npc_out),
        .readdat1_out(readdat1_out),
        .readdat2_out(readdat2_out),
        .sign_ext_out(sign_ext_out),

        .instr_bits_20_16_out(instr_bits_20_16_out),
        .instr_bits_15_11_out(instr_bits_15_11_out)
    );

    always #5 clk = ~clk;


    task check_outputs;
        input [146:0] expected_value;
        input [8*40-1:0] test_name;
        begin
            if (actual !== expected_value) begin
                $display("FAIL: %0s at time %0t", test_name, $time);
                $display("Expected: %h", expected_value);
                $display("Actual:   %h", actual);
                errors = errors + 1;
            end
            else begin
                $display("PASS: %0s at time %0t", test_name, $time);
            end
        end
    endtask

    initial begin
        clk = 0;
        rst = 0;
        errors = 0;

        ctl_wb = 0;
        ctl_mem = 0;
        ctl_ex = 0;

        npc = 0;
        readdat1 = 0;
        readdat2 = 0;
        sign_ext = 0;

        instr_bits_20_16 = 0;
        instr_bits_15_11 = 0;

        expected = 0;




        #2 rst = 1;
        #1;
        check_outputs(expected, "Reset clears outputs");


        #2 rst = 0;


        @(posedge clk);
        #1;

        ctl_wb = 2'b10;
        ctl_mem = 3'b101;
        ctl_ex = 4'b1100;

        npc = 32'h00001004;
        readdat1 = 32'h12345678;
        readdat2 = 32'hABCDEF01;
        sign_ext = 32'hFFFF8000;

        instr_bits_20_16 = 5'd9;
        instr_bits_15_11 = 5'd17;


        #1;
        check_outputs(expected, "Hold before falling edge");

 
 
 
        @(negedge clk);
        #1;

        expected = {
            2'b10, 3'b101, 4'b1100,
            32'h00001004,
            32'h12345678,
            32'hABCDEF01,
            32'hFFFF8000,
            5'd9, 5'd17
        };

        check_outputs(expected, "Capture on falling edge");





        @(posedge clk);
        #1;

        ctl_wb = 2'b01;
        ctl_mem = 3'b010;
        ctl_ex = 4'b0011;

        npc = 32'h00002008;
        readdat1 = 32'h11111111;
        readdat2 = 32'h22222222;
        sign_ext = 32'h00007FFF;

        instr_bits_20_16 = 5'd4;
        instr_bits_15_11 = 5'd12;

        #1;
        check_outputs(expected, "Outputs hold between edges");




        @(negedge clk);
        #1;

        expected = {
            2'b01, 3'b010, 4'b0011,
            32'h00002008,
            32'h11111111,
            32'h22222222,
            32'h00007FFF,
            5'd4, 5'd12
        };

        check_outputs(expected, "Capture second data set");





        #1 rst = 1;
        expected = 147'b0;
        #1;

        check_outputs(expected, "Asynchronous reset");

        
        #2 rst = 0;

        if (errors == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

endmodule

