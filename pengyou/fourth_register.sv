module fourth_register (
    input               clk ,rst,Stall,
    input  logic [31:0] AddrM, ALUResultM, rdata,
    input  logic [4:0]  waddrM, 
    output logic [31:0] AddrW, ALUResultW, rdataW,
    output logic [4:0]  waddrW
);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrW      <= 32'b0;
            waddrW     <= 5'b0;
            ALUResultW <= 32'b0;
            rdataW     <= 32'b0;
        end
        else if(Stall) begin
            AddrW      <= AddrW;
            waddrW     <= waddrW;
            ALUResultW <= ALUResultW;
            rdataW     <= rdataW;
        end
        // else if (Flush) begin
        //     waddrM <= 32'h00000013;
        // end
        else begin
            AddrW      <= AddrM;
            waddrW     <= waddrM;
            ALUResultW <= ALUResultM;
            rdataW     <= rdata;
        end
    end
endmodule