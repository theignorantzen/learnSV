// ---------------------------------------------
// Design Name : Moore State Machine
// File Name   : ExampleFSM.sv
// Coder       : Soumya Ranjan Mondal
// ----------------------------------------------

module ExampleFSM(input logic clk,
                  input logic reset,
                  input logic X,
                  output logic Y);

  typedef enum logic [2:0] { A, B, C, D, E } State;

State currentState, nextState;

  always_ff @(posedge clk)
    if(reset) currentState <= A;
    else      currentState <= nextState;

  always_comb
    case(currentState)
      A: if(X) nextState = C;
         else  nextState = B;
      
      B: if(X) nextState = D;
         else  nextState = B;
      
      C: if(X) nextState = C;
         else  nextState = E;
      
      D: if(X) nextState = C;
         else  nextState = E;
      
      E: if(X) nextState = D;
         else  nextState = B;
      
      default: nextState = A;

    endcase

  assign Y = (currentState == D | currentState == E);

endmodule
