module datapath_tb;

  // Inputs
  reg clk;
  reg reset;
  reg regdst;
  reg pcsrc;
  reg memtoReg;
  reg aluSrc;
  reg regWrite;
  reg jump;
  reg [3:0] aluControl;
  reg [31:0] instr;
  reg [31:0] readData;

  // Outputs
  wire zero;
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] writeData;
  
  // Instantiate the Unit Under Test (UUT)
  datapath uut (
    .clk(clk),
    .reset(reset),
    .regdst(regdst),
    .pcsrc(pcsrc),
    .memtoReg(memtoReg),
    .aluSrc(aluSrc),
    .regWrite(regWrite),
    .jump(jump),
    .aluControl(aluControl),
    .instr(instr),
    .zero(zero),
    .pc(pc),
    .readData(readData),
    .aluout(aluout),
    .writeData(writeData)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk <= 0;
    reset <= 0;
    regdst <= 0;
    pcsrc <= 0;
    memtoReg <= 0;
    aluSrc <= 0;
    regWrite <= 0;
    jump <= 0;
    aluControl <= 4'b0000;
    instr <= 32'b0;
    readData <= 32'b0;
  
    // Apply reset
    #10;
    reset = 1;
    // Test Case 1: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00001, 5'b00010, 16'b0000000000000010}; // ADDI R2, R1, 2
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0010; // ALU control for ADD
    regWrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 2)", aluout);

    // Test Case 2: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00001, 5'b00011, 16'b0000000000000100}; // ADDI R3, R1, 4
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0010; // ALU control for ADD
    regWrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R1 + 4)", aluout);

    // Test Case 3: Immediate instruction (ANDI)
    instr = {6'b001100, 5'b00001, 5'b00100, 16'b0000000000001111}; // ANDI R4, R1, 15
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0000; // ALU control for AND
    regWrite = 1;
    #10;
    $display("ANDI Instruction: aluout = %h (Expected: R1 & 15)", aluout);

    // Test Case 4: Immediate instruction (ORI)
    instr = {6'b001101, 5'b00001, 5'b00101, 16'b0000000000001010}; // ORI R5, R1, 10
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0001; // ALU control for OR
    regWrite = 1;
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R1 | 10)", aluout);

    // Test Case 5: Immediate instruction (SLTI)
    instr = {6'b001010, 5'b00001, 5'b00110, 16'b0000000000000011}; // SLTI R6, R1, 3
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0111; // ALU control for SLT
    regWrite = 1;
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: R1 < 3 ? 1 : 0)", aluout);

    // Test Case 6: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00010, 5'b00111, 16'b0000000000000001}; // ADDI R7, R2, 1
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0010; // ALU control for ADD
    regWrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R2 + 1)", aluout);

    // Test Case 7: Immediate instruction (ANDI)
    instr = {6'b001100, 5'b00010, 5'b01000, 16'b0000000000001110}; // ANDI R8, R2, 14
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0000; // ALU control for AND
    regWrite = 1;
    #10;
    $display("ANDI Instruction: aluout = %h (Expected: R2 & 14)", aluout);

    // Test Case 8: Immediate instruction (ORI)
    instr = {6'b001101, 5'b00010, 5'b01001, 16'b0000000000001011}; // ORI R9, R2, 11
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0001; // ALU control for OR
    regWrite = 1;
    #10;
    $display("ORI Instruction: aluout = %h (Expected: R2 | 11)", aluout);

    // Test Case 9: Immediate instruction (SLTI)
    instr = {6'b001010, 5'b00010, 5'b01010, 16'b0000000000000010}; // SLTI R10, R2, 2
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0111; // ALU control for SLT
    regWrite = 1;
    #10;
    $display("SLTI Instruction: aluout = %h (Expected: R2 < 2 ? 1 : 0)", aluout);

    // Test Case 10: Immediate instruction (ADDI)
    instr = {6'b001000, 5'b00011, 5'b01011, 16'b0000000000000101}; // ADDI R11, R3, 5
    regdst = 0;
    aluSrc = 1;
    aluControl = 4'b0010; // ALU control for ADD
    regWrite = 1;
    #10;
    $display("ADDI Instruction: aluout = %h (Expected: R3 + 5)", aluout);

    // Test Case 11: Memory instruction (LW)
    instr = {6'b100011, 5'b00001, 5'b00010, 16'b0000000000000100}; // LW R2, 4(R1)
    regdst = 0;
    aluSrc = 1;
    memtoReg = 1;
    regWrite = 1;
    readData = 32'hF; // Data from memory
    #10;
    $display("LW Instruction: data_wb = %h (Expected: F)", writeData);
    
    // Test Case 12: Store Word (SW) instruction
    instr = {6'b101011, 5'b00001, 5'b00010, 16'h0004}; // SW R2, 4(R1)
    regdst = 0; // Destination register is not used for store instruction
    aluSrc = 1; // Use immediate value for the second operand
    aluControl = 4'b0010; // ALU control for ADD (to calculate the effective address)
    regWrite = 0; // No register write for store instruction
    #10;
    $display("SW Instruction: Address = %h, Value = %h (Expected: store R2 to memory location R1 + 4)", aluout, writeData);
  

    // Test Case 13: Jump instruction (J)
    instr = {6'b000010, 26'b00000000000000000000000001}; // J 1
    jump = 1;
    #10;
    $display("Jump Instruction: pc = %h (Expected: 4)", pc);

    // Test Case 14: Branch instruction (BEQ)
    instr = {6'b000100, 5'b00001, 5'b00010, 16'b0000000000000010}; // BEQ R1, R2, offset 2
    jump = 0;
    
    regdst = 0;
    aluSrc = 0;
    aluControl = 4'b0110; // ALU control for SUB
    pcsrc = 1;
    regWrite = 0;
    #10;
    $display("BEQ Instruction: pc = %h (Expected: branch target address)", pc);
    
    
    // Finish simulation
    $finish;
  end

endmodule







