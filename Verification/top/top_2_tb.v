module top_2_tb;
  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [31:0] pc;
  wire [31:0] aluout;
  wire [31:0] readdata;
  wire [31:0] writedata;

  // Error counter
  integer err_cnt = 0;

  // Instantiate the Unit Under Test (UUT)
  singleMIPS uut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .aluout(aluout),
    .readData(readdata),
    .writeData(writedata)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Initial setup and reset
  initial begin
    $display("Simulation starts!!!!");
    reset = 0;
    #10;
    reset = 1;
  end

  // Monitor and check results
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      if (pc != 0) begin
        $display("FAIL at reset testcase: PC = %h (expected 0x00)", pc);
        err_cnt = err_cnt + 1;
      end
    end else begin
      if (pc == 32'h00) begin // addi $2, $0, 5
        if (aluout !== 5) begin
          $display("FAIL at PC = 0x00: $2 = %d (expected 5), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h04) begin // addi $3, $0, 12
        if (aluout !== 12) begin
          $display("FAIL at PC = 0x04: $3 = %d (expected 12), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h08) begin // addi $7, $3, -9
        if (aluout !== 3) begin
          $display("FAIL at PC = 0x08: $7 = %d (expected 3), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h0C) begin // or $4, $7, $3
        if (aluout !== 7) begin
          $display("FAIL at PC = 0x0C: $4 = %d (expected 7), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h10) begin // and $5, $3, $4
        if (aluout !== 4) begin
          $display("FAIL at PC = 0x10: $5 = %d (expected 4), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h14) begin // add $5, $4, $7
        if (aluout !== 11) begin
          $display("FAIL at PC = 0x14: $5 = %d (expected 11), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h18) begin // beq $5, $7, end
        #1;
        if (pc != 32'h1c) begin
          $display("FAIL at PC = 0x18: Incorrect branch taken to 0x%h, readdata = %d, writedata = %d", pc, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h1C) begin // slt $4, $3, $4
        if (aluout !== 0) begin
          $display("FAIL at PC = 0x1C: $4 = %d (expected 0), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h20) begin // beq $4, $0, around
        #1;
        if (pc != 32'h28) begin
          $display("FAIL at PC = 0x20: Incorrect branch taken to 0x%h, readdata = %d, writedata = %d", pc, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h24) begin // addi $5, $0, 0
        if (aluout !== 0) begin
          $display("FAIL at PC = 0x24: $5 = %d (expected 0), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h28) begin // slt $4, $7, $2
        if (aluout !== 1) begin
          $display("FAIL at PC = 0x28: $4 = %d (expected 1), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h2C) begin // add $7, $1, $2
        if (aluout !== 12) begin
          $display("FAIL at PC = 0x2C: $7 = %d (expected 12), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h30) begin // sub $7, $7, $2
        if (aluout !== 7) begin
          $display("FAIL at PC = 0x30: $7 = %d (expected 7), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h34) begin // sw $7, 68($3)
        $display("SW at PC = 0x34: writedata = %d to address %d", writedata, aluout);
      end
      else if (pc == 32'h38) begin // lw $2, 80($0)
        if (aluout !== 80) begin
          $display("FAIL at PC = 0x38: address = %d (expected 80), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h3c) begin // j end
        #1;
        if (pc !== 32'h44) begin
          $display("FAIL at PC = 0x3C: Incorrect jump to 0x%h, readdata = %d, writedata = %d", pc, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h3c) begin // addi $4, $2, 2
        if (aluout !== 9) begin
          $display("FAIL at PC = 0x3c: $4 = %d (expected 9), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else if (pc == 32'h40) begin // addi $2, $0, 1
        $display("Fail Jump instruction, readdata = %d, writedata = %d", readdata, writedata);
        err_cnt = err_cnt + 1;
      end
      else if (pc == 32'h44) begin // addi $4, $2, 2
        if (aluout !== 9) begin
          $display("FAIL at PC = 0x44: $4 = %d (expected 9), readdata = %d, writedata = %d", aluout, readdata, writedata);
          err_cnt = err_cnt + 1;
        end
      end
      else begin
        $display("Unknown PC value: 0x%h, readdata = %d, writedata = %d", pc, readdata, writedata);
      end
    end
  end

  initial begin
    $monitor("PC: %h, ALU Out: %d, ReadData: %d, WriteData: %d", pc, aluout, readdata, writedata);
    #180;
    if (err_cnt == 0)
      $display("All tests passed.");
    else
      $display("%d errors found.", err_cnt);
    $stop;
  end
endmodule