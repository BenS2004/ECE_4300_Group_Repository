module pc #(parameter WIDTH = 32)(
    input wire[WIDTH - 1:0] pc_in,
    input wire clk,
    output wire[WIDTH - 1:0] pc_out
)

    //internal
    reg[WIDTH - 1:0] pc;
    assign pc_out = pc;
    always @ (posedge clk) begin
        pc = pc_in;
    end

endmodule