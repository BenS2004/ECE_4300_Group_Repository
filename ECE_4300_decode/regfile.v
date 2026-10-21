module regfile #(parameter WIDTH = 32, parameter DEPTH = 32)(
        input wire clk, rst, regwrite,
        input wire[4:0] rs, rt, rd, 
        input wire[WIDTH - 1:0] writedata, 
        //output reg[WIDTH - 1:0] A_readdat1, B_readdat2
        output wire[WIDTH - 1:0] A_readdat1, B_readdat2
    );

    // registers 
    reg[WIDTH - 1:0] registers [DEPTH - 1:0];

    assign A_readdat1 = registers[rs];
    assign B_readdat2 = registers[rt];

    integer i;
    initial begin
        for(i = 0; i < WIDTH; i = i + 1)begin
            registers[i] <= 32'h0;
        end
        //A_readdat1 <= 32'h0;
        //B_readdat2 <= 32'h0;
    end

    always @(posedge clk) begin
        if(regwrite) registers[rd] = writedata;
        registers[0] = 0;
    end

    /*
    always @(negedge clk) begin
        A_readdat1 = registers[rs];
        B_readdat2 = registers[rt];
    end
    */

endmodule