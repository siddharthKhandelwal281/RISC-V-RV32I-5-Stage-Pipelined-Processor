module forward_unit(
  input [4:0] ex_rs1,ex_rs2,mem_rd,wb_rd,
  input mem_reg_write,wb_reg_write,
  
  output reg [1:0] forwardA,forwardB
    );
    
    always @(*) begin
      // default values
      
      forwardA=2'b00;
      forwardB=2'b00;
      
      // EX/MEM
      if(mem_reg_write && (mem_rd!=5'b0) && (mem_rd==ex_rs1)) begin
        forwardA=2'b01;
      end    
       if(mem_reg_write && (mem_rd!=5'b0) && (mem_rd==ex_rs2)) begin
        forwardB=2'b01;
      end    
      
      
      // MEM/WB 
    if(wb_reg_write && (wb_rd!=5'b0) && (wb_rd==ex_rs1) && !(mem_reg_write && (mem_rd!=5'b0) && (mem_rd==ex_rs1)))begin
 
         forwardA=2'b10;
    end
      if(wb_reg_write && (wb_rd!=5'b0) && (wb_rd==ex_rs2) && !(mem_reg_write && (mem_rd!=5'b0) && (mem_rd==ex_rs2)))begin
 
         forwardB=2'b10;
    end

 


    end
endmodule