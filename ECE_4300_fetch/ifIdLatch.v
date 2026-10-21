module ifIdLatch #(parameter WIDTH = 32)(
    input wire clk, rst,
    input wire[WIDTH - 1:0] pc_in, instr_in,
    output reg[WIDTH - 1:0] pc_out, instr_out
);

    always @(negedge clk or posedge rst)begin
        pc_out <= pc_in;
        instr_out <= instr_in;
        /*if(rst)begin
            pc_out = 32'h0;
            instr_out = 32'h0;
        end*/
    end

endmodule