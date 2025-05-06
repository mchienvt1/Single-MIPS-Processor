module pcadder4 #(
  parameter WIDTH = 32
)(
  input [WIDTH-1:0] pc_in,
  output [WIDTH-1:0] pc_out
);
  assign pc_out = pc_in + 4;

endmodule