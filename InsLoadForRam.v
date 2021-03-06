module InsLoadForRam(

	input Clock, Reset, RamSelect,
	output reg [4:0] Address,
	output reg [7:0] D
	);
	
	integer i = 0;
	
	always@(posedge Clock, posedge Reset)
		begin
			if(Reset)
				begin
					Address <= 0;
					D <= 0;
				end
			else
				begin
					if(RamSelect) begin
						case(i)
						0: begin D <= 8'b10000000; Address <= 0; end
						1: begin D <= 8'b00111110; Address <= 1; end
						2: begin D <= 8'b10000000; Address <= 2; end
						3: begin D <= 8'b00111111; Address <= 3; end
						4: begin D <= 8'b00011110; Address <= 4; end
						5: begin D <= 8'b01111111; Address <= 5; end
						6: begin D <= 8'b11111111; Address <= 6; end
				/*		6: begin D <= 8'b10110000; Address <= 6; end
						7: begin D <= 8'b11001100; Address <= 7; end
						8: begin D <= 8'b00011111; Address <= 8; end
						9: begin D <= 8'b01111110; Address <= 9; end
						10: begin D <= 8'b00111111; Address <= 10; end
						11: begin D <= 8'b11000100; Address <= 11; end
						12: begin D <= 8'b00011110; Address <= 12; end
						13: begin D <= 8'b01111111; Address <= 13; end
						14: begin D <= 8'b00111110; Address <= 14; end
						15: begin D <= 8'b11000100; Address <= 15; end
						16: begin D <= 8'b00011110; Address <= 16; end
						17: begin D <= 8'b11111111; Address <= 17; end*/
						default:begin D <= 8'b00000000; Address <= 18; end
						endcase
						i <= i+1;
					end
					else	begin
					Address <= Address;
					D <= D;
					end
					
				end
		end




endmodule
