module aluDecoder (
  input [1:0] aluop,
  input [5:0] opcode,
  input [5:0] funct,
  output reg [3:0] aluControl
);

  always @(*) begin
    case (aluop)
      2'b00: aluControl = 4'b0010; // lw/sw operation (add)
      2'b01: aluControl = 4'b0110; // beq operation (subtract)
      2'b10: begin // I-type operation
        case (opcode)
          6'b001000: aluControl = 4'b0010;  // addi operation (add immediate);
          6'b001100: aluControl = 4'b0000; // andi operation (and immediate);
          6'b001101: aluControl = 4'b0001; //ori operation (or immediate);
          6'b001010: aluControl = 4'b0111; // slti operation (set less than immediate);
          default: aluControl = 4'bxxxx; // invalid operation
        endcase
      end
      2'b11: begin // R-type operation
        case (funct)
          6'b100000: aluControl = 4'b0010; // add operation
          6'b100010: aluControl = 4'b0110; // sub operation
          6'b100100: aluControl = 4'b0000; // and operation
          6'b100101: aluControl = 4'b0001; // or operation
          6'b101010: aluControl = 4'b0111; // slt operation
          default: aluControl = 4'bxxxx; // invalid operation
        endcase
      end
      default: begin // R-type operation
        aluControl = 4'bxxxx; // invalid operation
      end
    endcase
  end

endmodule