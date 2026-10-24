module control(
    input wire clk, rst,
    input wire[5:0] opcode,
    output reg[1:0] wb,
    output reg[2:0] mem,
    output reg[3:0] ex
);

initial begin
    wb <= 0;
    mem <= 0;
    ex <= 0;
end

always @(posedge rst) begin
    wb <= 0;
    mem <= 0;
    ex <= 0;
end

always @(*) begin
    case(opcode) 
        6'h00: begin //R-Type
            wb <= 2'h2;
            mem <= 3'h0;
            ex <= 4'hc;
        end
        6'h04:begin //beq
            wb <= 2'b0x;
            mem <= 3'h4;
            ex <= 4'bx010;
        end
        6'h23:begin //lw
            wb <= 2'h3;
            mem <= 3'h2;
            ex <= 4'h1;
        end
        6'h2b:begin //sw
            wb <= 2'b0x;
            mem <= 3'h1;
            ex <= 4'bx001;
        end
        default:begin
            wb <= 2'bxx;
            mem <= 3'bxx;
            ex <= 4'bxxxx;
        end
    endcase
end

endmodule