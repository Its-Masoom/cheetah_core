module AddrPlus4 (
  input  logic [31:0] AddrW,
  output logic [31:0] AddrWplus4
);

  assign AddrWplus4 = AddrW + 4;
  
endmodule
