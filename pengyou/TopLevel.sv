module TopLevel (input logic clk,rst);

    logic        reg_wr, sel_A, sel_B, cs, wr, br_taken, StallF, StallD; 
    logic        FlushD, FlushE, reg_wrE, reg_wrM, reg_wrW, sel_AE, sel_BE;
    logic [1:0]  wb_sel, For_A, For_B, wb_selE, wb_selM, wb_selW;
    logic [2:0]  ImmSrcD, funct3, funct3E, funct3M;
    logic [3:0]  mask;
    logic [4:0]  raddr1, raddr2, waddr, waddrE, waddrM, waddrW, alu_op, alu_opE, raddr1E, raddr2E;
    logic [6:0]  instr_opcode, instr_opcodeE, instr_opcodeM;
    logic [31:0] Addr, PC, Inst, PCF, wdata, rdata1, rdata2, ImmExtD, SrcA, SrcB, ALUResult, rdata, data_rd, addr, data_wr, toinstr_mem, toLSU, mem_out;
    logic [31:0] AddrD, InstD, AddrE, rdata1E, rdata2E, ImmExtE, AddrM, ALUResultM, rdata2M, AddrW, ALUResultW, rdataW, SrcA_forward, SrcB_forward;

Mux_PC MuxPC(
    .PCF(PCF),
    .ALUResultM(ALUResultM),
    .br_taken(br_taken),
    .PC(PC)
    );

program_counter ProgCounter(
    .clk(clk),
    .rst(rst),
    .PC(PC),
    .Addr(Addr),
    .StallF(StallF)
    );

Instruction_Memory InstMem(
    .Addr(Addr),
    .addr(addr),
    .Inst(Inst),
    .toLSU(toLSU)
    );

Instruction_Fetch Fetch(
    .InstD(InstD),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(waddr)
    );

PCPlus4 PCplus4(
    .Addr(Addr),
    .PCF(PCF)
    );

Register_file RegsiterFile(
    .clk(clk),
    .rst(rst),
    .reg_wrW(reg_wrW),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(waddrW),
    .wdata(wdata),
    .rdata1(rdata1),
    .rdata2(rdata2)
    );

ALU Alu(
    .alu_opE(alu_opE),
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUResult(ALUResult)
    );

controller Controller(
    .InstD(InstD),
    .reg_wr(reg_wr),
    .sel_A(sel_A),
    .sel_B(sel_B),
    .wb_sel(wb_sel),
    .ImmSrcD(ImmSrcD),
    .funct3(funct3),
    .alu_op(alu_op),
    .instr_opcode(instr_opcode)
    );

LoadStore_Unit loadstore(
    .funct3M(funct3M),
    .instr_opcodeM(instr_opcodeM),
    .data_rd(data_rd),
    .rdata2M(rdata2M),
    .ALUResultM(ALUResultM),
    .cs(cs),
    .wr(wr),
    .mask(mask),
    .addr(addr),
    .data_wr(data_wr),
    .rdata(rdata)
    );

Data_Memory Dmem(
    .clk(clk),
    .rst(rst),
    .cs(cs),
    .wr(wr),
    .mask(mask),
    .addr(addr),
    .data_wr(data_wr),
    .data_rd(data_rd)
    );

immediate_gen Immediate(
    .InstD(InstD),
    .ImmSrcD(ImmSrcD),
    .ImmExtD(ImmExtD)
    );

mux_selA MuxselA(
    .sel_AE(sel_AE),
    .SrcA_forward(SrcA_forward),
    .AddrE(AddrE),
    .SrcA(SrcA)
    );

mux_selB MuxselB(
    .sel_BE(sel_BE),
    .ImmExtE(ImmExtE),
    .SrcB_forward(SrcB_forward),
    .SrcB(SrcB)
    );

MuxResult Muxresult(
    .wb_selW(wb_selW),
    .ALUResultW(ALUResultW),
    .mem_out(mem_out),
    .AddrWplus4(AddrWplus4),
    .wdata(wdata)
    );

BranchCond Branchcond(
    .funct3E(funct3E),
    .instr_opcodeE(instr_opcodeE),
    .rdata1E(rdata1E),
    .rdata2E(rdata2E),
    .br_taken(br_taken)
    );

Memory_mux Memory_mux(
    .toLSU(toLSU),
    .rdataW(rdataW),
    .addr(Addr),
    .mem_out(mem_out)
    );

first_register  First_Register(
    .clk(clk),
    .rst(rst),
    .StallD(StallD),
    .FlushD(FlushD),
    .Addr(Addr),
    .AddrD(AddrD),
    .Inst(Inst),
    .InstD(InstD)
    );

second_register Second_Register(
    .clk(clk),
    .rst(rst),
    .FlushE(FlushE),
    .AddrD(AddrD),
    .AddrE(AddrE),
    .waddr(waddr),
    .waddrE(waddrE),
    .rdata1(rdata1),
    .rdata2(rdata2),
    .ImmExtD(ImmExtD),
    .rdata1E(rdata1E),
    .rdata2E(rdata2E),
    .ImmExtE(ImmExtE), 
    .reg_wr(reg_wr),
    .reg_wrE(reg_wrE),
    .sel_A(sel_A),
    .sel_B(sel_B), 
    .sel_AE(sel_AE),
    .sel_BE(sel_BE),
    .wb_sel(wb_sel),
    .wb_selE(wb_selE), 
    .funct3(funct3),
    .funct3E(funct3E), 
    .alu_op(alu_op),
    .alu_opE(alu_opE),
    .instr_opcode(instr_opcode),
    .instr_opcodeE(instr_opcodeE),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .raddr1E(raddr1E),
    .raddr2E(raddr2E)
    );

third_register  Third_Register(
    .clk(clk),
    .rst(rst),
    .AddrE(AddrE), 
    .AddrM(AddrM),
    .waddrE(waddrE),
    .waddrM(waddrM), 
    .ALUResult(ALUResult),
    .ALUResultM(ALUResultM),
    .rdata2E(rdata2E), 
    .rdata2M(rdata2M), 
    .reg_wrE(reg_wrE),
    .reg_wrM(reg_wrM),
    .wb_selE(wb_selE),
    .wb_selM(wb_selM),
    .funct3E(funct3E),
    .funct3M(funct3M),
    .instr_opcodeE(instr_opcodeE),
    .instr_opcodeM(instr_opcodeM)
    );

fourth_register Fourth_Register(
    .clk(clk), 
    .rst(rst),
    .AddrM(AddrM),
    .AddrW(AddrW), 
    .waddrM(waddrM), 
    .waddrW(waddrW), 
    .ALUResultM(ALUResultM),
    .ALUResultW(ALUResultW),
    .rdata(rdata), 
    .rdataW(rdataW), 
    .reg_wrM(reg_wrM),
    .reg_wrW(reg_wrW), 
    .wb_selM(wb_selM),
    .wb_selW(wb_selW)
    );

AddrPlus4 AddrPlus4(
    .AddrW(AddrW), 
    .AddrWplus4(AddrWplus4)
    );

forward_muxA Forward_MuxA(
    .rdata1E(rdata1E), 
    .ALUResultM(ALUResultM), 
    .wdata(wdata), 
    .For_A(For_A),
    .SrcA_forward(SrcA_forward)
    );

forward_muxB Forward_MuxB(
    .rdata2E(rdata2E), 
    .ALUResultM(ALUResultM), 
    .wdata(wdata), 
    .For_B(For_B), 
    .SrcB_forward(SrcB_forward)
    );

Hazard_Unit Hazard_Unit(
    .reg_wrM(reg_wrM), 
    .reg_wrW(reg_wrW), 
    .br_taken(br_taken),         
    .wb_selE(wb_selE),                
    .raddr1(raddr1), 
    .raddr2(raddr2), 
    .raddr1E(raddr1E), 
    .raddr2E(raddr2E), 
    .waddrE(waddrE), 
    .waddrM(waddrM), 
    .waddrW(waddrW), 
    .StallF(StallF), 
    .StallD(StallD), 
    .FlushE(FlushE),
    .FlushD(FlushD),
    .For_A(For_A),
    .For_B(For_B)   
    );

endmodule