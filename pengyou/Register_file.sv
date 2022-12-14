module Register_file (
     input logic         clk,rst,reg_wrMW,
     input logic  [4:0]  raddr1,raddr2,waddr_MW,
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
  always_ff @(negedge clk) begin
    if (reg_wrMW && (|waddr_MW)) begin
        register_file[waddr_MW] <= wdata;
    end 
  end

endmodule