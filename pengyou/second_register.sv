module second_register (
    input               clk ,rst, Flush, reg_wr, sel_A, sel_B,
    input  logic [1:0]  wb_sel,
    input  logic [2:0]  funct3,
    input  logic [4:0]  waddr, alu_op,
    input  logic [6:0]  instr_opcode,
    input  logic [31:0] AddrD, rdata1, rdata2, ImmExtD,
    output logic        reg_wrE, sel_AE, sel_BE,
    output logic [1:0]  wb_selE,
    output logic [2:0]  funct3E,
    output logic [4:0]  waddrE, alu_opE,
    output logic [6:0]  instr_opcodeE,
    output logic [31:0] AddrE, rdata1E, rdata2E, ImmExtE

);
    always_ff @( posedge clk ) begin 
     
        if(rst) begin
            AddrE         <= 32'b0;
            waddrE        <= 5'b0;
            rdata1E       <= 32'b0;
            rdata2E       <= 32'b0;
            ImmExtE       <= 32'b0;
            reg_wrE       <= 1'b0;
            sel_AE        <= 1'b0;
            sel_BE        <= 1'b0;
            wb_selE       <= 2'b0;
            funct3E       <= 3'b0;
            alu_opE       <= 5'b0;
            instr_opcodeE <= 7'b0;

        end
        // else if(Stall) begin
        //     AddrE   <= AddrE;
        //     waddrE  <= waddrE;
        //     rdata1E <= rdata1E;
        //     rdata2E <= rdata2E;
        //     ImmExtE <= ImmExtE;
        // end
        else if (Flush) begin
            waddrE        <= 32'h00000013;
            rdata1E       <= 32'h00000013;
            rdata2E       <= 32'h00000013;
            ImmExtE       <= 32'h00000013;
            reg_wrE       <= 32'h00000013;
            sel_AE        <= 32'h00000013;
            sel_BE        <= 32'h00000013;
            wb_selE       <= 32'h00000013;
            funct3E       <= 32'h00000013;
            alu_opE       <= 32'h00000013;
            instr_opcodeE <= 32'h00000013;
        end
        else begin
            AddrE         <= AddrD;
            waddrE        <= waddr;
            rdata1E       <= rdata1;            
            rdata2E       <= rdata2;
            ImmExtE       <= ImmExtD;
            reg_wrE       <= reg_wr; 
            sel_AE        <= sel_A;
            sel_BE        <= sel_B;  
            wb_selE       <= wb_sel; 
            funct3E       <= funct3;
            alu_opE       <= alu_op; 
            instr_opcodeE <= instr_opcode;       

        end
    end
    
endmodule