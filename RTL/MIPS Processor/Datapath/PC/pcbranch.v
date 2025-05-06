module pcbranch #(
  parameter WIDTH = 32
)(
  input [15:0] instr,
  input [WIDTH-1:0] pcadder4,
  output [WIDTH-1:0] pcbranch
);

wire [WIDTH-1:0] extend, shiftLeft;

assign extend = {{16{instr[15]}}, instr};
assign shiftLeft = {extend[WIDTH-3:0], 2'b00};
assign pcbranch = pcadder4 + shiftLeft;

endmodule