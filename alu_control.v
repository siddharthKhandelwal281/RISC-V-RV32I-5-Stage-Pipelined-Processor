module alu_control(
 input [1:0] alu_op,
 input [2:0] funct3,
 input [6:0] funct7,
 output reg [3:0] alu_ctrl 
);


   always @(*) begin
          
   case(alu_op) 
       2'b00: alu_ctrl=4'b0000;
       2'b01: alu_ctrl=4'b0001;
       2'b10: begin
          case(funct3) 
              3'b000: alu_ctrl=(funct7==7'b0100000)?4'b0001:4'b0000;
              3'b010: alu_ctrl=4'b0100;
              3'b110: alu_ctrl=4'b0011;
              3'b111: alu_ctrl=4'b0010;
              default: alu_ctrl=4'b0000;
              endcase 
              end
       2'b11: begin
            case(funct3) 
               3'b000: alu_ctrl=4'b0000;
               3'b010: alu_ctrl=4'b0100;
               3'b110: alu_ctrl=4'b0011;
               3'b111: alu_ctrl=4'b0010;
               default: alu_ctrl=4'b0000;
               endcase
               end
               default: alu_ctrl=4'b0000;
               endcase
   end
endmodule