
module GPR( 
output wire [3:0]Q,
input wire [1:0]S,
input wire [3:0]D,
input wire CLR, CLK, L_in, R_in
);


        basic_cell cell3(.Q(Q[3]), .CLK(CLK), .CLR(CLR), .S(S), .Data({D[3], Q[2], R_in, Q[3]}));
        basic_cell cell2(.Q(Q[2]), .CLK(CLK), .CLR(CLR), .S(S), .Data({D[2], Q[1], Q[3],Q[2]}));
        basic_cell cell1(.Q(Q[1]), .CLK(CLK), .CLR(CLR), .S(S), .Data({D[1], Q[0], Q[2], Q[1]}));
        basic_cell cell0(.Q(Q[0]), .CLK(CLK), .CLR(CLR), .S(S), .Data({D[0], L_in, Q[1],Q[0]}));



endmodule