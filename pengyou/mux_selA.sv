module mux_selA (
    input  logic        sel_AE, //from controller
    input  logic [31:0] SrcA_forward, AddrE,
    output logic [31:0] SrcA
);
always_comb begin 
    case (sel_AE)
       1'b0 : SrcA = AddrE;
       1'b1 : SrcA = SrcA_forward;
    endcase  
end
endmodule

