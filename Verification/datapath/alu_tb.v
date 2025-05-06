`timescale 1ns / 1ps

module alu_tb;

  reg [31:0] var1, var2;
  reg [3:0] aluControl;
  wire [31:0] aluout;
  wire zero;

  // Instantiate the ALU
  alu uut (
    .var1(var1),
    .var2(var2),
    .aluControl(aluControl),
    .aluout(aluout),
    .zero(zero)
  );

  // Display task
  task display_result;
    begin
      $display("aluControl = %b | var1 = 0x%08x | var2 = 0x%08x | aluout = 0x%08x | zero = %b",
               aluControl, var1, var2, aluout, zero);
    end
  endtask

  initial begin
    $display("Starting ALU Testbench...\n");

    // AND
    aluControl = 4'b0000; var1 = 32'hFF00FF00; var2 = 32'h0F0F0F0F; #10;
    $display("Test AND:"); display_result();

    // OR
    aluControl = 4'b0001; var1 = 32'h0000FFFF; var2 = 32'hFFFF0000; #10;
    $display("Test OR:"); display_result();

    // ADD
    aluControl = 4'b0010; var1 = 32'd100; var2 = 32'd50; #10;
    $display("Test ADD:"); display_result();

    // SUB - result non-zero
    aluControl = 4'b0110; var1 = 32'd200; var2 = 32'd100; #10;
    $display("Test SUB (non-zero):"); display_result();

    // SUB - result zero
    aluControl = 4'b0110; var1 = 32'd100; var2 = 32'd100; #10;
    $display("Test SUB (zero):"); display_result();

    // SLT - var1 < var2
    aluControl = 4'b0111; var1 = 32'd10; var2 = 32'd20; #10;
    $display("Test SLT (true):"); display_result();

    // SLT - var1 > var2
    aluControl = 4'b0111; var1 = 32'd30; var2 = 32'd20; #10;
    $display("Test SLT (false):"); display_result();

    // Default case
    aluControl = 4'b1111; var1 = 32'd123; var2 = 32'd456; #10;
    $display("Test DEFAULT:"); display_result();

    $display("\nFinished ALU Testbench.");
    $finish;
  end

endmodule