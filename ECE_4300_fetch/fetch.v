module fetch(
    input wire clk, rst, ex_mem_pc_src, rwn, 
    input wire [31:0] ex_mem_npc,
    inout wire [31:0] if_id_instr,
    output wire [31:0] if_id_npc
);

//internal
wire [31:0] pc_out, pc_mux, next_pc, instr_data_mem, instr_data_latch, instr_data_out;

assign instr_data_mem = rwn ? {32{1'BZ}} : ex_mem_npc;

assign instr_data_latch = rwn ? instr_data_mem : {32{1'b0}};

assign instr_data_out = rwn ? if_id_instr : {32{1'BZ}};

mux m0 (.y(pc_mux), .a_true(ex_mem_npc), .b_false(next_pc), .sel(ex_mem_pc_src));

pc pc0(.pc_in(pc_mux), .pc_out(pc_out), .clk(clk));

incrementer in0(.clk(clk), .rst(rst), .pc_in(pc_out), .pc_out(next_pc));

instrMem inMem0(.clk(clk), .rst(rst), .rwn(rwn),  .addr(pc_out), .data(instr_data_mem));

ifIdLatch ifIdLatch0(.clk(clk), .rst(rst), .pc_in(next_pc), .instr_in(instr_data_latch), .pc_out(if_id_npc), .instr_out(instr_data_out));

endmodule