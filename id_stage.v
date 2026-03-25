module id_stage(
input [31:0] instr,
input clk,wb_we,
input [4:0] wb_rd,
input [31:0] wb_wd,
output [6:0] opcode,
output [4:0] rs1,rs2,rd,
output [2:0] funct3,
output [6:0] funct7,
output [31:0] rd1,rd2,
output [31:0] imm,
output reg_write,mem_read,mem_write,mem_to_reg,is_branch,
output [1:0] alu_op,
output alu_src
);

// instiantiate regfile 
regfile reg_file(
.clk(clk),
.we(wb_we),
.rs1(rs1),
.rs2(rs2),
.rd(wb_rd),
.wd(wb_wd),
.rd1(rd1),
.rd2(rd2)
);

assign opcode=instr[6:0];
assign rs1=instr[19:15];
assign rs2=instr[24:20];
assign rd=instr[11:7];
assign funct3=instr[14:12];
assign funct7=instr[31:25];


// cu 
control_unit CU(
.opcode(opcode),
.mem_to_reg(mem_to_reg),
.mem_read(mem_read),
.mem_write(mem_write),
.reg_write(reg_write),
.is_branch(is_branch),
.alu_src(alu_src),
.alu_op(alu_op)
);

// immediate generator 
wire [31:0] imm_i;
wire [31:0] imm_s;
wire [31:0] imm_b;
wire [31:0] imm_u;
wire [31:0] imm_j;

assign imm_i = {{20{instr[31]}}, instr[31:20]};
assign imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};

assign imm_b = {
    {20{instr[31]}},   // sign extend
    instr[7],          // bit 11
    instr[30:25],      // bits 10:5
    instr[11:8],       // bits 4:1
    1'b0               // bit 0
};
assign imm_u = {instr[31:12], 12'b0};
assign imm_j = {{11{instr[31]}}, instr[31],
                instr[19:12], instr[20],
                instr[30:21], 1'b0};

assign imm =
    (opcode == 7'b0010011) ? imm_i :
    (opcode == 7'b0000011) ? imm_i :
    (opcode == 7'b0100011) ? imm_s :
    (opcode == 7'b1100011) ? imm_b :
    (opcode == 7'b0110111) ? imm_u :
    (opcode == 7'b1101111) ? imm_j :
    32'b0;

endmodule
