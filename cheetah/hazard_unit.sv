module Hazard_Unit(
  input  logic       reg_wrM, reg_wrW, br_taken,         
  input  logic [1:0] wb_selE,                
  input  logic [4:0] raddr1, raddr2, raddr1E, raddr2E, waddrE, waddrM, waddrW, 
  output logic       StallF, StallD, FlushE, FlushD,
  output logic [1:0] For_A, For_B   
);

  logic lwStall;

  always_comb begin 
    if (((raddr1E == waddrM) && reg_wrM) && (raddr1E != 0)) begin
      For_A <= 2'b00;
    end else if (((raddr1E == waddrW) && reg_wrW) && (raddr1E != 0)) begin
      For_A <= 2'b10;
    end else begin
      For_A <= 2'b01;
    end
  end

  always_comb begin 
    if (((raddr2E == waddrM) && reg_wrM) && (raddr2E != 0)) begin
      For_B <= 2'b00;
    end else if (((raddr2E == waddrW) && reg_wrW) && (raddr2E != 0)) begin
      For_B <= 2'b10;
    end else begin
      For_B <= 2'b01;
    end
  end

  always_comb begin  //Stall when a load hazard occur
    lwStall = (wb_selE[1] & ((raddr1 == waddrE) | (raddr2 == waddrE)));
    StallD  = lwStall;
    StallF  = lwStall;
    //Flush When a branch is taken or a load initroduces a bubble
    FlushE  = lwStall | br_taken;
    FlushD  = br_taken;
  end

endmodule