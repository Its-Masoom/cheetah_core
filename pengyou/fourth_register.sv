module fourth_register (
    input               clk , rst, reg_wrM,
    input  logic [1:0]  wb_selM,
    input  logic [4:0]  waddrM, 
    input  logic [31:0] AddrM, ALUResultM, rdata,
    output logic        reg_wrW,
    output logic [1:0]  wb_selW,
    output logic [4:0]  waddrW,
    output logic [31:0] AddrW, ALUResultW, rdataW
);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrW      <= 32'b0;
            waddrW     <= 5'b0;
            ALUResultW <= 32'b0;
            rdataW     <= 32'b0;
            reg_wrW    <= 1'b0;
            wb_selW    <= 2'b0;
        end else begin
            AddrW      <= AddrM;
            waddrW     <= waddrM;
            ALUResultW <= ALUResultM;
            rdataW     <= rdata;
            reg_wrW    <= reg_wrM;
            wb_selW    <= wb_selM;
        end
    end
endmodule