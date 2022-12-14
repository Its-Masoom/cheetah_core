module Data_Memory( 
    input  logic         clk,rst,
    input  logic         cs,wr,Stall_MW_DM, 
    input  logic [3:0]   mask,
    input  logic [31:0]  addr,data_wr,
    output logic         valid_DM,
    output logic [31:0]  data_rd
);
    logic [31:0] data_mem [1023:0]; 

//Valid bit for stalling 
always_ff @(posedge clk) begin
    if( Stall_MW_DM) begin
        valid_DM <= 1'b1;
    end
    else begin
        valid_DM <= 1'b0;
    end
    end
    
//Asynchronous Data Memory Read for Load Operation
assign data_rd =((~cs) & (wr)) ? data_mem[addr] : '0;

//Synchronous write 
always_ff @ ( negedge clk ) begin 
    if (cs==0 && wr==0) begin
        if ( mask[0] )  data_mem [addr][7:0]   = data_wr [7:0];
        if ( mask[1] )  data_mem [addr][15:8]  = data_wr [15:8];
        if ( mask[2] )  data_mem [addr][23:16] = data_wr [23:16];    
        if ( mask[3] )  data_mem [addr][31:24] = data_wr [31:24];
    end     
end
endmodule
