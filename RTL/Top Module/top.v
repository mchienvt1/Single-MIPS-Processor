module singleMIPS(
  input clk,reset,
  output [31:0] pc,
  output [31:0] aluout,
  output [31:0] readData,
  output [31:0] writeData
);

  wire [31:0] instr;
  wire memWrite;
  // wire [31:0] readData;
  // wire [31:0] writeData;

  instructionMemory imem(pc, instr);

  dataMemory dmem(clk, memWrite, aluout, writeData, readData);

  mips mips(
    .clk(clk),
    .reset(reset),
    .instr(instr),
    .readData(readData),
    .pc(pc),
    .aluout(aluout),
    .writeData(writeData),
    .memWrite(memWrite)
  );

endmodule