module mips(
  input clk, reset,
  input [31:0] instr,
  input [31:0] readData,
  output [31:0] pc,
  output [31:0] aluout,
  output [31:0] writeData,
  output memWrite
);

wire [3:0] aluControl;
wire regWrite, aluSrc, jump, memtoReg, pcsrc, regdst;

controller c(
  .opcode(instr[31:26]),
  .funct(instr[5:0]),
  .zero(zero),
  .aluControl(aluControl),
  .memWrite(memWrite),
  .regWrite(regWrite),
  .aluSrc(aluSrc),
  .jump(jump),
  .memtoReg(memtoReg),
  .pcsrc(pcsrc),
  .regdst(regdst)
);

datapath dp(
  .clk(clk),
  .reset(reset),
  .instr(instr),
  .readData(readData),
  .regWrite(regWrite),
  .aluSrc(aluSrc),
  .jump(jump),
  .memtoReg(memtoReg),
  .pcsrc(pcsrc),
  .regdst(regdst),
  .pc(pc),
  .aluout(aluout),
  .writeData(writeData),
  .zero(zero),
  .aluControl(aluControl)
);

endmodule