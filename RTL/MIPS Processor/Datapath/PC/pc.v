module pc_module (
  input clk, reset, pcsrc, jump,
  input [25:0] instr,
  output [31:0] pc
);

  wire [31:0] pcnext_temp;
  wire [31:0] pcnext, pcadder4, pcjump, pcbranch; 

  pc_ff pcff (clk, reset, pcnext, pc);
  pcadder4 #(32) pcadd (pc, pcadder4);
  pcbranch #(32) pcbr (instr[15:0], pcadder4, pcbranch);
  mux2to1 #(32) branchmux (pcadder4, pcbranch, pcsrc, pcnext_temp);
  pcjump #(32) pcjump_inst (instr[25:0], pcadder4, pcjump);
  mux2to1 #(32) jumpmux (pcnext_temp, pcjump, jump, pcnext);
  

endmodule