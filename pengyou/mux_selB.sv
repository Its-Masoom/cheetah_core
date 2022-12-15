module mux_selB (
    input logic         sel_B, //from controller
    input logic  [31:0] ImmExtE,SrcB_forward,
    output logic [31:0] SrcB
);

always_comb begin 
    case (sel_B)
       1'b0 : SrcB = SrcB_forward;
       1'b1 : SrcB = ImmExtE;
    endcase
    
end
    
endmodule

