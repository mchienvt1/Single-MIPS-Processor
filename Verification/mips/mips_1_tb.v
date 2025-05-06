module mips_1_tb;

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

 // Test case 1: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00001, 5'b00010, 16'b0000000000000100}; // lw R2, 4(R1)
    readData = 32'hDEADBEEF; // Simulate memory read data
    #10;
    $display("Test Case 1 - LW Instruction: writeData = %h (Expected: DEADBEEF)", writeData);

    // Test case 2: Store Word (sw) Instruction
    instr = {6'b101011, 5'b00001, 5'b00010, 16'b0000000000000100}; // sw R2, 4(R1)
    #10;
    $display("Test Case 2 - SW Instruction: writeData = %h (Expected: R2 value)", writeData);

    // Test case 3: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00011, 5'b00100, 16'b0000000000001000}; // lw R4, 8(R3)
    readData = 32'hCAFEBABE; // Simulate memory read data
    #10;
    $display("Test Case 3 - LW Instruction: writeData = %h (Expected: CAFEBABE)", writeData);

    // Test case 4: Store Word (sw) Instruction
    instr = {6'b101011, 5'b00011, 5'b00100, 16'b0000000000001000}; // sw R4, 8(R3)
    #10;
    $display("Test Case 4 - SW Instruction: writeData = %h (Expected: R4 value)", writeData);

    // Test case 5: Load Word (lw) Instruction
    instr = {6'b100011, 5'b00101, 5'b00110, 16'b0000000000001100}; // lw R6, 12(R5)
    readData = 32'hB16B00B5; // Simulate memory read data
    #10;
    $display("Test Case 5 - LW Instruction: writeData = %h (Expected: B16B00B5)", writeData);
    
    // Test case 6: Store Word (sw) Instruction
    instr = {6'b101011, 5'b00101, 5'b00110, 16'b0000000000001100}; // sw R6, 12(R5)
    #10;
    $display("Test Case 6 - SW Instruction: writeData = %h (Expected: R6 value)", writeData);
    
    // Test case 7: Branch on Equal (beq) Instruction
    instr = {6'b000100, 5'b00010, 5'b00010, 16'b0000000000000010}; // beq R2, R2, offset 2
    
    #10;
    $display("Test Case 7 - BEQ Instruction: pc = %h (Expected: pc + 8 if R2 == R2)", pc);

    // Test case 8: Branch on Equal (beq) Instruction
    instr = {6'b000100, 5'b00010, 5'b00011, 16'b0000000000000010}; // beq R2, R3, offset 2
    #10;
    $display("Test Case 8 - BNE Instruction: pc = %h (Expected: pc + 8 if R2 == R3)", pc);

    // Test case 9: Jump (j) Instruction
    instr = {6'b000010, 26'b00000000000000000000000001}; // j address 1
    #10;
    $display("Test Case 9 - J Instruction: pc = %h (Expected: jump to address 1)", pc);
    

    // End simulation

    // Finish the simulation
    $finish;
  end

endmodule







