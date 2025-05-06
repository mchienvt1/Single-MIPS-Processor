module mainDecoder (
  input [5:0] opcode,
  output reg memWrite,
  output reg regWrite,
  output reg aluSrc,
  output reg jump,
  output reg memtoReg,
  output reg branch,
  output reg regdst,
  output reg [1:0] aluop
);

always @(*) begin
  case (opcode)
    6'b000000: begin // R-type instructions
      memWrite = 0;
      regWrite = 1;
      aluSrc = 0;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 1;
      aluop = 2'b11; // R-type ALU operation
    end
    6'b100011: begin // lw instruction
      memWrite = 0;
      regWrite = 1;
      aluSrc = 1;
      jump = 0;
      memtoReg = 1;
      branch = 0;
      regdst = 0;
      aluop = 2'b00; // lw ALU operation
    end
    6'b101011: begin // sw instruction
      memWrite = 1;
      regWrite = 0;
      aluSrc = 1;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b00; // sw ALU operation
    end
    6'b000100: begin // beq instruction
      memWrite = 0;
      regWrite = 0;
      aluSrc = 0;
      jump = 0;
      memtoReg = 0;
      branch = 1; // Branch if equal
      regdst = 0;
      aluop = 2'b01; // beq ALU operation
    end
    6'b001101: begin // ori instruction
      memWrite = 0;
      regWrite = 1;
      aluSrc = 1;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b10; // OR immediate ALU operation
    end
    6'b001100: begin // andi instruction
      memWrite = 0;
      regWrite = 1;
      aluSrc = 1;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b10; // AND immediate ALU operation
    end
    6'b001000: begin // addi instruction
      memWrite = 0;
      regWrite = 1;
      aluSrc = 1;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b00; // ADD immediate ALU operation
    end
    6'b001010: begin // slti instruction
      memWrite = 0;
      regWrite = 1;
      aluSrc = 1;
      jump = 0;
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b10; // Set less than immediate ALU operation
    end
    6'b000010: begin // j instruction
      memWrite = 0;
      regWrite = 0;
      aluSrc = 0;
      jump = 1;  // Enable jump
      memtoReg = 0;
      branch = 0;
      regdst = 0;
      aluop = 2'b00; // No ALU operation needed for jump
    end
    default: begin // Default case for unsupported opcodes
      memWrite = 1'bx;
      regWrite = 1'bx;
      aluSrc = 1'bx;
      jump = 1'bx;
      memtoReg = 1'bx;
      branch = 1'bx;
      regdst = 1'bx;
      aluop = 2'bxx; // No operation for unsupported opcodes
    end
  endcase
end

endmodule