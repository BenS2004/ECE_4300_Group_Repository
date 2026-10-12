module fetch(
    input wire clk, rst, ex_mem_pc_src,
    input wire [31:0] ex_mem_npc,
    output wire [31:0] if_id_instr, if_id_npc
);

//internal
wire [31:0] pc_out, pc_mux, next_pc, instr_data;

mux m0 (.y(), .a_true(), .b_false(), .sel());

pc pc0(.pc_in(), .pc_out(), .clk());

incrementer in0(.clk(), .rst(), .pcin(), .pcout());

instrMem inMem0(.clk(), .rst(), .addr(), .data());

ifIdLatch ifIdLatch0(.clk(), .rst(), .pc_in(), .instr_in(), .pc_out(), .instr_out());

endmodule