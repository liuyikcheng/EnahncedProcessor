module DP_tb();

	reg IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;
	reg [1:0] Asel;
	reg Reset, Clock, RamSelect;
	reg [7:0] Input;
	
	wire [7:5] IR;
	wire Aeq0, Apos;
	wire [7:0] Output;
	wire [4:0] RamAddress;
	wire [7:0] RamIn, RamOut;
	
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
	
	//main loop
	initial begin
	#10 RamSelect = 1;
	#40 RamSelect = 0;

	Input = 21;	//store 21 to address 30
	#2	start();
	#2  fetch();
	#2  decode();
	#2	inputState();
	
	#2	start();
	#2  fetch();
	#2  decode();
	#2	store();
	
	#2	Input = 10;// store 10 to address 31
	#2	start();
	#2  fetch();
	#2  decode();
	#2	inputState();
	
	#2	start();
	#2  fetch();
	#2  decode();
	#2	store();
	
	#2	start();
	#2  fetch();
	#2  decode();
	#2	load();
	

	
	#2 $finish;
	end
	
	initial begin
//		$display("IRload JMPmux PCload Meminst MemWr	Asel	Aload 	Sub	Input	RamAddress	RamIn	RamOut	Output	IR		Time");
//		$monitor("%d    	 %d     	%d     	%d      %d	%d	%d 	  %d	%d	%d		%d	%d	%d	%d%d", 
//				IRload, JMPmux, PCload, Meminst, MemWr, Asel,Aload, Sub, Input, RamAddress, RamIn, RamOut, Output, IR, $time);
	$display("IRload JMPmux PCload Meminst MemWr	Asel	Aload 	Sub	Input	Output	IR		Time");
	$monitor("%d    	 %d     	%d     	%d      %d	%d	%d 	  %d	%d	%d	%d%d", 
		IRload, JMPmux, PCload, Meminst, MemWr, Asel,Aload, Sub, Input, Output, IR, $time);

	end
	
	
	//state
	task start;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 0;
		Sub    = 0;
		Asel   = 0;
		end
	endtask
	
	task fetch;
		begin
		IRload = 1;
		JMPmux = 0;
		PCload = 1;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 0;
		Sub    = 0;
		Asel   = 0;
		end
	endtask
	
	task decode;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 1;
		MemWr  = 0;
		Aload  = 0;
		Sub    = 0;
		Asel   = 0;
		end
	endtask
	
	
	task load;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 1;
		Sub    = 0;
		Asel   = 2'b10;
		end
	endtask
	
	task store;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 1;
		MemWr  = 1;
		Aload  = 0;
		Sub    = 0;
		Asel   = 2'b00;
		end
	endtask
	
	task add;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 1;
		Sub    = 0;
		Asel   = 2'b00;
		end
	endtask
	
	task sub;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 1;
		Sub    = 1;
		Asel   = 2'b00;
		end
	endtask
	
	task inputState;
		begin
		IRload = 0;
		JMPmux = 0;
		PCload = 0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 1;
		Sub    = 0;
		Asel   = 2'b01;
		end
	endtask
	
	task jz;
		begin
		IRload = 0;
		JMPmux = 1;
		PCload = Aeq0;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 0;
		Sub    = 0;
		Asel   = 2'b00;
		end
	endtask
	
	task jpos;
		begin
		IRload = 0;
		JMPmux = 1;
		PCload = Apos;
		Meminst= 0;
		MemWr  = 0;
		Aload  = 0;
		Sub    = 0;
		Asel   = 2'b00;
		end
	endtask
	
	DP dp(IRload, JMPmux, PCload, Meminst, MemWr, Asel,
			Aload, Reset, Clock, Sub, Input, RamSelect,
	   	IR, Aeq0, Apos, Output, RamAddress, RamIn, RamOut);
			
//		uP_DP dp(Clock, Reset, RamSelect, Input, IRload, JMPmux,
	//	 PCload, Meminst, MemWr, Aload, Sub, Asel,	Aeq0, Apos, IR, Output);
		
		
		
		
	endmodule
	