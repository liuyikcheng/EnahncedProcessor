module Register (Clock, Reset, Load, Input, Output);
	
	parameter SIZE = 8;
	
	input Clock, Reset, Load;
	input [SIZE-1:0] Input;
	output reg [SIZE-1:0] Output;
	
	always@(posedge Clock, posedge Reset)
	begin
		if(Reset)
			Output <= 0;
		else
			begin
				if(Load)
					Output <= Input;
				else
					Output <= Output;
			end
	end
	
	endmodule
	