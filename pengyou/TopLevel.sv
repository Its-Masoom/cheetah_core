module TopLevel (input logic clk,rst);

    logic        PCsrc,reg_wr,sel_A,sel_B,cs,wr,br_taken, Stall, Flush;
    logic [1:0]  wb_sel, For_A, For_B;
    logic [2:0]  ImmSrcD,funct3;
    logic [3:0]  mask;
    logic [4:0]  raddr1,raddr2,waddr,waddrE, waddrM, waddrW,alu_op;
    logic [6:0]  instr_opcode;
    logic [31:0] Addr,PC,Inst,PCF,wdata,rdata1,rdata2,ImmExtD,SrcA,SrcB,ALUResult,rdata,data_rd,addr,data_wr,toinstr_mem,toLSU,mem_out;
    logic [31:0] AddrD, InstD, AddrE, rdata1E, rdata2E, ImmExtE, AddrM, ALUResultM, rdata2M, AddrW, ALUResultW, rdataW, SrcA_forward, SrcB_forward;

Mux_PC MuxPC(.PCF(PCF),.ALUResultM(ALUResultM),.PCsrc(PCsrc),.PC(PC));
program_counter ProgCouner (.clk(clk),.rst(rst),.PC(PC),.Addr(Addr));
Instruction_Memory InstMem(.Addr(Addr),.addr(addr),.Inst(Inst),.toLSU(toLSU));
Instruction_Fetch Fetch(.InstD(InstD),.raddr1(raddr1),.raddr2(raddr2),.waddr(waddr));
PCPlus4 PCplus4 (.Addr(Addr),.PCF(PCF));
Register_file RegsiterFile(.clk(clk),.rst(rst),.reg_wr(reg_wr),.raddr1(raddr1),.raddr2(raddr2),.waddr(waddrW),.wdata(wdata),.rdata1(rdata1),.rdata2(rdata2));
ALU Alu(.alu_op(alu_op),.SrcA(SrcA),.SrcB(SrcB),.ALUResult(ALUResult));
controller Controller(.br_taken(br_taken),.Inst(Inst),.PCsrc(PCsrc),.reg_wr(reg_wr),.sel_A(sel_A),.sel_B(sel_B),.wb_sel(wb_sel),.ImmSrcD(ImmSrcD),
.funct3(funct3),.alu_op(alu_op),.instr_opcode(instr_opcode));
LoadStore_Unit loadstore(.funct3(funct3),.instr_opcode(instr_opcode),.data_rd(data_rd),.rdata2M(rdata2M),.ALUResultM(ALUResultM),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.rdata(rdata));
Data_Memory Dmem(.clk(clk),.rst(rst),.cs(cs),.wr(wr),.mask(mask),.addr(addr),.data_wr(data_wr),.data_rd(data_rd));
immediate_gen Immediate(.Inst(Inst),.ImmSrcD(ImmSrcD),.ImmExtD(ImmExtD));
mux_selA MuxselA(.sel_A(sel_A),.SrcA_forward(SrcA_forward),.AddrE(AddrE),.SrcA(SrcA));
mux_selB MuxselB(.sel_B(sel_B),.ImmExtE(ImmExtE),.SrcB_forward(SrcB_forward),.SrcB(SrcB));
MuxResult Muxresult(.wb_sel(wb_sel),.ALUResultW(ALUResultW),.mem_out(mem_out),.AddrWplus4(AddrWplus4),.wdata(wdata));
BranchCond Branchcond(.funct3(funct3),.instr_opcode(instr_opcode),.rdata1E(rdata1E),.rdata2E(rdata2E),.br_taken(br_taken));
Memory_mux Memory_mux(.toLSU(toLSU), .rdataW(rdataW), .addr(Addr), .mem_out(mem_out));
first_register  First_Register (.clk(clk), .rst(rst), .Stall(Stall), .Flush(Flush), .Addr(Addr), .AddrD(AddrD), .Inst(Inst), .InstD(InstD));
second_register Second_Register(.clk(clk), .rst(rst), .Stall(Stall), .Flush(Flush), .AddrD(AddrD), .AddrE(AddrE), .waddr(waddr), .waddrE(waddrE), .rdata1(rdata1), .rdata2(rdata2), .ImmExtD(ImmExtD), .rdata1E(rdata1E), .rdata2E(rdata2E), .ImmExtE(ImmExtE));
third_register  Third_Register (.clk(clk), .rst(rst), .Stall(Stall), .Flush(Flush), .AddrE(AddrE), .AddrM(AddrM), .waddrE(waddrE), .waddrM(waddrM), .ALUResult(ALUResult), .ALUResultM(ALUResultM), .rdata2E(rdata2E), .rdata2M(rdata2M));
fourth_register Fourth_Register(.clk(clk), .rst(rst), .Stall(Stall), .AddrM(AddrM), .AddrW(AddrW), .waddrM(waddrM), .waddrW(waddrW), .ALUResultM(ALUResultM), .ALUResultW(ALUResultW), .rdata(rdata), .rdataW(rdataW));
AddrPlus4 AddrPlus4(.AddrW(AddrW), .AddrWplus4(AddrWplus4));
forward_muxA Forward_MuxA (.rdata1E(rdata1E), .ALUResultM(ALUResultM), .wdata(wdata), .For_A(For_A), .SrcA_forward(SrcA_forward));
forward_muxB Forward_MuxB (.rdata2E(rdata2E), .ALUResultM(ALUResultM), .wdata(wdata), .For_B(For_B), .SrcB_forward(SrcB_forward));

endmodule