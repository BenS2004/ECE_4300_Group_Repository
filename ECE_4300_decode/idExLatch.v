module idExLatch #(parameter WIDTH = 32)(
    input wire clk, rst, 
    input wire [1:0] ctl_wb,
    input wire [2:0] ctl_mem, 
    input wire [3:0] ctl_ex, 
    input wire [WIDTH - 1:0] npc, readdat1, readdat2, sign_ext,
    input wire [4:0] instr_bits_15_11, instr_bits_20_16,
    output reg [1:0] wb_out,
    output reg [2:0] mem_out,
    output reg [3:0] ex_out,
    output reg [WIDTH - 1:0] npc_out, readdat1_out, readdat2_out, sign_ext_out,
    output reg [4:0] instr_bits_15_11_out, instr_bits_20_16_out
);

    initial begin
        wb_out <= 2'h0;
        mem_out <= 3'h0;
        ex_out <= 4'h0;
        npc_out <= 32'h0;
        readdat1_out <= 32'h0;
        readdat2_out <= 32'h0;
        sign_ext_out <= 32'h0;
        instr_bits_15_11_out <= 5'h0;
        instr_bits_20_16_out <= 5'h0;
    end

    always @(posedge rst) begin
        wb_out <= 2'h0;
        mem_out <= 3'h0;
        ex_out <= 4'h0;
        npc_out <= 32'h0;
        readdat1_out <= 32'h0;
        readdat2_out <= 32'h0;
        sign_ext_out <= 32'h0;
        instr_bits_15_11_out <= 5'h0;
        instr_bits_20_16_out <= 5'h0;
    end

    always @(negedge clk) begin
        wb_out <= ctl_wb;
        mem_out <= ctl_mem;
        ex_out <= ctl_ex;
        npc_out <= npc;
        readdat1_out <= readdat1;
        readdat2_out <= readdat2;
        sign_ext_out <= sign_ext;
        instr_bits_15_11_out <= instr_bits_15_11;
        instr_bits_20_16_out <= instr_bits_20_16;
    end

endmodule