`timescale 1ns / 1ps

module mainDecoder_tb;

  // Inputs
  reg [5:0] opcode;

  // Outputs
  wire memWrite;
  wire regWrite;
  wire aluSrc;
  wire jump;
  wire memtoReg;
  wire branch;
  wire regdst;
  wire [1:0] aluop;

  // Instantiate the Unit Under Test (UUT)
  mainDecoder uut (
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

  // Task to display outputs in readable format
  task display_outputs;
    begin
      $display("opcode = %b | memWrite = %b, regWrite = %b, aluSrc = %b, jump = %b, memtoReg = %b, branch = %b, regdst = %b, aluop = %b",
        opcode, memWrite, regWrite, aluSrc, jump, memtoReg, branch, regdst, aluop);
    end
  endtask

  initial begin
    $display("Testing mainDecoder...\n");

    // Test R-type (opcode = 000000)
    opcode = 6'b000000; #10; display_outputs();

    // Test lw (opcode = 100011)
    opcode = 6'b100011; #10; display_outputs();

    // Test sw (opcode = 101011)
    opcode = 6'b101011; #10; display_outputs();

    // Test beq (opcode = 000100)
    opcode = 6'b000100; #10; display_outputs();

    // Test ori (opcode = 001101)
    opcode = 6'b001101; #10; display_outputs();

    // Test andi (opcode = 001100)
    opcode = 6'b001100; #10; display_outputs();

    // Test addi (opcode = 001000)
    opcode = 6'b001000; #10; display_outputs();

    // Test slti (opcode = 001010)
    opcode = 6'b001010; #10; display_outputs();

    // Test unsupported opcode (e.g., 111111)
    opcode = 6'b111111; #10; display_outputs();

    $finish;
  end

endmodule