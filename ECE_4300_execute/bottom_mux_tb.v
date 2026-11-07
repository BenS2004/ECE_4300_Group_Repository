`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 04:39:55 PM
// Design Name: 
// Module Name: bottom_mux_tb
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

module bottom_mux_tb;


    reg [4:0] a;
    reg [4:0] b;
    reg sel;

    wire [4:0] y;


    bottom_mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin

        $display("Starting Bottom MUX Testbench...");
        $display("--------------------------------");

        // TEST 1: Select input a (RD)
        a = 5'b01010;
        b = 5'b00101;
        sel = 1'b1;
        #10;

        if (y !== a)
            $display("FAIL: TEST 1 - Expected %b, Got %b", a, y);
        else
            $display("PASS: TEST 1 - Input a selected");

        // TEST 2: Select input b (RT)
        sel = 1'b0;
        #10;

        if (y !== b)
            $display("FAIL: TEST 2 - Expected %b, Got %b", b, y);
        else
            $display("PASS: TEST 2 - Input b selected");

        // TEST 3: All zeros
        a = 5'b00000;
        b = 5'b00000;
        sel = 1'b1;
        #10;

        if (y !== 5'b00000)
            $display("FAIL: TEST 3 - Expected 00000, Got %b", y);
        else
            $display("PASS: TEST 3 - Zero inputs");

        // TEST 4: All ones
        a = 5'b11111;
        b = 5'b11111;
        sel = 1'b0;
        #10;

        if (y !== 5'b11111)
            $display("FAIL: TEST 4 - Expected 11111, Got %b", y);
        else
            $display("PASS: TEST 4 - All ones");

        // TEST 5: Maximum register address
        a = 5'b11111;
        b = 5'b00000;
        sel = 1'b1;
        #10;

        if (y !== 5'b11111)
            $display("FAIL: TEST 5 - Expected 11111, Got %b", y);
        else
            $display("PASS: TEST 5 - Maximum register address");

        // TEST 6: Different arbitrary register addresses
        a = 5'b10101;
        b = 5'b01010;
        sel = 1'b0;
        #10;

        if (y !== 5'b01010)
            $display("FAIL: TEST 6 - Expected 01010, Got %b", y);
        else
            $display("PASS: TEST 6 - Arbitrary register addresses");

        $display("--------------------------------");
        $display("Bottom MUX Testbench Completed!");

        $finish;
    end

endmodule
