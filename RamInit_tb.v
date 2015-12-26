module RamInit_tb();

	reg Clock, Reset;
	reg WE;
	wire [4:0] RamAddressInit, Address;
	wire [7:0] RamDInit, D, Q;
	
	InsLoadForRam insLoadForRam(Clock, Reset, RamAddressInit, RamDInit);
	RamMemory	ram(Clock, WE, D, Address, Q);
	
	assign Address = RamAddressInit;
	assign D = RamDInit;
	
	initial begin
	Reset = 1;
	WE = 0;
	#2 Reset = 0;
	WE = 1;
	
	#10
	Reset = 1;
	WE = 0;
	#2 Reset = 0;
	
	#100 $finish;
	end
	
	initial begin
	  $display("WE	D	Q	Address	RamDInit	RamAddressInit");
	  $monitor("%d	%d	%d	%d	%d		%d",WE, D, Q, Address, RamDInit, RamAddressInit);
	end
	
	initial begin
		Clock <= 0;
		forever #1 Clock = ~Clock;
	end
	
	endmodule
	