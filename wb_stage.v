module wb_stage(
input [31:0] wb_read_data,wb_alu_out,
input wb_reg_write,wb_mem_to_reg,

output [31:0] wb_write_data,
output wb_write_en
);



assign wb_write_data = (wb_mem_to_reg) ? wb_read_data : wb_alu_out;
assign wb_write_en   = wb_reg_write;

endmodule