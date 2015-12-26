module proc_tb();

	reg Clock, Reset, Enter;
	reg [7:0] Input;
	reg RamInit;
	
	reg [7:0] InputX, InputY, expected_Output, InputA, InputB; //simulation variables
	wire Halt;
	wire [7:0] Output, RamIn, RamOut;
	wire [4:0] RamAddress;
	wire [3:0] state;
	
		wire	[10:0] CtrlSignals;
	wire	[2:0] Ins;
	
	integer i, j = 0; 
	integer error = 0;
	
	// Module instantiation
  EnhanceProcessor proc(RamInit ,Enter, Input, Clock, Reset, Halt, Output
				, RamIn, RamOut, RamAddress, state);
				
	// Clock initialization
	initial begin
		Clock <= 0;
		forever #1 Clock = ~Clock;
	end
	
	// Reset initialization
	initial begin
		Reset <= 1;
		@(posedge Clock);
		@(negedge Clock) Reset = 0;
	end
	
	// Main loop
	initial begin
		 initialize_input();	
		#2 generate_input();
		#2 summary_report();
		#2 $finish;
	end
	
/*	always@(posedge Clock)begin
	  if(Halt)
	    verify_output();
	  else if (j == 20)
	    $finish;
	  end*/
	
	// Inputs initialization
	task initialize_input;
		begin
		Input = 0;
		Enter = 0;
		RamInit = 1;
		InputA = 0;
		InputB = 0;
		#10 RamInit = 0;
		end
	endtask
	
	task generate_input;
	begin
	  for(i=0 ;i<100; i=i+1) begin
	    
	    InputA = {$random}%128 + 1;
	    InputB = {$random}%128 + 1;

	    Reset = 1;
	    #2 Reset = 0;
	    
	    #20	Input = InputA;
	   	#2	 Enter = 1;
	   	#2  Enter = 0;
		  #20	Input = InputB;
		  #2  Enter = 1;
		  #2  Enter = 0;

		  while( Halt == 0)begin
		     #1;
		  end
		  verify_output();
	    end
		end
	endtask
	
	task verify_output;
	  begin
	  if(Output == expected_Output)
	    $display("%d) InputA = %d InputB = %d Simulation output = %d, Expected output = %d Match!!!", i+1, InputA, InputB, Output, expected_Output);
	  else begin
	    $display("%d) InputA = %d InputB = %d Simulation output = %d, Expected output = %d Not Match!!!", i+1, InputA, InputB, Output, expected_Output);
	    error = error + 1;
	    end
	  end
	endtask
	
	task summary_report;
	  begin
	    $display("Simulation test complete with %d error(s)", error);
	  end
	endtask
/*	
	initial begin
   $display("Input	Enter		Output state RamAddress  RamOut  time");
   $monitor("%d	%d	        %d	%d   %d       %d  %d", Input, Enter, Output, state, RamAddress, RamOut, $time);

	end
*/	
	
	always@(posedge Clock, posedge Reset) begin
	  if(Reset)begin
	    InputX <= InputA;
	    InputY <= InputB;
	    end
	  else begin
	   if(InputX != InputY) begin
	      if(InputX > InputY)
	       InputX <= InputX - InputY;
	      else
	       InputY <= InputY - InputX;
	      end
	      else begin
	        expected_Output <= InputX;
	        expected_Output <= InputY;
	        end
	    end
	  end
	
	
	endmodule
	
	
