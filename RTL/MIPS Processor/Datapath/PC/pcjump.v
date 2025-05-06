module pcjump #(
  parameter WIDTH = 32
)(
  input [25:0] instr,
  input [WIDTH-1:0] pcadder4,
  output [WIDTH-1:0] pcjump
);

  assign pcjump = {pcadder4[31:28], instr[25:0], 2'b00};
  // Concatenate the upper 4 bits of pcadder4 with instr and 2 zeros

endmodule