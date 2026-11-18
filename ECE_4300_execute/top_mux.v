module top_mux #(parameter BITS = 32)(
output wire [BITS-1:0] y, //[BITS-1:0] y, Output of Multiplexer
input wire [BITS-1:0] a, //[BITS-1:0] a, Input 1 of Multiplexer 
input wire [BITS-1:0] b, // Input 0 of Multiplexer
input wire alusrc // Select Input
   );
   
   assign y = alusrc ? a : b;
endmodule // mux