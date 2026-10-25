module instrMem #(parameter WIDTH = 32, parameter DEPTH = 11)(
    input wire clk, rst,
    input wire[WIDTH - 1:0] addr,
    output reg[WIDTH - 1:0] data
);

    reg[WIDTH - 1:0] sel_ins;

    reg[WIDTH - 1:0] instructions [{DEPTH{1'b1}} : 0];
    integer j;

    always @(posedge rst)begin
        $readmemh("ECE_4300_fetch/memory_init.hex", instructions, 0, 10);
        //$readmemh("memory_init.hex", instructions);
    end

    always @(*)begin
        data = instructions[addr[11:0]];
    end

endmodule