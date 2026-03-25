
module hazard_unit(
  input [4:0] id_rs1,id_rs2,
  input ex_mem_read,
  input [4:0] ex_rd,
  input branch_taken,
  
  output reg pc_write,if_id_write,id_ex_flush
    );

always @(*) begin
  // deafult balues
  pc_write=1'b1;
  if_id_write=1'b1;
  id_ex_flush=1'b0;
  

   if(branch_taken) begin
     pc_write=1'b1;
     if_id_write=1'b1;
     id_ex_flush=1'b1;
  end
  
   else if(ex_mem_read && (ex_rd==id_rs1 || ex_rd==id_rs2) && ex_rd!=5'b0) begin
        pc_write=1'b0;
        if_id_write=1'b0;
        id_ex_flush=1'b1;
  end
  
end

endmodule
