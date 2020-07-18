// ---------------------------------------------
// Design Name : TB 4 Moore State Machine
// File Name   : ExampleFSM_TB.sv
// Coder       : Soumya Ranjan Mondal
// ----------------------------------------------

`timescale 1ns/1ns

module ExampleFSM_TB;

  logic clk;
  logic reset;
  logic in;
  
  logic out;

  ExampleFSM dut(.clk(clk), .reset(reset), .X(in), .Y(out));


  always
      #5 clk = ~clk;
  initial
    begin
    clk = 1'b0;
    end  

  initial
    begin
      $monitor($time,"ns: X=%b Y=%b",in,out);
      $dumpfile("dump.vcd");
      $dumpvars(1);
      reset <= 1; #12;
      reset <= 0; in <= 0; #10;
      in <= 1; #10;
      in <= 1; #10;
      in <= 1; #10;
      in <= 1; #10;
      $finish;
    end

endmodule