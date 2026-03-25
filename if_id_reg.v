module if_id_reg(
input clk,reset,if_id_write,
input [31:0] instr_in,
input [31:0] if_pc_plus4,
input branch_flush,
input [31:0] if_pc,
output reg [31:0] id_pc_plus4,
output reg [31:0] instr_out,
output reg [31:0] id_pc
);

 always @(posedge clk or posedge reset) begin
 
 if (reset) begin
 
   instr_out<=32'b0;
   id_pc_plus4<=32'b0;
   id_pc<=32'b0;
 end
 else if(branch_flush)begin
    instr_out<=32'b0;
       id_pc<=32'b0;

 end
  
 else if(if_id_write) 
     instr_out<=instr_in;
     id_pc_plus4<=if_pc_plus4;
     id_pc<=if_pc;
 
 end
 
endmodule 
