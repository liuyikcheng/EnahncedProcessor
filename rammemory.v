module RamMemory(clock, RamInit, WE, D, Address, Q);
	
	parameter SIZE = 8, addressSIZE = 5;
	
	input clock, RamInit, WE;
	input [SIZE-1:0] D;
	input [addressSIZE-1:0] Address;
	output reg [SIZE-1:0] Q;
	
	reg [SIZE-1:0] Memory [1<<addressSIZE:0]; 
	
	//assign Q = WE?Q:Memory[Address];
	
	always@(posedge clock) begin
		if(WE)
			Memory[Address] = D;
		else
			Q = Memory[Address];
	end
	
	endmodule
			