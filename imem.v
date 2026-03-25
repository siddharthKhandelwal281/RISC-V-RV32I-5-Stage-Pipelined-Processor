module imem(
input [31:0] instr_addr,
output [31:0] instr
);

reg [31:0] memory [0:255];
integer i;  

// for simulation purpose only
initial begin

 for (i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;
$readmemh("program.mem",memory);
end

assign instr=memory[instr_addr[9:2]];
endmodule 