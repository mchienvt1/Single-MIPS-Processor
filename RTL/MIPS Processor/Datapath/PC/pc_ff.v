module pc_ff (
  input clk, reset,
  input [31:0] pcnext,
  output reg [31:0] pc
);


  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      pc <= 32'b0;
    end else begin
      pc <= pcnext;
    end
  end
endmodule