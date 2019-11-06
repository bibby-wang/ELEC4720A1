//Binbin Wang c3214157 elec4720 Ass1 Q2
//two 4 bit wide numbers to produce a 7 bit wide result of multiplication.
module Ass1(
	input logic [7:0] SW,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3
);
	logic [7:0] Result;

	seven_seg  disp0(SW[3:0], HEX0);

	seven_seg  disp1(SW[7:4], HEX1);
	
	mult m0(SW[3:0], SW[7:4], Result);

	seven_seg  disp2(Result[3:0], HEX2);

	seven_seg  disp3(Result[7:4], HEX3);
	
endmodule


//Binbin Wang c3214157 elec4720 Ass1 Q1
//useing 4bit sw control HEX0 dispany 0 to f
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

// Q2 mult
module mult(
	input logic [3:0] a, b,
	output [7:0] out,
	output cout) ;
		
		logic [7:0] t1, t2, t3, t4, out1, out2;
		logic [2:0] c;

		assign t1 = {3'd0,a&{4{b[0]}}};
		assign t2 = {2'd0, a&{4{b[1]}},1'd0};
		assign t3 = {1'd0, a&{4{b[2]}},2'd0};	
		assign t4 = {a&{4{b[3]}},3'd0};
		
		adder_8bit add0(t1,t2,0,out1,c[0]);
		adder_8bit add1(out1,t3,c[0],out2,c[1]);
		adder_8bit add2(out2,t4,c[1],out[7:0],cout);


endmodule

// Q2 adder_8bit
module adder_8bit(
	input logic [7:0] a, b,
	input logic cin,
	output logic [7:0] s,
	output logic cout);
		logic [6:0] p;
		fulladder add0 (a[0],b[0],cin,s[0],p[0]);
		fulladder add1 (a[1],b[1],p[0],s[1],p[1]);
		fulladder add2 (a[2],b[2],p[1],s[2],p[2]);
		fulladder add3 (a[3],b[3],p[2],s[3],p[3]);
		fulladder add4 (a[4],b[4],p[3],s[4],p[4]);
		fulladder add5 (a[5],b[5],p[4],s[5],p[5]);
		fulladder add6 (a[6],b[6],p[5],s[6],p[6]);
		fulladder add7 (a[7],b[7],p[6],s[7],cout);
endmodule
// Q2 fulladder
module fulladder (
	input logic a, b, Cin,
	output logic s, Cout);
		logic g;
		logic p;
		assign g = a & b;
		assign p = a ^ b;
		assign s = p ^ cin;
		assign cout = g | (p & cin);
endmodule

