`include "environment.sv"
program test(mem_intf intf);
  
  environment env;
  
  initial begin
    env = new(intf);
    env.gen.repeat_count = 4;
    env.run();
  end
endprogram