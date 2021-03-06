module InsSetOp(
	
	input Clock, Reset,
	input [7:0] Input,
	input [7:0] RamQ,
	input [1:0] Asel, //Control signal
	input Aload, Sub, //Control signal
	output Aeq0, Apos, //Status signals
	output [7:0] Output,
	output [7:0] AddSubOutput,
	output [7:0] MuxOutput
	);
	
	wire [7:0] AddSub_out, reg1_out, mux1_out, mux2_out, mux3_out;
	wire [1:0] Selector;
	wire [7:0] gnd = 8'b00000000;
	
	assign Selector = Asel;
	assign Output = reg1_out;
	assign Aeq0 = (reg1_out == 0)?1:0;
	assign Apos = ~(reg1_out[7]);
	assign Load = Aload;
	assign AddSubOutput = AddSub_out;
	assign MuxOutput = mux1_out;
	
	//instantiate
	AddSub_mod #(.SIZE(8)) AddSub(Sub, reg1_out, RamQ, AddSub_out);
	
	/*	mux_mod #(.SIZE(8)) mux1(mux2_out, mux3_out, Selector[1], mux1_out);
	mux_mod #(.SIZE(8)) mux2(AddSub_out, Input, Selector[0], mux2_out);
	mux_mod #(.SIZE(8)) mux3(RamQ, gnd, Selector[0], mux3_out);*/
	
	assign mux1_out	= Asel[1]	? RamQ : (Asel[0] ? Input : AddSub_out);
	
	
	Register #(.SIZE(8)) regA(Clock, Reset, Load, mux1_out, reg1_out);
	
	endmodule
	