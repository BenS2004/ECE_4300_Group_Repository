module incrementer #(parameter WIDTH = 32)(
    input wire clk, rst,
    input wire[WIDTH - 1:0] pc_in,
    output wire[WIDTH - 1:0] pc_out
);

    reg[WIDTH - 1:0] pc;
    assign pc_out = pc;

    always @(*)begin
        pc = pc_in + 1'b1;
    end

    always @(posedge rst)begin
        pc = 32'b0;
    end

endmodule