class generator;
  rand transaction trans,tr;
  int  repeat_count;
  mailbox gen2driv;
  event ended;
  
  function new(mailbox gen2driv,event ended);
    //getting the mailbox handle from env, in order to share the transaction packet between the generator and driver, the same mailbox is shared between both.
    this.gen2driv = gen2driv;
    this.ended    = ended;
    trans = new();
  endfunction
  
  task main();
    repeat(repeat_count) begin
    if( !trans.randomize() ) $fatal("Gen:: trans randomization failed");      
    tr = trans.do_copy();
    gen2driv.put(tr);
    end
    -> ended; 
  endtask
  
endclass