`timescale 1ns/1ps

module top(
input clk,reset
);


// extra flush branch 
wire branch_flush,is_branch,branch_taken;
wire [31:0] pc_plus4,branch_target;
wire [31:0] ex_pc_plus4;
wire [31:0] id_imm,ex_imm;

      wire [31:0] id_pc_plus4;
wire alu_src;
wire ex_alu_src;
wire [31:0] ex_pc;
wire [31:0] id_pc;

      // source reg instailization
   wire [4:0] ex_rs1,ex_rs2;
   wire [4:0] ex_rd,id_rs1,id_rs2;
   wire id_ex_flush_hazard;
   wire ex_is_branch;
// branch flush some logic here 
assign branch_flush= branch_taken;


   // if stage
   wire [31:0] pc_current,pc_next,instr_addr;
   wire pc_write;
   // some hazards control signals 
wire pc_write_hazard,if_id_write,id_ex_flush;
//   assign pc_write=pc_write_hazard;
   
   
   // common control signal for id_ex reg stall + branch flush 
wire id_ex_flush_final;
//assign id_ex_flush_final=branch_flush | id_ex_flush ;
   // pc instantiate  
   pc pc_inst(
   .clk(clk),
   .reset(reset),
   .pc_current(pc_current),
   .pc_next(pc_next),
   .pc_write(pc_write)
   );
   
   // if stage instantiate 
   if_stage IF(
//   .clk(clk),
//   .reset(reset),
//   .pc_write(pc_write),
   .branch_taken(branch_taken),
   .branch_target(branch_target),
   .pc_current(pc_current),
   .pc_next(pc_next),
   .pc_plus4(pc_plus4),
   .instr_addr(instr_addr)
   );
   
   // wire for imem
   wire [31:0] instr;
   // instantiate imem
   imem IMEM(
   .instr_addr(instr_addr),
   .instr(instr)
   );
   // if id register
   wire [31:0] instr_id;
   
   if_id_reg IF_ID(
   .clk(clk),
   .reset(reset),
   .if_id_write(if_id_write),
   .instr_in(instr),
   .instr_out(instr_id),
   .if_pc_plus4(pc_plus4),
   .id_pc_plus4(id_pc_plus4),
   .branch_flush(branch_flush),
   .if_pc(pc_current),
   .id_pc(id_pc)
   );
   
      wire [31:0] wb_write_data;
   wire wb_write_en;
   // now intergrate id stage 
   // outputs wire for id stage
   wire [6:0] opcode;
   wire [4:0] rs1,rs2,rd;
   wire [2:0] funct3;
   wire [6:0] funct7;
   wire [31:0] rd1,rd2;
   wire [4:0] wb_rd;
  
   // control unit part
   wire mem_read,mem_write,reg_write,mem_to_reg;
   wire [1:0] alu_op;
   
   // id instantiate 
   id_stage ID(
   .clk(clk),
   .instr(instr_id),
   .wb_we(wb_write_en),
   .wb_rd(wb_rd),
   .wb_wd(wb_write_data),
   .opcode(opcode),
   .rs1(rs1),
   .rs2(rs2),
   .rd(rd),
   .funct3(funct3),
   .funct7(funct7),
   .rd1(rd1),
   .rd2(rd2),
   .imm(id_imm),
   .mem_to_reg(mem_to_reg),
   .mem_read(mem_read),
   .mem_write(mem_write),
   .reg_write(reg_write),
   .is_branch(is_branch),
   .alu_op(alu_op),
   .alu_src(alu_src)
   
   );
   assign id_rs1 = rs1;
assign id_rs2 = rs2;



   // wires for id ex reg
   wire [1:0] ex_alu_op;
   wire [2:0] ex_funct3;
   wire [6:0] ex_funct7;
   wire [31:0] ex_rd1,ex_rd2;
   wire ex_mem_write,ex_mem_read,ex_reg_write,ex_mem_to_reg;
   wire [1:0] forwardA, forwardB;
   
//      // source reg instailization
//   wire [4:0] ex_rs1,ex_rs2;
//   wire [4:0] ex_rd,id_rs1,id_rs2;
//   wire id_ex_flush_hazard;
//       hazard unit instantization
   hazard_unit HU(
   .ex_mem_read(ex_mem_read),
   .ex_rd(ex_rd),
   .id_rs1(id_rs1),
   .id_rs2(id_rs2),
   .pc_write(pc_write_hazard),
   .if_id_write(if_id_write),
   .id_ex_flush(id_ex_flush_hazard),
   .branch_taken(branch_taken)
   );
   assign pc_write = pc_write_hazard ;
assign id_ex_flush_final = (branch_flush) | (id_ex_flush_hazard);

   
   // id/ex reg instantiate 
   id_ex_reg ID_EX(
   .clk(clk),
   .reset(reset),
   .id_alu_op(alu_op),
   .id_funct3(funct3),
   .id_funct7(funct7),
   .id_rd1(rd1),
   .id_rd2(rd2),
   .id_mem_write(mem_write),
   .id_mem_read(mem_read),
   .id_reg_write(reg_write),
   .id_mem_to_reg(mem_to_reg),
   .id_rd(rd),
   .id_rs1(rs1),
   .id_rs2(rs2),
   .id_ex_flush(id_ex_flush_final),
   .id_is_branch(is_branch),
   .id_pc_plus4(id_pc_plus4),
   .ex_alu_op(ex_alu_op),
   .ex_funct3(ex_funct3),
   .ex_funct7(ex_funct7),
   .ex_rd1(ex_rd1),
   .ex_rd2(ex_rd2),
   .ex_mem_write(ex_mem_write),
   .ex_mem_read(ex_mem_read),
   .ex_reg_write(ex_reg_write),
   .ex_mem_to_reg(ex_mem_to_reg),
   .ex_rd(ex_rd),
   .ex_rs1(ex_rs1),
   .ex_rs2(ex_rs2),
   .ex_pc_plus4(ex_pc_plus4),
   .ex_is_branch(ex_is_branch),
   .id_imm(id_imm),
   .ex_imm(ex_imm),
   .id_alu_src(alu_src),
   .ex_alu_src(ex_alu_src),
   .id_pc(id_pc),
   .ex_pc(ex_pc)
   
   );
   
   
      wire wb_reg_write,wb_mem_to_reg, mem_reg_write_w, mem_mem_to_reg_w;

      // ex/mem reg ONLY WIRES 
   wire [31:0] mem_alu_result;
   wire [31:0] mem_rd2;
   wire [4:0] mem_rd;
   wire mem_mem_read,mem_mem_write,mem_reg_write,mem_mem_to_reg;
      wire [31:0] alu_in1,alu_in2;
   
   forward_unit FU(
   .ex_rs1(ex_rs1),
   .ex_rs2(ex_rs2),
   .mem_reg_write(mem_reg_write),
   .mem_rd(mem_rd),
   .wb_reg_write(wb_reg_write),
   .wb_rd(wb_rd),
   .forwardA(forwardA),
   .forwardB(forwardB)
   );
   
//   assign forwardA = 2'b00;
//assign forwardB = 2'b00;
   assign alu_in1=(forwardA==2'b01)?mem_alu_result:(forwardA==2'b10)?wb_write_data:ex_rd1;
//   assign alu_in2=(forwardB==2'b01)?mem_alu_result:(forwardB==2'b10)?wb_write_data:ex_rd2;

wire [31:0] forwarded_B;

assign forwarded_B = (forwardB==2'b01)?mem_alu_result:
                     (forwardB==2'b10)?wb_write_data:
                     ex_rd2;

assign alu_in2 = (ex_alu_src) ? ex_imm : forwarded_B;
   
   // ex stage integration include alu+alu_control 
   // output wire for ex stage 
   wire [31:0] ex_alu_result;
   // instantiate ex stage 
   ex_stage EX (
   .alu_in1(alu_in1),
   .alu_in2(alu_in2),
   .funct3(ex_funct3),
   .funct7(ex_funct7),
   .alu_op(ex_alu_op),
   .alu_result(ex_alu_result),
   .is_branch(ex_is_branch),
//   .ex_pc_plus4(ex_pc_plus4),
   .branch_target(branch_target),
   .branch_taken(branch_taken),
   .ex_imm(ex_imm),
   .alu_src(ex_alu_src),
   .ex_pc(ex_pc)
   );
   
   // ex/mem reg 
   
   ex_mem_reg EX_MEM(
   .clk(clk),
   .reset(reset),
   .ex_alu_result(ex_alu_result),
   .ex_rd2(forwarded_B),
   .ex_mem_read(ex_mem_read),
   .ex_mem_write(ex_mem_write),
   .ex_reg_write(ex_reg_write),
   .ex_mem_to_reg(ex_mem_to_reg),
   .ex_rd(ex_rd),
   .mem_alu_result(mem_alu_result),
   .mem_rd2(mem_rd2),
   .mem_mem_read(mem_mem_read),
   .mem_mem_write(mem_mem_write),
   .mem_reg_write(mem_reg_write),
   .mem_mem_to_reg(mem_mem_to_reg),
   .mem_rd(mem_rd)
   );
   
   
   // mem stage 
   wire [31:0] mem_alu_out,mem_read_data;
   
   mem_stage MEM (
   .clk(clk),
   .mem_alu_result(mem_alu_result),
   .mem_rd2(mem_rd2),
   .mem_mem_read(mem_mem_read),
   .mem_mem_write(mem_mem_write),
   .mem_reg_write(mem_reg_write),
   .mem_mem_to_reg(mem_mem_to_reg),
   .mem_alu_out(mem_alu_out),
   .mem_read_data(mem_read_data),
   .wb_reg_write(mem_reg_write_w),
   .wb_mem_to_reg(mem_mem_to_reg_w)
   );
   
   // write back stage and register 
   wire [31:0] wb_alu_out,wb_read_data;
//   wire wb_reg_wrrdite,wb_mem_to_reg;
   
   mem_wb_reg MEM_WB(
   .clk(clk),
   .reset(reset),
   .mem_alu_out(mem_alu_out),
   .mem_read_data(mem_read_data),
   .mem_reg_write(mem_reg_write_w),
   .mem_mem_to_reg(mem_mem_to_reg_w),
   .mem_rd(mem_rd),
   .wb_alu_out(wb_alu_out),
   .wb_read_data(wb_read_data),
   .wb_reg_write(wb_reg_write),
   .wb_mem_to_reg(wb_mem_to_reg),
   .wb_rd(wb_rd)
   );
   
   // wb stage 
 
   
   wb_stage WB(
   .wb_alu_out(wb_alu_out),
   .wb_read_data(wb_read_data),
   .wb_reg_write(wb_reg_write),
   .wb_mem_to_reg(wb_mem_to_reg),
   .wb_write_data(wb_write_data),
   .wb_write_en(wb_write_en)
   );
   

//always @(posedge clk) begin
//    $display("rs1=%d rs2=%d | A=%h B=%h | fA=%b fB=%b",
//        ex_rs1, ex_rs2, alu_in1, alu_in2, forwardA, forwardB);
//end
endmodule