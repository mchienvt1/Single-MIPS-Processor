`timescale 1ns / 1ps

module aluDecoder_tb;

  // Inputs
  reg [1:0] aluop;
  reg [5:0] opcode;
  reg [5:0] funct;

  // Output
  wire [3:0] aluControl;

  // Instantiate the Unit Under Test (UUT)
  aluDecoder uut (
    .aluop(aluop),
    .opcode(opcode),
    .funct(funct),
    .aluControl(aluControl)
  );

  // Task to display result
  task display_result;
    begin
      $display("aluop = %b, opcode = %b, funct = %b --> aluControl = %b", aluop, opcode, funct, aluControl);
    end
  endtask

  initial begin
    $display("Testing aluDecoder...\n");

    // Case 1: lw/sw (aluop = 00)
    aluop = 2'b00; opcode = 6'bxxxxxx; funct = 6'bxxxxxx; #10; display_result();

    // Case 2: beq (aluop = 01)
    aluop = 2'b01; opcode = 6'bxxxxxx; funct = 6'bxxxxxx; #10; display_result();

    // Case 3: I-type operations (aluop = 10)
    aluop = 2'b10;

    // addi
    opcode = 6'b001000; #10; display_result();
    // andi
    opcode = 6'b001100; #10; display_result();
    // ori
    opcode = 6'b001101; #10; display_result();
    // slti
    opcode = 6'b001010; #10; display_result();
    // invalid I-type
    opcode = 6'b111111; #10; display_result();

    // Case 4: R-type operations (default case)
    aluop = 2'b11; opcode = 6'b000000;

    // add
    funct = 6'b100000; #10; display_result();
    // sub
    funct = 6'b100010; #10; display_result();
    // and
    funct = 6'b100100; #10; display_result();
    // or
    funct = 6'b100101; #10; display_result();
    // slt
    funct = 6'b101010; #10; display_result();
    // invalid R-type
    funct = 6'b111111; #10; display_result();

    $finish;
  end

endmodule