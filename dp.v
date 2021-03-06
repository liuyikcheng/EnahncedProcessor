module DP(IRload, JMPmux, PCload, Meminst, MemWr, Asel,
			Aload, Reset, Clock, Sub, Input, RamInit,
			IR, Aeq0, Apos, Output, ICOOutput, RamIn, RamQ);
	
	input IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub;//status signals
	input [1:0] Asel;	//status signals
	input Reset, Clock;
	input [7:0] Input;
	input RamInit;
	
	output [7:5] IR;	//control signals
	output Aeq0, Apos;	//control signals
	output [7:0] Output;
	output [4:0] ICOOutput;
	output [7:0] RamIn, RamQ;
	
	wire [7:0] RamD, RamQ, RamDInit;
	wire [4:0] Address, RamAddressInit;
	wire [7:0] IRD;
	wire [4:0] ICOOutput;	
	wire [4:0] IRreg, PCreg;
	wire [7:0] AddSubOutput, MuxOutput;
	wire WE;
	
	//assignment
	
	assign RamIn = RamD;
	assign RamOut = RamQ;
	assign RamAddress = Address;
	assign IRD = RamInit?0:RamQ;	
	assign RamD = Output;
	assign WE = MemWr;
	assign Address = ICOOutput;
	
	//instantiate
	
	InsCycOp 	insCycOp(Clock, Reset, IRload, JMPmux, PCload, Meminst, IRD,
					ICOOutput, IR, IRreg, PCreg);
					
	InsSetOp	insSetOp(Clock, Reset, Input, RamQ, Asel, Aload,
						Sub, Aeq0, Apos, Output, AddSubOutput, MuxOutput);
						
//	mem_RAM  RAM_32x8(Clock, Output, ICOOutput, MemWr, RamInit, RamQ);

	RamMemory  ram(Clock, RamInit, WE, RamD, Address, RamQ);
	endmodule
	