`timescale 1ns / 1ps

module pc_module_tb;

  // Inputs
  reg clk;
  reg reset;
  reg pcsrc;
  reg jump;
  reg [25:0] instr;

  // Output
  wire [31:0] pc;

  // Instantiate the Unit Under Test (UUT)
  pc_module uut (
    .clk(clk),
    .reset(reset),
    .pcsrc(pcsrc),
    .jump(jump),
    .instr(instr),
    .pc(pc)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;  // 100 MHz clock
  end

  // Task to display output
  task display_outputs;
    begin
      $display("Time = %0t | PC = %h, reset = %b, pcsrc = %b, jump = %b, instr = %h", $time, pc, reset, pcsrc, jump, instr);
    end
  endtask

  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;
    pcsrc = 0;
    jump = 0;
    instr = 26'b0;

    // Display the header
    $display("Testing pc_module...\n");

    // Test 1: Reset test
    $display("Test 1: Reset test");
    reset = 1; #10; display_outputs();
    reset = 0; #10; display_outputs();

    reset = 1;

    // Test 2: Regular operation with pcsrc = 1 (branch)
    $display("Test 2: Regular operation with pcsrc = 1");
    instr = 26'b00000000000000000000000000;  // Some dummy instruction
    pcsrc = 1; #10; display_outputs();

    // Test 3: Regular operation with pcsrc = 0 (no branch)
    $display("Test 3: Regular operation with pcsrc = 0");
    pcsrc = 0; #10; display_outputs();

    // Test 4: Jump operation
    $display("Test 4: Jump operation");
    jump = 1; instr = 26'b10101010101010101010101010;  // Jump instruction
    #10; display_outputs();

    // Test 5: Check jump and pcsrc working together
    $display("Test 5: Check jump and pcsrc working together");
    jump = 1; pcsrc = 1; instr = 26'b11001100110011001100110011;  // Another instruction
    #10; display_outputs();

    // Test 6: No jump and pcsrc = 1
    $display("Test 6: No jump, pcsrc = 1");
    jump = 0; pcsrc = 1; instr = 26'b11100011100011100011100011;  // Some branch instruction
    #10; display_outputs();

    // Test 7: No jump and pcsrc = 0
    $display("Test 7: No jump, pcsrc = 0");
    jump = 0; pcsrc = 0; instr = 26'b10011001100110011001100110;  // Some instruction with no branch
    #10; display_outputs();

    // Finish simulation
    $finish;
  end

endmodule