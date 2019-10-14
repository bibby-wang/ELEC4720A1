//bibby.wang elec4720 Ass1 Q5
//the `logic unit' of the MIPS processor.
module Ass1(
	input logic [8:0] SW,
	output logic [6:0] HEX0,HEX2,HEX3,
	output logic [1:0] LEDG,
	output logic [3:0] LEDR
	);

	

	// input A, B
	seven_seg  disp2(SW[3:0], HEX2);
	seven_seg  disp3(SW[7:4], HEX3);
	// control signal F
	assign LEDG[0]=SW[8];
	
	//output
	logic [3:0] Result;
	MUX2_1 ab(SW[3:0],SW[7:4],SW[8],Result);
	
	//Hexadecimal number dispaly
	seven_seg disp0(Result, HEX0);

	//Binary number dispaly
	assign LEDR = Result;	
	
	
endmodule
// Alpha 
// module MUX2_1 
	// #(parameter N = 2)
	// (input logic [(2**N)-1:0]A,B,
	 // input logic S,
	 // output logic [(2**N)-1:0]Y);
	 
// always_comb
// begin
	// if (S==0) assign Y = A + B;  //  a + b
	// else assign Y = A + ~B + 1; // a - b
// end

// endmodule

// bibby.wang elec4720 Ass1 Q5
module MUX2_1 
	#(parameter N = 2)
	(input logic [2**N-1:0] A, B,
	 input logic S,
	 output logic [2**N-1:0] Y);
	 
	 parameter W=2**N;
	 
	 assign Y = A + (B ^ {W{S}} ) + S;
endmodule

//bibby.wang elec4720 Ass1 Q1
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