module instructionMemory (
  input [31:0] pc,
  output [31:0] instr
);

  reg [31:0] instr_memory [0:31];

  initial begin
    $readmemh("Verification/top/instrMem_2.mem", instr_memory); // Đường dẫn từ gốc project
  end

  assign instr = instr_memory[pc[31:2]];

endmodule