module forward_muxB(
  input  logic [31:0] rdata2E, ALUResultM, wdata,
  input  logic [1:0] For_B,
  output logic [31:0] SrcB_forward
);
always_comb begin
    case (For_B)
        2'b00 : SrcB_forward = ALUResultM;
        2'b01 : SrcB_forward = rdata2E;
        2'b10 : SrcB_forward = wdata;
    endcase
end

endmodule