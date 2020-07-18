`include "interface.sv"
`include "random_test.sv"
module tbench_top;
  
  bit clk;
  bit reset;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset
  initial begin
    reset = 1;
    #5 reset =0;
  end
  
  mem_intf intf(clk,reset);
  
  test t1(intf);
  
  memory DUT (
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );
  
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule