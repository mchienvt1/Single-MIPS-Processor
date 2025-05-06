module dataMemory (
  input clk,
  input memWrite,
  input [31:0] address,
  input [31:0] writeData,
  output [31:0] readData
);

  reg [31:0] data_memory [31:0];

  always @(posedge clk) begin
    if (memWrite) begin
      data_memory[address[31:2]] <= writeData; // Store the write data at the address
    end
  end

  assign readData = data_memory[address[31:2]];

endmodule