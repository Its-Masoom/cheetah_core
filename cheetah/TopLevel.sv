module TopLevel (input logic clk,rst);

    logic        reg_wr,sel_A,sel_B,cs,wr,br_taken, StallD, StallF, FlushD, FlushE,reg_wrE, sel_AE, sel_BE, reg_wrM, reg_wrW;
    logic [1:0]  wb_sel, wb_selE, wb_selM, wb_selW, For_A, For_B;
    logic [2:0]  ImmSrcD,funct3, funct3E, funct3M;
    logic [3:0]  mask;
    logic [4:0]  raddr1,raddr2,waddr,alu_op, waddrE, alu_opE, raddr1E, raddr2E, waddrM, waddrW;
    logic [6:0]  instr_opcode, instr_opcodeE, instr_opcodeM;
    logic [31:0] Addr,PC,Inst,PCF,wdata,rdata1,rdata2,ImmExtD,SrcA,SrcB,ALUResult,rdata,data_rd,addr,data_wr,toinstr_mem,toLSU,mem_out;
    logic [31:0] InstD, AddrD, AddrWplus4, AddrE, ImmExtE, rdata1E, rdata2E, AddrM, ALUResultM, AddrW, ALUResultW, rdataW;
    logic [31:0] SrcA_forward, SrcB_forward, SrcB_forwardM;

Mux_PC MuxPC(.PCF(PCF),.ALUResultM(ALUResultM),.br_taken(br_taken),.PC(PC));
program_counter ProgCouner (.clk(clk),.rst(rst),.PC(PC),.Addr(Addr), .StallF(StallF));
Instruction_Memory InstMem(.Addr(Addr),.addr(addr),.Inst(Inst),.toLSU(toLSU));
Instruction_Fetch Fetch(.InstD(InstD),.raddr1(raddr1),.raddr2(raddr2),.waddr(waddr));
PCPlus4 PCplus4 (.Addr(Addr),.PCF(PCF));
Register_file RegsiterFile(.clk(clk),.rst(rst),.reg_wrW(reg_wrW),.raddr1(raddr1),.raddr2(raddr2),.waddrW(waddrW),
    .wdata(wdata),.rdata1(rdata1),.rdata2(rdata2));
ALU Alu(.alu_opE(alu_opE),.SrcA(SrcA),.SrcB(SrcB),.ALUResult(ALUResult));
controller Controller(.InstD(InstD),.reg_wr(reg_wr),.sel_A(sel_A),.sel_B(sel_B),.wb_sel(wb_sel),.ImmSrcD(ImmSrcD),
.funct3(funct3),.alu_op(alu_op),.instr_opcode(instr_opcode));
LoadStore_Unit loadstore(.funct3M(funct3M),.instr_opcodeM(instr_opcodeM),.data_rd(data_rd),.SrcB_forwardM(SrcB_forwardM),
    .ALUResultM(ALUResultM),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.rdata(rdata));
Data_Memory Dmem(.clk(clk),.rst(rst),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.data_rd(data_rd));
immediate_gen Immediate(.InstD(InstD),.ImmSrcD(ImmSrcD),.ImmExtD(ImmExtD));
mux_selA MuxselA(.sel_AE(sel_AE),.SrcA_forward(SrcA_forward),.AddrE(AddrE),.SrcA(SrcA));
mux_selB MuxselB(.sel_BE(sel_BE),.ImmExtE(ImmExtE),.SrcB_forward(SrcB_forward),.SrcB(SrcB));
MuxResult Muxresult(.wb_selW(wb_selW),.ALUResultW(ALUResultW),.rdataW(rdataW),.AddrWplus4(AddrWplus4),.wdata(wdata));
BranchCond Branchcond(.funct3E(funct3E),.instr_opcodeE(instr_opcodeE),.SrcA_forward(SrcA_forward),.SrcB_forward(SrcB_forward),.br_taken(br_taken));
// Memory_mux Memory_mux(.toLSU(toLSU), .rdataW(rdataW), .addr(Addr), .mem_out(mem_out));
first_register first_register(.clk(clk) ,.rst(rst), .StallD(StallD), .FlushD(FlushD), .Addr(Addr), .Inst(Inst), .AddrD(AddrD), .InstD(InstD));
AddrPlus4 Addrplus4(.AddrW(AddrW),.AddrWplus4(AddrWplus4));
second_register second_register(
    .clk(clk) ,.rst(rst), .FlushE(FlushE), .reg_wr(reg_wr), .sel_A(sel_A), .sel_B(sel_B),
    .wb_sel(wb_sel),.funct3(funct3), .waddr(waddr), .alu_op(alu_op), .raddr1(raddr1), .raddr2(raddr2), 
    .instr_opcode(instr_opcode),.AddrD(AddrD), .rdata1(rdata1), .rdata2(rdata2), .ImmExtD(ImmExtD),
    .reg_wrE(reg_wrE), .sel_AE(sel_AE), .sel_BE(sel_BE),.wb_selE(wb_selE),.funct3E(funct3E),
    .waddrE(waddrE), .alu_opE(alu_opE), .raddr1E(raddr1E), .raddr2E(raddr2E), .instr_opcodeE(instr_opcodeE),
    .AddrE(AddrE), .rdata1E(rdata1E), .rdata2E(rdata2E), .ImmExtE(ImmExtE));
third_register third_register(
    .clk(clk) ,.rst(rst), .reg_wrE(reg_wrE),.wb_selE(wb_selE),.funct3E(funct3E),.waddrE(waddrE), .instr_opcodeE(instr_opcodeE),
    .AddrE(AddrE), .ALUResult(ALUResult), .SrcB_forward(SrcB_forward),.reg_wrM(reg_wrM),.wb_selM(wb_selM),.funct3M(funct3M),
    .waddrM(waddrM), .instr_opcodeM(instr_opcodeM),
    .AddrM(AddrM), .ALUResultM(ALUResultM), .SrcB_forwardM(SrcB_forwardM));
fourth_register fourth_register (
    .clk(clk) , .rst(rst), .reg_wrM(reg_wrM),.wb_selM(wb_selM),.waddrM(waddrM), .AddrM(AddrM), .ALUResultM(ALUResultM),
     .rdata(rdata),.reg_wrW(reg_wrW),.wb_selW(wb_selW),.waddrW(waddrW),.AddrW(AddrW), .ALUResultW(ALUResultW), .rdataW(rdataW));
forward_muxA forward_muxA(.For_A(For_A),.rdata1E(rdata1E), .ALUResultM(ALUResultM), .wdata(wdata),.SrcA_forward(SrcA_forward));
forward_muxB forward_muxB(.For_B(For_B),.rdata2E(rdata2E), .ALUResultM(ALUResultM), .wdata(wdata),.SrcB_forward(SrcB_forward));
Hazard_Unit Hazard_Unit(
    .reg_wrM(reg_wrM), .reg_wrW(reg_wrW), .br_taken(br_taken),.wb_selE(wb_selE),.raddr1(raddr1), .raddr2(raddr2),
    .raddr1E(raddr1E), .raddr2E(raddr2E), .waddrE(waddrE), .waddrM(waddrM), .waddrW(waddrW), .StallF(StallF), .StallD(StallD),
    .FlushE(FlushE), .FlushD(FlushD),.For_A(For_A), .For_B(For_B));
endmodule