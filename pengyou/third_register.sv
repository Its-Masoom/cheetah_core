module third_register (
    input               clk ,rst,Stall,Flush,
    input  logic [31:0] AddrE, ALUResult, rdata2E,
    input  logic [4:0]  waddrE,
    output logic [31:0] AddrM, ALUResultM, rdata2M,
    output logic [4:0]  waddrM 
);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrM      <= 32'b0;
            waddrM     <= 5'b0;
            ALUResultM <= 32'b0;
            rdata2M    <= 32'b0;
        end
        else if(Stall) begin
            AddrM      <= AddrM;
            waddrM     <= waddrM;
            ALUResultM <= ALUResultM;
            rdata2M    <= rdata2M;
        end
        else if (Flush) begin
            waddrM     <= 32'h00000013;
            ALUResultM <= 32'h00000013;
            rdata2M    <= 32'h00000013;
        end
        else begin
            AddrM      <= AddrE;
            waddrM     <= waddrE;
            ALUResultM <= ALUResult;
            rdata2M    <= rdata2E;
        end
    end
    
endmodule