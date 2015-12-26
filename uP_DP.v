module uP_DP(
	input	  CLOCK, RESET, Init,
//------------EXTERNAL INPUT-----------------------
	input	  [7:0] Input,
//*************Control Signals*********************
	input	  IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub,
	input 	[1:0] Asel,
//*************Status Signals**********************
	output	Aeq0, Apos,
	output	[7:5] IR,
//-------------EXTERNAL OUTPUT---------------------
	output	[7:0] Output
);

	wire [7:0] IR_Con;
	wire [7:0] RAM_to_IR, A, Mux2_to_A, RESULT;
	wire [4:0] Mux0_to_PC, PC, Mux1_to_RAM;

	n_REG #(8) IR_REG(CLOCK, IRload, RESET,  RAM_to_IR, IR_Con);
	n_REG #(8)  A_REG(CLOCK,  Aload, RESET,  Mux2_to_A,  A);
	n_REG #(5) PC_REG(CLOCK, PCload, RESET, Mux0_to_PC, PC);
	
	mem_RAM  RAM_32x8(CLOCK, A, Mux1_to_RAM, MemWr, Init, RAM_to_IR);
	
	opr_ADD_SUB	ADD_SUB(A, RAM_to_IR, Sub, RESULT);
	
	assign Mux0_to_PC	= JMPmux	? IR_Con[4:0] : (PC + 5'd1);
	assign Mux1_to_RAM	= Meminst	? IR_Con[4:0] : PC;
	assign Mux2_to_A	= Asel[1]	? RAM_to_IR : (Asel[0] ? Input : RESULT);

	assign Aeq0	= ~(|A);
	assign Apos = ~A[7];

	assign IR[7:5] = IR_Con[7:5];
	assign Output  = A;
	
endmodule
