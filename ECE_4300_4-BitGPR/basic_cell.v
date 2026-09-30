module basic_cell(
    output reg Q,
    input wire CLK, CLR,
    input wire [1:0] S,
    input wire [3:0] Data
);

    initial begin 
        Q <= 0;
    end
    always @(posedge CLK)begin
        if(!CLR) begin
        Q = 0;
        end else begin
            case(S)
                2'b00: Q = Data[0];
                2'b01: Q = Data[1];
                2'b10: Q = Data[2];
                2'b11: Q = Data[3];
            endcase
        end
        
    end

endmodule