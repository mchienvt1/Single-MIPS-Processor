`timescale 1ns / 1ps

module register_tb;

  reg clk, reset;
  reg [4:0] reg_address1, reg_address2, reg_write_address;
  reg [31:0] data_wb;
  reg regwrite;
  wire [31:0] data_out1, data_out2;

  // Instantiate the register module
  register uut (
    .clk(clk),
    .reset(reset),
    .reg_address1(reg_address1),
    .reg_address2(reg_address2),
    .reg_write_address(reg_write_address),
    .data_wb(data_wb),
    .regwrite(regwrite),
    .data_out1(data_out1),
    .data_out2(data_out2)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Display task
  task display_regs;
    input [4:0] addr1, addr2;
    begin
      $display("Read Reg[%0d] = 0x%08x | Reg[%0d] = 0x%08x", 
                addr1, data_out1, addr2, data_out2);
    end
  endtask

  initial begin
    $display("Starting Register Testbench...\n");
    clk = 0;
    reset = 0;
    regwrite = 0;
    data_wb = 0;
    reg_write_address = 0;
    reg_address1 = 0;
    reg_address2 = 0;

    // Reset the register file
    #10 reset = 1;
    #10 reset = 0;
    #10 reset = 1;

    // Test write to register 5
    @(posedge clk);
    regwrite = 1;
    reg_write_address = 5;
    data_wb = 32'hAABBCCDD;

    // Wait one clock for write
    @(posedge clk);
    regwrite = 0;

    // Test write to register 10
    @(posedge clk);
    regwrite = 1;
    reg_write_address = 10;
    data_wb = 32'h12345678;
    @(posedge clk);
    regwrite = 0;

    // Read both registers
    reg_address1 = 5;
    reg_address2 = 10;
    #1;
    $display("Test read written registers:");
    display_regs(reg_address1, reg_address2);

    // Read from register 0 (should be 0 always)
    reg_address1 = 0;
    reg_address2 = 0;
    #1;
    $display("Test read register $zero (reg[0]):");
    display_regs(reg_address1, reg_address2);

    // Write to register 0 (should not change)
    @(posedge clk);
    regwrite = 1;
    reg_write_address = 0;
    data_wb = 32'hFFFFFFFF;
    @(posedge clk);
    regwrite = 0;

    // Read register 0 again (should still be 0)
    reg_address1 = 0;
    reg_address2 = 0;
    #1;
    $display("Test write to register $zero (should remain 0):");
    display_regs(reg_address1, reg_address2);

    $display("\nFinished Register Testbench.");
    $finish;
  end

endmodule