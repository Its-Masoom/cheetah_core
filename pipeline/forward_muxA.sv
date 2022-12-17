module forward_muxA(
  input  logic [1:0]  For_A,
  input  logic [31:0] rdata1E, ALUResultM, wdata,
  output logic [31:0] SrcA_forward
);
always_comb begin
    case (For_A)
        2'b00 : SrcA_forward = ALUResultM;
        2'b01 : SrcA_forward = rdata1E;
        2'b10 : SrcA_forward = wdata;
    endcase
end

endmodule