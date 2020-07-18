// TestBench Code for the Sequence Detector
program test_bench(seq_interface.TEST seq_int_i);
  bit in_queue[$];
  initial begin
    initialize();
    #10;
    seq_int_i.reset=1;
    #10;
    fork
      //Stimulus generator and driver
      drive_sequence($urandom_range(100,200));
      //Scoreboard
      simple_checker();
    join_any
    $finish();
  end

//Initialize signals to default values
  function void initialize();
    seq_int_i.sequence_in=0;
    seq_int_i.reset = 0;
  endfunction: initialize

//General stimulus and drive on the DUT pins
  task drive_sequence(input int length);
    bit dyn_array[];
    dyn_array = new[length];
    foreach(dyn_array[i])dyn_array[i] = $random();
    foreach(dyn_array[i])begin
      @(negedge seq_int_i.clock);
      seq_int_i.sequence_in=dyn_array[i];
      in_queue.push_back(dyn_array[i]);
      $write("Drive value=%b \t",seq_int_i.sequence_in);
    end
  endtask:drive_sequence

//Scoreboard: Check correctness of Desin
  task simple_checker();
    bit pop_data;
    bit[3:0]seq_data;
    forever begin
      @(posedge seq_int_i.clock);
      if(in_queue.size!=0) begin
        pop_data = in_queue.pop_back();
        seq_data = {seq_data, pop_data};
        if(seq_data == 'b1011) begin
          if(seq_int_i.detector_out==1'b0)
            $display("Error: Sequence is not detected");
          else
            $display("Success: Sequence is detected");
        end else begin
          if(seq_int_i.detector_out==1'b1)
            $display("Error: Erraneous sequence detected");
        end
      end
    end
  endtask:simple_checker
endprogram:test_bench


module tb_top();
  bit clock;
  //Clock generator logic
  initial begin
    clock=0;
    forever #10 clock=~clock;
  end
  seq_interface seq_int_i(clock);
  test_bench tb(seq_int_i);
  Sequence_Detector dut(seq_int_i);
  //To dump the waveforms
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_top);
  end
endmodule: tb_top