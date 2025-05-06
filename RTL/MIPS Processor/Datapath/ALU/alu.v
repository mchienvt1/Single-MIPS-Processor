module alu #(
  parameter WIDTH = 32
)(
  input [WIDTH-1:0] var1, var2,
  input [3:0] aluControl,
  output reg [WIDTH-1:0] aluout,
  output zero
);

  always @(*) begin
    case(aluControl)
      4'b0000: aluout = var1 & var2; //AND
      4'b0001: aluout = var1 | var2; //OR
      4'b0010: aluout = var1 + var2; //ADD
      4'b0110: aluout = var1 - var2; //SUB
      4'b0111: aluout = var1 < var2 ? 1 : 0; //SLT
      default: aluout = {WIDTH{1'bx}}; //default case
    endcase
  end

  assign zero = (aluout == 0 && aluControl == 4'b0110) ? 1 : 0; //zero flag for subtraction;


endmodule