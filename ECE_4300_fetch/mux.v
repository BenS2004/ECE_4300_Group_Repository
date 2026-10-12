module mux #(parameter WIDTH = 32)(
    input wire[WIDTH - 1:0] a_true, b_false,
    input wire sel,
    output wire[WIDTH - 1:0] y
);

assign y = (a_true & {WIDTH{sel}}) | (b_false & {WIDTH{~sel}});

endmodule