module basic_cell(
    output reg Q,
    input wire CLK, CLR,
    input wire [1:0] S,
    input wire [3:0] Data
);
    
    wire D;
    assign D = Data[S];
    initial begin 
        Q <= 0;
    end
    always @(posedge CLK or negedge CLR)begin
        if(!CLR) begin
            Q = 0;
        end else begin
            Q = D;
        end
        
    end

endmodule