module memory
  (
    input clk,
    input reset,
    input [1:0]  addr,
    input wr_en,
    input rd_en,
    input  [7:0] wdata,
    output [7:0] rdata
  ); 
  
  reg [7:0] rdata;
  
  reg [7:0] mem [4];
 
  always @(posedge reset) 
    for(int i=0;i<4;i++) mem[i]=8'hFF;
   
  always @(posedge clk) 
    if (wr_en)    mem[addr] <= wdata;

  always @(posedge clk)
    if (rd_en) rdata <= mem[addr];

endmodule