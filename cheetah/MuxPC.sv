module Mux_PC (
    input logic         br_taken,              //signal from controller
    input logic  [31:0] PCF,ALUResultM,
    output logic [31:0] PC
);
 always_comb 
 begin 
    case (br_taken)
        1'b0 :   PC = PCF;
        1'b1 :   PC = ALUResultM; 
        default: PC = PCF;
    endcase
 end 
endmodule