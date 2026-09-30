
module GPR( 
output wire [3:0]Q,
input wire [1:0]S,
input wire [3:0]D,
input wire CLR, CLK, L_in, R_in
);


        basic_cell cell3(.Q(Q[3]), .CLK(CLK), .CLR(CLR), .S(S), .Data({Q[3], Q[2], L_in, D[3]}));
        basic_cell cell2(.Q(Q[2]), .CLK(CLK), .CLR(CLR), .S(S), .Data({Q[2], Q[1], Q[3], D[2]}));
        basic_cell cell1(.Q(Q[1]), .CLK(CLK), .CLR(CLR), .S(S), .Data({Q[1], Q[0], Q[2], D[1]}));
        basic_cell cell0(.Q(Q[0]), .CLK(CLK), .CLR(CLR), .S(S), .Data({Q[0], R_in, Q[1], D[0]}));



endmodule