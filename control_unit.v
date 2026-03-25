module control_unit(
 input [6:0] opcode,
 output reg mem_read,mem_write,reg_write,mem_to_reg,is_branch,
 output reg [1:0] alu_op,
 output reg alu_src
);

always @(*) begin
  // initial values
  mem_read=1'b0;
  mem_write=1'b0;
  reg_write=1'b0;
  mem_to_reg=1'b0;
  alu_op=2'b0;
  is_branch=1'b0;
  
  alu_src = 1'b0;  // default

  
    case(opcode) 
       7'b0110011: begin
           reg_write=1'b1;
           alu_op=2'b10;
           alu_src=1'b0;
           end
           
       7'b0010011: begin
          reg_write=1'b1;
          alu_op=2'b11;
          alu_src=1'b1;
       end
       
       7'b0000011: begin
          mem_read=1'b1;
          reg_write=1'b1;
          mem_to_reg=1'b1;
          alu_op=2'b00;
          alu_src=1'b1;
       end
       
       7'b0100011: begin
          mem_write=1'b1;
          alu_op=2'b00;
          alu_src=1'b1;
       end
       
       7'b1100011: begin
         is_branch=1'b1;
         alu_op=2'b01;
         alu_src=1'b0;
       end
       
       
       default: begin
         // NOP
       end
       endcase
end
endmodule