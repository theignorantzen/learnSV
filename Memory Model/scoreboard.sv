class scoreboard;

  mailbox mon2scb;
  int no_transactions;
  
  //local memory
  bit [7:0] mem[4];
  
  function new(mailbox mon2scb);
    //getting the mailbox handles from  environment 
    this.mon2scb = mon2scb;
    foreach(mem[i]) mem[i] = 8'hFF;
  endfunction
  
  task main;
    transaction trans;
    forever begin
      #50;
      mon2scb.get(trans);
      if(trans.rd_en) begin
        if(mem[trans.addr] != trans.rdata) 
          $error("[SCB-FAIL] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr],trans.rdata);
        else 
          $display("[SCB-PASS] Addr = %0h,\n \t   Data :: Expected = %0h Actual = %0h",trans.addr,mem[trans.addr],trans.rdata);
      end
      else if(trans.wr_en)
        mem[trans.addr] = trans.wdata;

      no_transactions++;
    end
  endtask
  
endclass