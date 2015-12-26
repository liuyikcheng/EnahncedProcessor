module opr_ADD_SUB(
	input 	[7:0] A, B,
	input	Sub,
	output	reg	[7:0] RESULT
);

	always @ (Sub, A, B)
	begin
		if(Sub)	RESULT = A - B;
		else	RESULT = A + B;
	end
	
endmodule
