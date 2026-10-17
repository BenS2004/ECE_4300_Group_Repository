module pc #(parameter WIDTH = 32)(
    input wire[WIDTH - 1:0] pc_in,
    input wire clk,
    output wire[WIDTH - 1:0] pc_out
);

    //internal
    reg[WIDTH - 1:0] pc_int;
    assign pc_out = pc_int;
    always @ (posedge clk) begin
        pc_int = pc_in;
    end

endmodule