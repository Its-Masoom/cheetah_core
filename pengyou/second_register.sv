module second_register (
    input               clk ,rst,Stall,Flush,
    input  logic [31:0] AddrD, rdata1, rdata2, ImmExtD,
    input  logic [4:0] waddr,
    output logic [31:0] AddrE, rdata1E, rdata2E, ImmExtE,
    output logic [4:0] waddrE

);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrE   <= 32'b0;
            waddrE  <= 5'b0;
            rdata1E <= 32'b0;
            rdata2E <= 32'b0;
            ImmExtE <= 32'b0;

        end
        else if(Stall) begin
            AddrE   <= AddrE;
            waddrE  <= waddrE;
            rdata1E <= rdata1E;
            rdata2E <= rdata2E;
            ImmExtE <= ImmExtE;
        end
        else if (Flush) begin
            waddrE  <= 32'h00000013;
            rdata1E <= 32'h00000013;
            rdata2E <= 32'h00000013;
            ImmExtE <= 32'h00000013;
        end
        else begin
            AddrE   <= AddrD;
            waddrE  <= waddr;
            rdata1E <= rdata1;            
            rdata2E <= rdata2;
            ImmExtE <= ImmExtD;            

        end
    end
    
endmodule