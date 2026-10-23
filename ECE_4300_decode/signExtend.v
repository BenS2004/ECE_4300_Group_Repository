module signExtend #(parameter WIDTH = 32)(
    input wire [(WIDTH / 2) - 1:0] immediate,
    output wire [WIDTH - 1:0] extended
);

    assign extended = { {(WIDTH / 2){immediate[15]}}, immediate[15:0]};

endmodule