module regfile(
input clk,we,
input [4:0] rs1,rs2,rd,
input [31:0] wd,
output [31:0] rd1,rd2
);
 
 reg [31:0] registers [0:31];
 integer i;
initial begin
  for (i=0; i<32; i=i+1)
    registers[i] = 0;
end

 assign rd1=(rs1==0)?32'b0:registers[rs1];
 assign rd2=(rs2==0)?32'b0:registers[rs2];
 
 always @(posedge clk) begin
    
    if(we && (rd!=5'b0)) begin
       registers[rd]<=wd;
    end
 end
 

endmodule