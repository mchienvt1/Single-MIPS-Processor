module mips_0_tb;

  // Inputs
  reg clk;
  reg reset;
  reg [31:0] instr;
  reg [31:0] readData;

  // Outputs
  wire [31:0] pc;
  wire memWrite;
  wire [31:0] aluout;
  wire [31:0] writeData;

  // Instantiate the Unit Under Test (UUT)
  mips uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instr(instr),
    .memWrite(memWrite),
    .aluout(aluout),
    .writeData(writeData),
    .readData(readData)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    // Initialize Inputs
    reset <= 0;
    instr <= 0;
    readData <= 0;

    // Wait for global reset to finish
    #10;
    reset <= 1;

    // Test Immediate Instructions
    // ADDI: add immediate value to register
    instr = {6'b001000, 5'b00001, 5'b00010, 16'b0000000000000010}; // ADDI R2, R1, 2
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 2)", aluout);
    
    // ORI: OR immediate value with register
    instr = {6'b001101, 5'b00001, 5'b00011, 16'b0000000000000100}; // ORI R3, R1, 4
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R1 | 4)", aluout);
    
    // SLTI: set on less than immediate value
    instr = {6'b001010, 5'b00001, 5'b00100, 16'b0000000000000011}; // SLTI R4, R1, 3
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: R1 < 3)", aluout);
    
    // Test R-Type Instructions
    // ADD: add two registers
    instr = {6'b000000, 5'b00100, 5'b00010, 5'b00011, 5'b00000, 6'b100000}; // ADD R3, R4, R2
    #10;
    $display("ADD Instruction: aluout = %h (Expected: R4 + R2)", aluout);
    
    // SUB: subtract two registers
    instr = {6'b000000, 5'b00011, 5'b00100, 5'b00001, 5'b00000, 6'b100010}; // SUB R1, R3, R4
    #10;
    $display("SUB Instruction: aluout = %h (Expected: R3 - R4)", aluout);
    
    // Apply reset again to check reset functionality
    reset = 0;
    #10;
    $display("PC reset: %d", pc);
    reset = 1;    
    
    // OR: OR two registers
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100101}; // OR R3, R1, R2
    #10;
    $display("OR Instruction: aluout = %h (Expected: R1 | R2)", aluout);
    
    // AND: AND two registers
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b100100}; // AND R3, R1, R2
    #10;
    $display("AND Instruction: aluout = %h (Expected: R1 & R2)", aluout);
    
    // SLT: set on less than
    instr = {6'b000000, 5'b00001, 5'b00010, 5'b00011, 5'b00000, 6'b101010}; // SLT R3, R1, R2
    #10;
    $display("SLT Instruction: aluout = %h (Expected: R1 < R2)", aluout);
    


    // End simulation
    // Finish the simulation
    $finish;
  end

endmodule



