module mux_mod(In0, In1, Selector, Output);
	
	parameter SIZE = 8;
	
	input Selector;
	input [SIZE-1:0] In0, In1;
	output [SIZE-1:0] Output;
	
	assign Output = Selector?In1:In0;
	
	endmodule
	
	