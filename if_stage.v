module if_stage(
   input branch_taken,
   input [31:0] pc_current,branch_target,
   output [31:0] pc_next,pc_plus4,instr_addr
);

 assign pc_plus4=pc_current+32'd4;
assign pc_next = branch_taken ? branch_target : pc_plus4;
 assign instr_addr=pc_current;
 
 
endmodule 