module data_mem(
 input clk,mem_read,mem_write,
 input [31:0] addr,write_data,
 output reg [31:0] read_data
);
  
  reg [31:0] memory [0:255];
  
  integer j;
initial begin
  for (j=0; j<256; j=j+1)
    memory[j] = 0;
end
  
  // write logic 
  always @(posedge clk) begin
      if(mem_write)
     memory[addr[9:2]]<=write_data;
  end

// read data

always @(*) begin
   if (mem_read) 
      read_data=memory[addr[9:2]];
      else
      read_data=32'b0;
   end
      
endmodule