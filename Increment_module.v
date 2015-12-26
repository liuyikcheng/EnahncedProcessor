module Increment_module(Input, Output);
	
	parameter SIZE = 8;
	
	input [SIZE-1:0] Input;
	output [SIZE-1:0] Output;
	
	assign Output = Input+1;
	
	endmodule
	
	
	