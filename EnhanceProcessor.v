module EnhanceProcessor(RamInit, Enter, Input, Clock, Reset, Halt, Output
						, RamIn, RamOut, RamAddress, state);
	
	input Clock, Reset, Enter;
	input [7:0] Input;
	input RamInit;
	
	output Halt;
	output [7:0] Output, RamIn, RamOut;
	output [4:0] RamAddress;
	output [3:0] state;
	
	wire Aeq0, Apos; 	//control signals
	wire [7:5] IR;		//control signals
	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;//status signals
	wire [1:0] Asel;	//status signals
	wire Halt;
	
	processorCU	cu(Enter, Clock, Reset, Aeq0, Apos, IR, IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub,
					Asel, Halt, state);

 /* 
	uP_CU	CtrlUnit(Reset, Clock, IR, Aeq0,  Apos, Enter, IRload, JMPmux,
					 PCload, Meminst, MemWr, Aload, Sub, Halt, Asel);
					 
	uP_DP  dp(Clock, Reset,RamSelect, Input, IRload, JMPmux, PCload, Meminst,
	                 MemWr, Aload, Sub, Asel, Aeq0, Apos, IR, Output);
*/				
	DP			dp(IRload, JMPmux, PCload, Meminst, MemWr, Asel,
					Aload, Reset, Clock, Sub, Input, RamInit,
					IR, Aeq0, Apos, Output, RamAddress, RamIn, RamOut);
					

endmodule
