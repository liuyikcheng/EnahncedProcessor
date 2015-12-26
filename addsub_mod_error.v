module AddSub_mod #(parameter SIZE = 8) (
	
	input Sub,
	input [SIZE-1:0] In1, In0,
	output reg [SIZE-1:0] Out
	);

	
	//assign Out = Sub?(In1-In0):(In1+In0);
	
//	if(In1 > In0)
	//		diff = In1 - In0;
	//	else
	//		diff = In0 - In1;

	always@(Sub, In1, In0)
	begin
		if(Sub)
				Out = In1 - In0;
		else
			Out = In1+In0;
	end





endmodule
