module processorCU(
	input Enter, Clock, Reset,
	input Aeq0, Apos, //control signals
	input [7:5] IR,   //control signal
	output reg IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, //status signals
	output reg [1:0] Asel, //status signals
	output reg Halt,
	output reg [3:0] state
	);
	
	reg [3:0] nextstate;
	
	parameter	start 	= 4'b0000,
				fetch 	= 4'b0001,
				decode	= 4'b0010,
				load	= 4'b1000,
				store	= 4'b1001,
				add		= 4'b1010,
				sub		= 4'b1011,
				Input	= 4'b1100,
				jz		= 4'b1101,
				jpos	= 4'b1110,
				halt	= 4'b1111;
				
	//if Reset = 1 go to "start" state, else go to next state
	always@(posedge Clock, posedge Reset)
	begin
		if(Reset)
			state <= start;
		else
			state <= nextstate;
	end

	//status signals in different states
	always@(IR, state, Enter, Apos, Aeq0)
	begin
		case(state)
			start	: begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=fetch ; end
			fetch	: begin IRload=1; JMPmux=0; PCload=1; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=decode; end
			decode	: begin IRload=0; JMPmux=0; PCload=0; Meminst=1; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; 
							case(IR)
								3'b000  : nextstate=load;
								3'b001  : nextstate=store;
								3'b010  : nextstate=add;
								3'b011  : nextstate=sub;
								3'b100  : nextstate=Input;
								3'b101  : nextstate=jz;
								3'b110  : nextstate=jpos;
								3'b111  : nextstate=halt;
								default : nextstate = start;
							endcase
					  end
			load	: begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b10; Aload=1; Sub=0; Halt=0; nextstate=start; end
			store	: begin IRload=0; JMPmux=0; PCload=0; Meminst=1; MemWr=1; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=start; end
			add		: begin IRload=0; JMPmux=1; PCload=0; Meminst=0; MemWr=0; Asel=2'b00; Aload=1; Sub=0; Halt=0; nextstate=start; end
			sub		: begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b00; Aload=1; Sub=1; Halt=0; nextstate=start; end
			Input	: begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b01; Aload=1; Sub=0; Halt=0; 
							if(Enter)
								nextstate=start; 
							else
								nextstate=Input;
					  end
			jz		: begin IRload=0; JMPmux=1; PCload=Aeq0; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=start; end
			jpos	: begin IRload=0; JMPmux=1; PCload=Apos; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=start; end
			halt	: begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=1; nextstate=halt	; end
			default : begin IRload=0; JMPmux=0; PCload=0; Meminst=0; MemWr=0; Asel=2'b00; Aload=0; Sub=0; Halt=0; nextstate=fetch	; end //default state as state "start"
		endcase
	end

endmodule
