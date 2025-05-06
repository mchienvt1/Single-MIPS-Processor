module top_0_tb;
  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] readData;
  wire [31:0] writeData;

  integer err_cnt = 0;

  // Instantiate the Unit Under Test (UUT)
  singleMIPS uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .aluout(aluout),
    .readData(readData),
    .writeData(writeData)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Apply reset
  initial begin
    reset = 0;
    #10;
    reset = 1;
  end

  // Test sequence
  always @(posedge clk or negedge reset) begin
    if (!reset) $display("Reset Active!!!");

    // Các kiểm thử dựa theo giá trị PC
    if (pc == 32'h00 && aluout !== 0) begin
      $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h04 && aluout !== 2) begin
      $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h08 && aluout !== 4) begin
      $display("Error at PC: %h, aluout: %d (Expected: 4)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h0C && aluout !== 1) begin
      $display("Error at PC: %h, aluout: %d (Expected: 1)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h10 && aluout !== 3) begin
      $display("Error at PC: %h, aluout: %d (Expected: 3)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h14 && aluout !== 2) begin
      $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h18 && aluout !== 2) begin
      $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h1C && aluout !== 2) begin
      $display("Error at PC: %h, aluout: %d (Expected: 2)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
    if (pc == 32'h20 && aluout !== 0) begin
      $display("Error at PC: %h, aluout: %d (Expected: 0)", pc, aluout);
      err_cnt = err_cnt + 1;
    end
  end

  // Final report
  initial begin
    $display("Simulation starts!!!!");
    $monitor("PC: %h, ALU Out: %d", pc, aluout);

    #110;
    reset = 1'b0;
    #10;
    reset = 1'b1;

    #100;
    if (err_cnt == 0) begin
      $display("All tests passed.");
    end else begin
      $display("%d errors found.", err_cnt);
    end
    $stop;
  end
endmodule
