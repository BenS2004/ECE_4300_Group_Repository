`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2026 08:40:42 AM
// Design Name: 
// Module Name: and
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/*This bit-wise ANDs the branch and zero, indicating if a jump to an address is necessary.
The output, PCSrc, goes to mux.v from the Fetch Stage. If PCSrc is true, then there is a branch jump,
otherwise there is not.  
*/
module AND(
input wire membranch, zero,
output wire PCSrc
    );
assign PCSrc = membranch & zero;
endmodule

