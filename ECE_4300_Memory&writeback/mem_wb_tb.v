`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2026 02:57:22 PM
// Design Name: 
// Module Name: mem_wb_tb
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

module mem_wb_tb();

    reg clk;
    reg [1:0] control_wb_in;
    reg [31:0] read_data_in, alu_result_in;
    reg [4:0] write_reg_in;

    wire regwrite, memtoreg;
    wire [31:0] read_data, mem_alu_result;
    wire [4:0] mem_write_reg;

    // Instantiate MEM/WB
    mem_wb uut (
        .clk(clk),
        .control_wb_in(control_wb_in),
        .read_data_in(read_data_in),
        .alu_result_in(alu_result_in),
        .write_reg_in(write_reg_in),
        .regwrite(regwrite),
        .memtoreg(memtoreg),
        .read_data(read_data),
        .mem_alu_result(mem_alu_result),
        .mem_write_reg(mem_write_reg)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial values
        control_wb_in = 2'b00;
        read_data_in = 32'h00000000;
        alu_result_in = 32'h00000000;
        write_reg_in = 5'd0;

        // TEST 1: Transfer control signals
        @(negedge clk);
        control_wb_in = 2'b11;

        // TEST 2: Transfer data and register number
        read_data_in = 32'h12345678;
        alu_result_in = 32'hABCDEF12;
        write_reg_in = 5'd10;

        @(posedge clk);
        #1;

        // TEST 3: Change inputs and verify next capture
        @(negedge clk);
        control_wb_in = 2'b01;
        read_data_in = 32'h11111111;
        alu_result_in = 32'h22222222;
        write_reg_in = 5'd5;

        @(posedge clk);
        #1;

        $finish;
    end

endmodule

