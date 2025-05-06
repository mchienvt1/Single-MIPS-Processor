`timescale 1ns / 1ps

module controller_tb;

  // Inputs
  reg [5:0] opcode;
  reg [5:0] funct;
  reg zero;

  // Outputs
  wire [3:0] aluControl;
  wire memWrite, regWrite, aluSrc, jump, memtoReg, pcsrc, regdst;

  // Instantiate Unit Under Test (UUT)
  controller uut (
    .opcode(opcode),
    .funct(funct),
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

  // Task to display result
  task display_result;
    begin
      $display("opcode = %b, funct = %b, zero = %b | aluControl = %b | memWrite = %b, regWrite = %b, aluSrc = %b, jump = %b, memtoReg = %b, pcsrc = %b, regdst = %b",
               opcode, funct, zero, aluControl, memWrite, regWrite, aluSrc, jump, memtoReg, pcsrc, regdst);
    end
  endtask

  initial begin
    $display("Testing controller...\n");

    // Test lw (load word)
    opcode = 6'b100011; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test sw (store word)
    opcode = 6'b101011; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test beq (branch equal) with zero = 1
    opcode = 6'b000100; funct = 6'bxxxxxx; zero = 1; #10; display_result();

    // Test beq (branch equal) with zero = 0
    opcode = 6'b000100; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test addi (add immediate)
    opcode = 6'b001000; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test andi (and immediate)
    opcode = 6'b001100; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test ori (or immediate)
    opcode = 6'b001101; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test slti (set less than immediate)
    opcode = 6'b001010; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test jump
    opcode = 6'b000010; funct = 6'bxxxxxx; zero = 0; #10; display_result();

    // Test R-type add
    opcode = 6'b000000; funct = 6'b100000; zero = 0; #10; display_result();

    // Test R-type sub
    opcode = 6'b000000; funct = 6'b100010; zero = 0; #10; display_result();

    // Test R-type and
    opcode = 6'b000000; funct = 6'b100100; zero = 0; #10; display_result();

    // Test R-type or
    opcode = 6'b000000; funct = 6'b100101; zero = 0; #10; display_result();

    // Test R-type slt
    opcode = 6'b000000; funct = 6'b101010; zero = 0; #10; display_result();

    // Invalid opcode
    opcode = 6'b111111; funct = 6'b000000; zero = 0; #10; display_result();

    $finish;
  end

endmodule