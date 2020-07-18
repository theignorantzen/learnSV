// --- Basic 8-bit parity checker ----
// Gives 0 for even number of 1s
// and 1 for odd number of 1s

module parity_checker(input wire [7:0] data_in,
                      output wire parity_out);

assign parity_out = ^data_in;

endmodule