module ex_stage(
  input [31:0] alu_in1,alu_in2,
//  input [31:0] rd1,rd2,
  input [1:0] alu_op,
  input [6:0] funct7,
  input [2:0] funct3,
  input is_branch,
    input alu_src,              // ← ADD THIS
  input [31:0] ex_pc,
  input [31:0] ex_imm,
  output [31:0] alu_result,
  output [31:0] branch_target,
  output branch_taken
);

// wire alu_ctrl
wire [3:0] alu_ctrl;



alu_control ALU_ctrl(
.alu_op(alu_op),
.funct3(funct3),
.funct7(funct7),
.alu_ctrl(alu_ctrl)
);

// alu instantiate 
alu ALU(
.a(alu_in1),
.b(alu_in2),
.alu_ctrl(alu_ctrl),
.result(alu_result)
);


// branch logic here 
assign branch_taken=(is_branch)&&(alu_in1==alu_in2);
assign branch_target=ex_pc + ex_imm;

endmodule

