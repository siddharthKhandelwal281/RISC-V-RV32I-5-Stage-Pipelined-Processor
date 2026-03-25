module ex_mem_reg(
input clk,reset,
input [31:0] ex_alu_result,ex_rd2,
input ex_mem_read,ex_mem_write,ex_reg_write,ex_mem_to_reg,
input [4:0] ex_rd,

output reg [31:0] mem_alu_result,mem_rd2,
output reg mem_mem_read,mem_mem_write,mem_reg_write,mem_mem_to_reg,
output reg [4:0] mem_rd
);

  always @(posedge clk or posedge reset) begin
       if(reset) begin
           mem_alu_result<=32'b0;
           mem_rd2<=32'b0;
           mem_rd<=5'b0;
           mem_mem_read<=1'b0;
           mem_mem_write<=1'b0;
           mem_reg_write<=1'b0;
           mem_mem_to_reg<=1'b0;
       end
       else begin
           mem_alu_result<=ex_alu_result;
           mem_rd2<=ex_rd2;
           mem_rd<=ex_rd;
           mem_mem_read<=ex_mem_read;
           mem_mem_write<=ex_mem_write;
           mem_reg_write<=ex_reg_write;
           mem_mem_to_reg<=ex_mem_to_reg;
       end
   
  end
endmodule