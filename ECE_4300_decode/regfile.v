module regfile #(parameter WIDTH = 32, parameter DEPTH = 32)(
        input wire clk, rst, regwrite,
        input wire[4:0] rs, rt, rd, 
        input wire[WIDTH - 1:0] writedata,
        output wire[WIDTH - 1:0] A_readdat1, B_readdat2
    );

    // registers 
    reg[WIDTH - 1:0] registers [DEPTH - 1:0];

    assign A_readdat1 = registers[rs];
    assign B_readdat2 = registers[rt];

    integer i;

    initial begin
        $readmemh("ECE_4300_decode/reg_init.hex", registers, 0, 31);
    end

    /*initial begin
        for(i = 0; i < WIDTH; i = i + 1)begin
            registers[i] <= 32'h0;
        end
    end */

    always @(posedge clk) begin
        if(regwrite) registers[rd] = writedata;
        registers[0] = 0;
    end

endmodule