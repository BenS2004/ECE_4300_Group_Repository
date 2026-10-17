module ifIdLatch #(parameter WIDTH = 32)(
    input wire clk, rst,
    input wire[WIDTH - 1:0] pc_in, instr_in,
    output wire[WIDTH - 1:0] pc_out, instr_out
);

    reg[WIDTH - 1:0] pc_int, instr_int;
    assign pc_out = pc_int;
    assign instr_out = instr_int;

    always @(posedge clk or posedge rst)begin
        if(rst) begin
            pc_int = 32'h0;
            instr_int = 32'h0;
        end else begin
            pc_int = pc_in;
            instr_int = instr_in;
        end
    end

endmodule