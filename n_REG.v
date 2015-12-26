module n_REG(CLOCK, Load, Clear, D, Q);
	parameter n = 8;
	input	CLOCK;
	input	Load, Clear;
	input	[n-1:0] D;
	output	reg [n-1:0] Q;
	
	always @ (posedge CLOCK, posedge Clear)
	begin
		if(Clear)	Q = 0;
		else
		begin
			if(Load)	Q = D;
			else		Q = Q;
		end
	end
endmodule
