module instrMem #(parameter WIDTH = 32, parameter DEPTH = 11)(
    input wire clk, rst, rwn,
    input wire[WIDTH - 1:0] addr,
    inout wire[WIDTH - 1:0] data
);

    reg[WIDTH - 1:0] sel_ins;
    assign data = rwn ? sel_ins : {WIDTH{1'BZ}};

    reg[WIDTH - 1:0] instructions [{DEPTH{1'b1}} : 0];
    integer j;

    always @(posedge clk or posedge rst)begin
        if(rst)begin
            for(j = 0; j < {DEPTH{1'b1}}; j = j + 1)begin
                instructions[j] = 32'h0;
            end
        end else if(!rwn) begin
            instructions[addr[11:0]] = data;
        end
        sel_ins = instructions[addr[11:0]];
    end

endmodule