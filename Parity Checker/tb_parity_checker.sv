// --- Test bench for the parity ---

module tb_parity;

  reg [7:0] in;
  reg out;

  parity_checker dut(.data_in(in), .parity_out(out));
  
  initial
    begin
      $monitor ($time,"ns: in=%b out=%b", in, out);
      in = 8'b01010101; #10;
      in = 8'b00000111; #10;
      in = 8'b00001111; #10;
      in = 8'b01101101; #10;
      $finish;
    end
endmodule