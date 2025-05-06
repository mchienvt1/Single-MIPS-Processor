module controller (
  input [5:0] opcode,
  input [5:0] funct,
  input zero,
  output [3:0] aluControl,
  output memWrite, regWrite, aluSrc, jump, memtoReg, pcsrc, regdst
);

wire branch;
wire [1:0] aluop;
assign pcsrc = zero & branch; // Branch if equal

mainDecoder md(
  .opcode(opcode),
  .memWrite(memWrite),
  .regWrite(regWrite),
  .aluSrc(aluSrc),
  .jump(jump),
  .memtoReg(memtoReg),
  .branch(branch),
  .regdst(regdst),
  .aluop(aluop)
);

aluDecoder ad(
  .aluop(aluop),
  .opcode(opcode),
  .funct(funct),
  .aluControl(aluControl)
);

endmodule