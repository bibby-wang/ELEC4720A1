//Binbin Wang c3214157 elec4720 Ass1 Q4
//the `logic unit' of the MIPS processor.4:1 MUX
module Ass1(

	input logic [9:0] SW,

	output logic [6:0] HEX0,HEX1,HEX2,
	output logic [1:0] LEDG,
	output logic [3:0] LEDR
	);

	
	logic [3:0] Result;
	// input A, B
	seven_seg  disp0(SW[3:0], HEX0);
	seven_seg  disp1(SW[7:4], HEX1);
	// control signal F
	assign LEDG[0]=SW[8];
	assign LEDG[1]=SW[9];	
	
	//output
	logic [3:0] Result;
	MUX4_1 ab(SW[3:0],SW[7:4],SW[9:8],Result);
	
	//Hexadecimal number dispaly
	seven_seg  disp2(Result, HEX2);
	//Binary number dispaly
	assign LEDR = Result;	
	
	
endmodule
//
module MUX4_1 
	#(parameter N = 2)
	(input logic [(2**N)-1:0]A,B,
	 input logic [1:0]F,
	 output logic [(2**N)-1:0]Y);
	 
always_comb
begin
	case(F)
		0: Y = A & B;  // 00 a and b
		1: Y = A | B;  // 01 a or b
		2: Y = A ^ B;  // 10 a xor b
		3: Y = ~(A|B); // 11 ~(a|b)
	endcase
end
endmodule


//Binbin Wang c3214157 elec4720 Ass1 Q1
//useing 4bit S control HEX dispany 0 to f
module seven_seg(
				input logic [3:0] S,
				output logic [6:0] HEX);

	//dispany 0 to f
	
	//~s2 ~s0 | ~s3 s1 | ~s3 s2 s0 | s2 s1 | s3 ~s2 ~s1 | s3 ~s0
	assign HEX[0] = ~((~S[2] & ~S[0]) | (~S[3] & S[1]) | (~S[3] & S[2] & S[0]) | (S[2] & S[1]) | (S[3] & ~S[2] & ~S[1]) | (S[3] & ~S[0]));	
	//~s3 ~s2 | ~s3 ~s1 ~s0 | ~s2 ~s0 | ~s3 s1 s0 | s3 ~s1 s0
	assign HEX[1] = ~((~S[3] & ~S[2]) | (~S[3] & ~S[1] & ~S[0]) | (~S[2] & ~S[0]) | (~S[3] & S[1] & S[0]) | (S[3] & ~S[1] & S[0]));	
	//~s3 ~s1 | ~s3 s0 | ~s1 s0 | ~s3 s2 | s3 ~s2
	assign HEX[2] = ~((~S[3] & ~S[1]) | (~S[3] & S[0]) | (~S[1] & S[0]) | (~S[3] & S[2]) | (S[3] & ~S[2]));	
	//~s3 ~s2 ~s0 | ~s2 s1 s0 | s2 ~s1 s0 | s2 s1 ~s0 | s3 ~s1
	assign HEX[3] = ~((~S[3] & ~S[2] & ~S[0]) | (~S[2] & S[1] & S[0]) | (S[2] & ~S[1] & S[0]) | (S[2] & S[1] & ~S[0]) | (S[3] & ~S[1]) );
	//~s2 ~s0 | s1 ~s0 | s3 s1 | s3 s2
	assign HEX[4] = ~((~S[2] & ~S[0]) | (S[1] & ~S[0]) | (S[3] & S[1]) | (S[3] & S[2]));	
	//~s1 ~s0 | ~s3 s2 ~s1 | s2 ~s0 | s3 ~s2 | s3 s1
	assign HEX[5] = ~((~S[1] & ~S[0]) | (~S[3] & S[2] & ~S[1]) | (S[2] & ~S[0]) | (S[3] & ~S[2]) | (S[3] & S[1]));
	//~s2 s1 | s1 ~s0 | ~s3 s2 ~s1 | s3 ~s2 | s3 s0
	assign HEX[6] = ~((~S[2] & S[1]) | (S[1] & ~S[0]) | (~S[3] & S[2] & ~S[1]) | (S[3] & ~S[2]) | (S[3] & S[0]));

endmodule