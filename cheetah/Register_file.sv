module Register_file (
     input logic         clk,rst,reg_wrW,
     input logic  [4:0]  raddr1,raddr2,waddrW,
     input logic  [31:0] wdata,
     output logic [31:0] rdata1,rdata2
);
    logic [31:0] register_file[31:0];

//Asynchronous Read 
    always_comb begin
        rdata1 = (|raddr1) ? register_file[raddr1] : '0 ;
        rdata2 = (|raddr2) ? register_file[raddr2] : '0 ;
    end

//Synchronous Write
  integer i;
  always_ff @(negedge clk) begin
    if (reg_wrW && (|waddrW)) begin
        register_file[waddrW] <= wdata;
    end
    //else if (rst) begin
    //  for(i = 1; i <= 32; i = i + 1)
    //    register_file[i] <= 32'd0;
   // end 
  end

endmodule