module MuxResult (
    input  logic [1:0]  wb_selW, //From controller
    input  logic [31:0] ALUResultW, mem_out, AddrWplus4,
    output logic [31:0] wdata
);

always_comb begin 
    case (wb_selW)
       2'b00 : wdata = AddrWplus4;
       2'b01 : wdata = ALUResultW;
       2'b10 : wdata = mem_out;
    endcase
    end
endmodule

