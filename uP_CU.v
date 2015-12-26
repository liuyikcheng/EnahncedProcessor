module uP_CU(
	//EXTERNAL INPUT
	input RESET, CLOCK,
	//STATUS SIGNALS
	input [7:5] IR,
	input Aeq0, Apos, Enter,
	//CONTROL SIGNALS
	output IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt,
	output reg [1:0] Asel
);

	reg [3:0] state, nextState;
	parameter START = 4'b0000, FETCH = 4'b0001, DECODE = 4'b0010;					//State to obtain Instruction
	parameter LOAD  = 4'b1000, STORE = 4'b1001, ADD    = 4'b1010, SUB  = 4'b1011;	//Instruction State
	parameter INPUT = 4'b1100, JZ 	 = 4'b1101, JPOS   = 4'b1110, HALT = 4'b1111;	//Instruction State
  //************************  TO SHORTEN THE PROGRAM  ****************************
	reg [7:0] outChain;
	assign {IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt} = outChain;
  //******************************************************************************
	always @ (posedge RESET, posedge CLOCK)
	begin
		if(RESET)
			state = START;
		else
			state = nextState;
	end
  //******************************************************************************	
	always @ (state, IR, Aeq0, Apos, Enter)
	begin
		case(state)
			START: begin
				outChain  = 8'b00000000;
				Asel	  = 2'b00;
				nextState = FETCH;
			end
			FETCH: begin
				outChain  = 8'b10100000;
				Asel	  = 2'b00;
				nextState = DECODE;
			end
			DECODE: begin
				outChain  = 8'b00010000;
				Asel	  = 2'b00;
				if(!IR[7])
					begin
					if(!IR[6])
						begin
						if(!IR[5])	begin nextState = LOAD;   end
						else		    begin nextState = STORE;  end
						end
					else
						begin
						if(!IR[5])	begin nextState = ADD;  end
						else		    begin nextState = SUB;  end
						end
					end
				else
					begin
					if(!IR[6])
						begin
						if(!IR[5])	begin nextState = INPUT;  end
						else		    begin nextState = JZ;     end
						end
					else
						begin
						if(!IR[5])	begin nextState = JPOS; end
						else		    begin nextState = HALT; end
						end
					end
			end
			LOAD: begin
				outChain = 8'b00000100;
				Asel	 = 2'b10;
				nextState = START;
			end
			STORE: begin
				outChain = 8'b00011000;
				Asel	 = 2'b00;
				nextState = START;
			end
			ADD: begin
				outChain = 8'b00000100;
				Asel	 = 2'b00;
				nextState = START;
			end
			SUB: begin
				outChain = 8'b00000110;
				Asel	 = 2'b00;
				nextState = START;
			end
			INPUT: begin
				outChain = 8'b00000100;
				Asel	 = 2'b01;
				if(!Enter) begin nextState = INPUT;  end
				else		  begin nextState = START;  end
			end
			JZ: begin
				outChain = {2'b01,Aeq0,5'b00000};
				Asel	 = 2'b00;
				nextState = START;
			end
			JPOS: begin
				outChain = {2'b01,Apos,5'b00000};
				Asel	 = 2'b00;
				nextState = START;
			end
			HALT: begin
				outChain = 8'b00000001;
				Asel	 = 2'b00;
				nextState = HALT;
			end
			default: nextState = START;
		endcase
	end
  
endmodule
	