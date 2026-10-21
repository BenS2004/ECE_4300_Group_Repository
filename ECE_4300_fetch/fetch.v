module fetch(
    input wire clk, rst, ex_mem_pc_src, 
    input wire [31:0] ex_mem_npc,
    output wire [31:0] if_id_instr,
    output wire [31:0] if_id_npc
);

//internal
wire [31:0] pc_out, pc_mux, next_pc, instr_data, mem_addr;

//assign pc_mux = ex_mem_pc_src ? ex_mem_npc : next_pc;

mux m0 (.y(pc_mux), .a_true(ex_mem_npc), .b_false(next_pc), .sel(ex_mem_pc_src));

pc pc0(.pc_in(pc_mux), .pc_out(pc_out), .clk(clk));

incrementer in0(.clk(clk), .rst(rst), .pc_in(pc_out), .pc_out(next_pc));

instrMem inMem0(.clk(clk), .rst(rst), .addr(pc_out), .data(instr_data));

assign if_id_npc = next_pc;
assign if_id_instr = instr_data;

//ifIdLatch ifIdLatch0(.clk(clk), .rst(rst), .pc_in(next_pc), .instr_in(instr_data), .pc_out(if_id_npc), .instr_out(if_id_instr));

endmodule