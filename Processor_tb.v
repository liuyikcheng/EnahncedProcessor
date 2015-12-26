module Processor_tb();

//input reg
	reg  clock, reset, Enter, cheat;
	reg  [7:0] Minput;

//output wire
	wire Halt;
	wire [7:0] Moutput;
	wire [3:0] DisplayState;
  wire [2:0] IR75;
  wire Reset;
  integer error, i;
	reg  [7:0] expectedValue, X, Y;
	
	assign Reset = ~reset;

EnhanceProcessor proc(cheat,Enter, Minput, clock, Reset, Halt, Moutput
				, RamIn, RamOut, RamAddress, DisplayState);
//Processor mine ( clock, reset, Enter, cheat, Minput,
//                 Halt, Moutput, DisplayState, IR75);


/************************* GLOBAL INITIAL CLOCK and GLOBAL INITIAL RESET **********************/
initial
begin
  reset <= 0; cheat <= 1;
  @(posedge clock);
  @(negedge clock);
  reset <= 1;  cheat <= 0;
end

initial
begin
  clock = 0;
  forever #1 clock = ~clock;
end

initial
begin
  $display("clk | reset | Enter | cheat | Minput | Halt| Moutput| State| IR75");
  $monitor("%b   | %b     | %b     |  %b   |    %d  |  %b  |   %d   | %b | %b ", clock, reset, Enter, cheat, Minput, Halt, Moutput, DisplayState, IR75);
end

initial
begin
  initialise();
  #2  autoChecking;
  #2  if(!error)
        $display(" Simulation Successful =) ");
      else
        $display(" Simulation Failed. Total errors = %d ", error);
      $finish;
      
  // #8  $display("CP1"); getInput(2);
  // #14 $display("CP2"); getInput(8); checkingOutput(2);

end

/*
initial
begin
  forever #1
  if(Halt)
  begin
    if(expectedValue != Moutput)
    begin
      error = error + 1;
      $display("ERROR occur! expectedValue = %d, output = %d", expectedValue, Moutput);
    end
  end
end
*/

/*************************** TASKS **********************************/
task getInput;
input [7:0] dataIn;
begin
  Minput = dataIn; Enter = 1;
  #2 Enter = 0;
end
endtask

task restart;
begin
  reset <= 0;
  #2 reset <= 1;
end
endtask

task initialise;
begin
	Minput <= 0; Enter <= 0; error <= 0; expectedValue <= 0;
end
endtask

task checkingOutput;
input [7:0] expectedValue;
begin
  $display("CP4");
  while(!Halt) #1;

    if(expectedValue != Moutput)
    begin
      error = error + 1;
      $display(" !!!!!! ERROR !!!!!!  expected output = %d, actual output = %d", expectedValue, Moutput);
    end
    else
      $display("***************************** PASS with %d time *************************************", (i + 1));

end
endtask

task algorithmChecking;
begin
  // $display("CP3");
  while(X != Y)
  begin
    if(X > Y)    X = X - Y;
    else         Y = Y - X;
  end
    
  checkingOutput(X);
end
endtask

task autoChecking;
begin
  for(i = 0; i < 100; i = i + 1)
  begin
    restart();
    X = ({$random} % 128); Y = ({$random} % 128);
    while(X == 0) begin X = ({$random} % 128); end
    while(Y == 0) begin Y = ({$random} % 128); end //restart();
    $display("X = %d, Y = %d ", X, Y);
    #8  getInput(X);
    #14 getInput(Y); algorithmChecking();
    
  end
end
endtask

endmodule
