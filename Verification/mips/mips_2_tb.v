module mips_2_tb;

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

     // Test Case 1: ADDI R2, R1, 8
    instr = 32'b001000_00001_00010_0000000000001000; // ADDI R2, R1, 8
    #10;
    $display("ADDI Instruction: R2 = %d (Expected: 8)", aluout);

    // Test Case 2: ADDI R3, R1, 16
    instr = 32'b001000_00001_00011_0000000000010000; // ADDI R3, R1, 16
    #10;
    $display("ADDI Instruction: R3 = %d (Expected: 16)", aluout);

    // Test Case 3: ADDI R6, R1, 5
    instr = 32'b001000_00001_00110_0000000000000101; // ADDI R6, R1, 5
    #10;
    $display("ADDI Instruction: R6 = %d (Expected: 5)", aluout);

    // Test Case 4: SUB R4, R3, R6
    instr = 32'b000000_00011_00110_00100_00000_100010; // SUB R4, R3, R6
    #10;
    $display("SUB Instruction: R4 = %d (Expected: 11)", aluout);

    // Test Case 5: OR R5, R2, R3
    instr = 32'b000000_00010_00011_00101_00000_100101; // OR R5, R2, R3
    #10;
    $display("OR Instruction: R5 = %d (Expected: 24)", aluout);

    // Test Case 6: LW R7, 6(R1)
    instr = 32'b100011_00001_00111_0000000000000110; // LW R7, 6(R1)
    readData = 32'h23; // Mock data to be read
    #10;
    $display("LW Instruction: R7 = %d (Expected: 35)", readData);

    // Test Case 7: SW R7, 6(R1)
    instr = 32'b101011_00001_00111_0000000000000110; // SW R7, 6(R1)
    #10;
    $display("SW Instruction: Memory[6+R1] = %d (Expected: 35)", writeData);

    // Test Case 8: SLT R1, R4, R2
    instr = 32'b000000_00100_00010_00001_00000_101010; // SLT R1, R4, R2
    #10;
    $display("SLT Instruction: R1 = %d (Expected: 0)", aluout);

    // Test Case 9: ADD R8, R4, R5
    instr = 32'b000000_00100_00101_01000_00000_100000; // ADD R8, R4, R5
    #10;
    $display("ADD Instruction: R8 = %d (Expected: 35)", aluout);

    // Test Case 10: BEQ R8, R7, around (Should be taken, PC = 48)
    instr = 32'b000100_01000_00111_0000000000000010; // BEQ R8, R7, offset 2
    #10;
    $display("BEQ (Equal) Instruction: PC = %h (Expected: PC + 8)", pc);

    // Test Case 11: ADD R2, R4, R3
    instr = 32'b000000_00100_00011_00010_00000_100000; // ADD R2, R4, R3
    #10;
    $display("ADD Instruction: R2 = %d (Expected: 27)", aluout);

    // Test Case 12: SUB R9, R7, R6
    instr = 32'b000000_00111_00110_01001_00000_100010; // SUB R9, R7, R6
    #10;
    $display("SUB Instruction: R9 = %d (Expected: 30)", aluout);
    
    //Test case 13: Jump 4
    instr = 32'b000010_00000000000000000000000100; // Jump 4
    #10;
    $display("Jump Instruction: PC = %h (Expected: 0x10)", pc);
    


    // End simulation

    // Finish the simulation
    $finish;
  end

endmodule






