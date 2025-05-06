module datapath (
  input clk, reset,
  input [31:0] instr,
  input [31:0] readData,
  input regWrite, aluSrc, jump, memtoReg, pcsrc, regdst,
  input [3:0] aluControl,
  output [31:0] pc,
  output [31:0] aluout,
  output [31:0] writeData,
  output zero
);

  wire [31:0] scra, scrb;
  wire [4:0] reg_write_address;
  wire [31:0] data_wb;

  pc_module pcmodule(
    .clk(clk),
    .reset(reset),
    .jump(jump),
    .pcsrc(pcsrc),
    .instr(instr[25:0]),
    .pc(pc) 
  );

  mux2to1 #(5) regdstmux(
    .a(instr[20:16]),
    .b(instr[15:11]),
    .sel(regdst),
    .out(reg_write_address)
  );

  register reg_inst(
    .clk(clk),
    .reset(reset),
    .regWrite(regWrite),
    .reg_address1(instr[25:21]),
    .reg_address2(instr[20:16]),
    .reg_write_address(reg_write_address),
    .data_wb(data_wb),
    .data_out1(scra),
    .data_out2(writeData)
  );

  mux2to1 #(32) aluSrcmux(
    .a(writeData),
    .b({{16{instr[15]}}, instr[15:0]}),
    .sel(aluSrc),
    .out(scrb)
  );

  mux2to1 #(32) memtoRegmux(
    .a(aluout),
    .b(readData),
    .sel(memtoReg),
    .out(data_wb)
  );

  alu alu_inst(
    .var1(scra),
    .var2(scrb),
    .aluControl(aluControl),
    .aluout(aluout),
    .zero(zero)
  );

endmodule