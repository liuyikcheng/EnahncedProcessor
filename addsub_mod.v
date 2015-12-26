module AddSub_mod #(parameter SIZE = 8) (
	
	input Sub,
	input [SIZE-1:0] In1, In0,
	output [SIZE-1:0] Out
	);

	
	assign Out = Sub?(In1-In0):(In1+In0);
	





endmodule
