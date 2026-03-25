`timescale 1ns/1ps

module tb_top;

reg clk,reset;

top uut(
.clk(clk),
.reset(reset)
);


  //clock generation 

always #5 clk=~clk;
 
 initial begin 
  clk=0;
  reset=1;
  
  
  #30;
  reset=0;
    
    
  #100;
  $finish;
  end

 
endmodule

