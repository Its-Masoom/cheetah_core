module third_register (
    input  logic        clk ,rst, reg_wrE,
    input  logic [1:0]  wb_selE,
    input  logic [2:0]  funct3E,
    input  logic [4:0]  waddrE, 
    input  logic [6:0]  instr_opcodeE,
    input  logic [31:0] AddrE, ALUResult, rdata2E,
    output logic        reg_wrM,
    output logic [1:0]  wb_selM,
    output logic [2:0]  funct3M,
    output logic [4:0]  waddrM, 
    output logic [6:0]  instr_opcodeM,
    output logic [31:0] AddrM, ALUResultM, rdata2M
);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrM         <= 32'b0;
            waddrM        <= 5'b0;
            ALUResultM    <= 32'b0;
            rdata2M       <= 32'b0;
            reg_wrM       <= 1'b0;
            wb_selM       <= 2'b0;
            funct3M       <= 3'b0;
            instr_opcodeM <= 7'b0;
        end
        // else if(Stall) begin
        //     AddrM      <= AddrM;
        //     waddrM     <= waddrM;
        //     ALUResultM <= ALUResultM;
        //     rdata2M    <= rdata2M;
        // end
        // else if (Flush) begin
        //     waddrM     <= 32'h00000013;
        //     ALUResultM <= 32'h00000013;
        //     rdata2M    <= 32'h00000013;
        // end
        else begin
            AddrM         <= AddrE;
            waddrM        <= waddrE;
            ALUResultM    <= ALUResult;
            rdata2M       <= rdata2E;
            reg_wrM       <= reg_wrE;
            wb_selM       <= wb_selE;
            funct3M       <= funct3E;
            instr_opcodeM <= instr_opcodeE;
        end
    end
    
endmodule