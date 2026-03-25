module id_ex_reg(
  input clk,
  input reset,
  
  input [4:0] id_rs1,id_rs2,
  input [1:0] id_alu_op,
  input [2:0] id_funct3,
  input [6:0] id_funct7,
  input [31:0] id_rd1,id_rd2,
  input id_mem_read,id_mem_write,id_reg_write,id_mem_to_reg,
  input [4:0] id_rd,
  input id_ex_flush,
  input id_is_branch,
  input [31:0] id_pc_plus4,
  input [31:0] id_imm,
  input id_alu_src,
  input [31:0] id_pc,
  output reg [31:0] ex_pc_plus4,
  output reg [4:0] ex_rs1,ex_rs2,
  output reg [1:0] ex_alu_op,
  output reg [2:0] ex_funct3,
  output reg [6:0] ex_funct7,
  output reg [31:0] ex_rd1,ex_rd2,
  output reg ex_mem_read,ex_mem_write,ex_reg_write,ex_mem_to_reg,
  output reg [4:0] ex_rd,
  output reg ex_is_branch,
  output reg [31:0] ex_imm,
  output reg ex_alu_src,
  output reg [31:0] ex_pc

);

always @(posedge clk or posedge reset) begin
    if(reset) begin
          ex_rs1<=5'b0;
          ex_rs2<=5'b0;
          ex_alu_op<=2'b0;
          ex_funct3<=3'b0;
          ex_funct7<=7'b0;
          ex_rd1<=32'b0;
          ex_rd2<=32'b0;
          ex_rd<=5'b0;
          ex_is_branch<=1'b0;
          ex_pc_plus4<=32'b0;
          
          // control signals 
          ex_mem_read<=1'b0;
          ex_mem_write<=1'b0;
          ex_reg_write<=1'b0;
          ex_mem_to_reg<=1'b0;
          ex_imm<=32'b0;
          ex_alu_src<=1'b0;
          ex_pc<=32'b0;
    end
    else if (id_ex_flush) begin
    
          ex_rs1<=5'b0;
          ex_rs2<=5'b0;
          ex_alu_op<=2'b0;
          ex_funct3<=3'b0;
          ex_funct7<=7'b0;
          ex_rd1<=32'b0;
          ex_rd2<=32'b0;
          ex_rd<=5'b0;
          ex_is_branch<=1'b0;
          ex_pc_plus4<=32'b0;

          
          // control signals 
          ex_mem_read<=1'b0;
          ex_mem_write<=1'b0;
          ex_reg_write<=1'b0;
          ex_mem_to_reg<=1'b0;
          ex_imm<=32'b0;    
          ex_alu_src<=1'b0;
          ex_pc<=32'b0;


    end
    else begin
       ex_alu_op<=id_alu_op;
          ex_funct3<=id_funct3;
          ex_funct7<=id_funct7;
          ex_rd1<=id_rd1;
          ex_rd2<=id_rd2;
          ex_rd<=id_rd;
          ex_rs1<=id_rs1;
          ex_rs2<=id_rs2;
          ex_is_branch<=id_is_branch;
          ex_pc_plus4<=id_pc_plus4;

          //assign control signals 
          ex_mem_read<=id_mem_read;
          ex_mem_write<=id_mem_write;
          ex_reg_write<=id_reg_write;
          ex_mem_to_reg<=id_mem_to_reg;
          ex_imm<=id_imm;
          ex_alu_src <= id_alu_src;
          ex_pc<=id_pc;
    end
end
endmodule