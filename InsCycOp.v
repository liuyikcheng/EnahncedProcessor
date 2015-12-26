module InsCycOp(
	input Clock, Reset,
	input IRload, JMPmux, PCload, Meminst, //control signals
	input [7:0] D,
	output [4:0] out,
	output [7:5] IR	,//Status signal	
	output [4:0] IRreg, PCreg
	);
	
	wire [4:0] INC_out, IR4to0;
	wire [4:0] JMPmux_out, Memist_out;
	wire [7:0] IRin, IRout;
	wire [4:0] PCin, PCout;
	
	assign IRin = D;
	assign IR = IRout [7:5];
	assign IR4to0 = IRout[4:0];
	assign PCin = JMPmux_out;
	assign out = Memist_out;
	assign IRreg = IR4to0;
	assign PCreg = PCout;
	
	Register #(.SIZE(8)) reg_IR(Clock, Reset, IRload, IRin, IRout);
	Register #(.SIZE(5)) reg_PC(Clock, Reset, PCload, PCin, PCout);
	
	mux_mod	#(.SIZE(5)) mux_JMP(INC_out, IR4to0, JMPmux, JMPmux_out);
	mux_mod	#(.SIZE(5)) mux_Meminst(PCout, IR4to0, Meminst, Memist_out);
	
	Increment_module #(.SIZE(5)) inc5bit(PCout, INC_out);
	
	endmodule
	
	