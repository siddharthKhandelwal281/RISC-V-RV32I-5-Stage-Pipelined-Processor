module mem_stage(
input clk,
input [31:0] mem_alu_result,mem_rd2,
input mem_mem_write,mem_mem_read,mem_reg_write,mem_mem_to_reg,

output [31:0] mem_alu_out,mem_read_data,
output wb_reg_write,wb_mem_to_reg
);


data_mem memory(
.clk(clk),
.mem_read(mem_mem_read),
.mem_write(mem_mem_write),
.addr(mem_alu_result),
.write_data(mem_rd2),
.read_data(mem_read_data)
);

// forward signals
assign mem_alu_out=mem_alu_result;
assign wb_reg_write=mem_reg_write;
assign wb_mem_to_reg=mem_mem_to_reg;

endmodule