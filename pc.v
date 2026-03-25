`timescale 1ns/1ps
module pc(
input clk,
input reset,
input pc_write,
input [31:0] pc_next,
output reg [31:0] pc_current 
);


always @(posedge clk or posedge reset) begin
  if(reset) begin
        pc_current<=32'b0; // reset to 0
  end
  
  else begin
           if(pc_write && !reset)begin 
              pc_current<=pc_next;// updates it values 
           end  
  end 
  
  
end
endmodule

