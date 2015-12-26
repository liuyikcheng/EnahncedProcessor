module	mem_RAM(
	input	CLOCK,
	input 	[7:0] D,
	input 	[4:0] Address,
	input 	WE,
	//$$$$$$$$$ADD IN FOR TB$$$$$$$$$$
	input	Init,
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	output 	reg	[7:0] Q
);
	integer i;
	reg [7:0] REGISTER [31:0];
	
	always @(posedge CLOCK)//, negedge Init)
	begin
		if(Init)//FOR TB USE$$$$$$$$$$$$$$$$$$
			begin
			REGISTER[5'b00000]	= 8'b10000000;
			REGISTER[5'b00001]	= 8'b00111110;
			REGISTER[5'b00010]	= 8'b10000000;
			REGISTER[5'b00011]	= 8'b00111111;
			REGISTER[5'b00100]	= 8'b00011110;
			REGISTER[5'b00101]	= 8'b01111111;
			REGISTER[5'b00110]	= 8'b10110000;
			REGISTER[5'b00111]	= 8'b11001100;
			REGISTER[5'b01000]	= 8'b00011111;
			REGISTER[5'b01001]	= 8'b01111110;
			REGISTER[5'b01010]	= 8'b00111111;
			REGISTER[5'b01011]	= 8'b11000100;
			REGISTER[5'b01100]	= 8'b00011110;
			REGISTER[5'b01101]	= 8'b01111111;
			REGISTER[5'b01110]	= 8'b00111110;
			REGISTER[5'b01111]	= 8'b11000100;
			REGISTER[5'b10000]	= 8'b00011110;
			REGISTER[5'b10001]	= 8'b11111111;
			REGISTER[5'b11110]	= 8'b00000000;
			REGISTER[5'b11111]	= 8'b00000000;
			end//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
		else
      begin
      if(!WE)	Q = REGISTER[Address];
      else	REGISTER[Address] = D;
      end
	end
endmodule
