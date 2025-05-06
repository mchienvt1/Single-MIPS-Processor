module register(
  input clk, reset,
  input [4:0] reg_address1,
  input [4:0] reg_address2,
  input [4:0] reg_write_address,
  input [31:0] data_wb,
  input regWrite,
  output [31:0] data_out1,
  output [31:0] data_out2
);

  reg [31:0] REGISTER[31:0];

  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      for(integer i = 0; i < 32; i = i + 1) begin
        REGISTER[i] <= 32'b0;
      end
    end
    else if (regWrite) begin
      if(reg_write_address != 0) begin
        // Write to register only if reg_write_address is not zero
        REGISTER[reg_write_address] <= data_wb;
      end
      else begin
        // Attempt to write to register 0 (should not change)
        REGISTER[0] <= 32'b0;
      end
    end
  end

  assign data_out1 = REGISTER[reg_address1];
  assign data_out2 = REGISTER[reg_address2];

endmodule