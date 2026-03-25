module mem_wb_reg(
input clk, reset,
input [31:0] mem_read_data,mem_alu_out,
input mem_reg_write,mem_mem_to_reg,
input [4:0] mem_rd,
output reg [31:0] wb_read_data,wb_alu_out,
output reg  wb_reg_write,wb_mem_to_reg,
output reg [4:0] wb_rd
);

always @(posedge clk or posedge reset) begin
   if(reset) begin
       wb_reg_write<=1'b0;
       wb_mem_to_reg<=1'b0;
       wb_read_data<=32'b0;
       wb_alu_out<=32'b0;
       wb_rd<=5'b0;
       
       end
       else begin
       wb_reg_write<=mem_reg_write;
       wb_mem_to_reg<=mem_mem_to_reg;
       wb_read_data<=mem_read_data;
       wb_alu_out<=mem_alu_out;
       wb_rd<=mem_rd;
       
       
   end
end

endmodule