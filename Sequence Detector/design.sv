//Desin Code for secuence detection
module Sequence_Detector(seq_interface.DUT seq_int_i);
  typedef enum bit[2:0] {ZERO, ONE, ONE_ZERO, ONE_ZERO_ONE, ONE_ZERO_ONE_ONE} SEQ_e;
  reg [2:0] current_state, next_state;

//Current state sequential logic
  always @(posedge seq_int_i.clock, posedge seq_int_i.reset) begin
    if(seq_int_i.reset==0) current_state <= ZERO;
    else current_state <= next_state;
  end

//Next state logic
  always_comb begin
    case (current_state)
      ZERO: begin
        if(seq_int_i.sequence_in==1) next_state <= ONE;
        else next_state <= ZERO;
      end
      ONE: begin
        if(seq_int_i.sequence_in==0) next_state <= ONE_ZERO;
        else next_state <= ONE;
      end
      ONE_ZERO: begin
        if(seq_int_i.sequence_in==0) next_state <= ZERO;
        else next_state <= ONE_ZERO_ONE;
      end
      ONE_ZERO_ONE: begin
        if(seq_int_i.sequence_in==0) next_state <= ONE_ZERO;
        else next_state <= ONE_ZERO_ONE_ONE;
      end
      ONE_ZERO_ONE_ONE: begin
        if(seq_int_i.sequence_in==0) next_state <= ONE_ZERO;
        else next_state <= ONE;
      end
      default next_state <= ZERO;
    endcase
  end

//Combinational logic to determine the output
  always @(current_state)begin
    case(current_state)
      ZERO : seq_int_i.detector_out<=0;
      ONE : seq_int_i.detector_out<=0;
      ONE_ZERO : seq_int_i.detector_out<=0;
      ONE_ZERO_ONE : seq_int_i.detector_out<=0;
      ONE_ZERO_ONE_ONE : seq_int_i.detector_out<=1;
      default : seq_int_i.detector_out<=0;
    endcase
  end
endmodule


interface seq_interface(input clock);
  logic reset;
  logic sequence_in;
  logic detector_out;

  modport TEST(input detector_out, clock, output reset, sequence_in);
  modport DUT(output detector_out, input reset, sequence_in, clock);
endinterface: seq_interface