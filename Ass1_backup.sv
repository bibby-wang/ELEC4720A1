//bibby.wang elec4720 Ass1 Q1
//useing 4bit sw control HEX0 dispany 0 to f
//module cde(input logic [3:0] SW,
//			output logic HEX0);
//
//		HEX_4bit h0(SW,HEX0);
//
//
//
//endmodule
//module HEX_4bit(input logic [3:0] a,output logic [6:0] h);
//
//	always_comb begin
//	
//		case(a) 
//			4'h0: h = 7'b100_0000;
//			4'h1: h = 7'b111_1001;
//			4'h2: h = 7'b010_0100;
//			4'h3: h = 7'b011_0000;
//			4'h4: h = 7'b001_1001;
//			4'h5: h = 7'b001_0010;
//			4'h6: h = 7'b000_0010;
//			4'h7: h = 7'b111_1000;
//			4'h8: h = 7'b000_0000;
//			4'h9: h = 7'b001_0000;
//			4'hA: h = 7'b000_1000;
//			4'hB: h = 7'b000_0011;
//			4'hC: h = 7'b100_0110;
//			4'hD: h = 7'b010_0001;
//			4'hE: h = 7'b000_0110;
//			4'hF: h = 7'b000_1110;
//			default: h=7'b000_0000;
//
//		
//		endcase
//	end
//
//
//endmodule

module cde(
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


//bibby.wang elec4720 Ass1 Q1
//useing 4bit sw control HEX0 dispany 0 to f
module seven_seg(input logic [3:0] SW,output logic [6:0] HEX0);

//dispany 0 to f
	
	//~s2 ~s0 | ~s3 s1 | ~s3 s2 s0 | s2 s1 | s3 ~s2 ~s1 | s3 ~s0
	assign HEX0[0] = ~((~SW[2] & ~SW[0]) | (~SW[3] & SW[1]) | (~SW[3] & SW[2] & SW[0]) | (SW[2] & SW[1]) | (SW[3] & ~SW[2] & ~SW[1]) | (SW[3] & ~SW[0]));
	
	//~s3 ~s2 | ~s3 ~s1 ~s0 | ~s2 ~s0 | ~s3 s1 s0 | s3 ~s1 s0
	assign HEX0[1] = ~((~SW[3] & ~SW[2]) | (~SW[3] & ~SW[1] & ~SW[0]) | (~SW[2] & ~SW[0]) | (~SW[3] & SW[1] & SW[0]) | (SW[3] & ~SW[1] & SW[0]));
	
	//~s3 ~s1 | ~s3 s0 | ~s1 s0 | ~s3 s2 | s3 ~s2
	assign HEX0[2] = ~((~SW[3] & ~SW[1]) | (~SW[3] & SW[0]) | (~SW[1] & SW[0]) | (~SW[3] & SW[2]) | (SW[3] & ~SW[2]));
	
	//~s3 ~s2 ~s0 | ~s2 s1 s0 | s2 ~s1 s0 | s2 s1 ~s0 | s3 ~s1
	assign HEX0[3] = ~((~SW[3] & ~SW[2] & ~SW[0]) | (~SW[2] & SW[1] & SW[0]) | (SW[2] & ~SW[1] & SW[0]) | (SW[2] & SW[1] & ~SW[0]) | (SW[3] & ~SW[1]) );
	
	//~s2 ~s0 | s1 ~s0 | s3 s1 | s3 s2
	assign HEX0[4] = ~((~SW[2] & ~SW[0]) | (SW[1] & ~SW[0]) | (SW[3] & SW[1]) | (SW[3] & SW[2]));
	
	//~s1 ~s0 | ~s3 s2 ~s1 | s2 ~s0 | s3 ~s2 | s3 s1
	assign HEX0[5] = ~((~SW[1] & ~SW[0]) | (~SW[3] & SW[2] & ~SW[1]) | (SW[2] & ~SW[0]) | (SW[3] & ~SW[2]) | (SW[3] & SW[1]));
	
	//~s2 s1 | s1 ~s0 | ~s3 s2 ~s1 | s3 ~s2 | s3 s0
	assign HEX0[6] = ~((~SW[2] & SW[1]) | (SW[1] & ~SW[0]) | (~SW[3] & SW[2] & ~SW[1]) | (SW[3] & ~SW[2]) | (SW[3] & SW[0]));

endmodule

//bibby.wang elec4720 Ass1 Q2
//two 4 bit wide numbers to produce a 7 bit wide result of multiplication.

module mult(
		input logic [3:0] a, b,
		output [7:0] out
		) ;
		
////
		logic [6:0] t1, t2, t3, t4, out1, out2;
		logic [2:0] c;

		
		
//		assign t1[0]=a[0] & b[0];
//		assign t1[1]=a[1] & b[0];
//		assign t1[2]=a[2] & b[0];
//		assign t1[3]=a[3] & b[0];
//		assign t1[4]=0;
//		assign t1[5]=0;
//		assign t1[6]=0;

		assign t1 = {a&{4{b[0]}},3'd0};


//		assign t2[0]=0;
//		assign t2[1]=a[0] & b[1];
//		assign t2[2]=a[1] & b[1];
//		assign t2[3]=a[2] & b[1];
//		assign t2[4]=a[3] & b[1];
//		assign t2[5]=0;
//		assign t2[6]=0;

		assign t2 = {1'd0, a&{4{b[1]}},2'd0};
		
//		assign t3[0]=0;
//		assign t3[1]=0;
//		assign t3[2]=a[0] & b[2];
//		assign t3[3]=a[1] & b[2];
//		assign t3[4]=a[2] & b[2];
//		assign t3[5]=a[3] & b[2];
//		assign t3[6]=0;

		assign t3 = {2'd0, a&{4{b[2]}},1'd0};	
		
//		assign t4[0]=0;
//		assign t4[1]=0;
//		assign t4[2]=0;
//		assign t4[3]=a[0] & b[3];
//		assign t4[4]=a[1] & b[3];
//		assign t4[5]=a[2] & b[3];
//		assign t4[6]=a[3] & b[3];

		assign t4 = {3'd0, a&{4{b[3]}}};

		adder_7bit add0(t1,t2,0,out1,c[0]);
		adder_7bit add1(out1,t3,c[0],out2,c[1]);
		adder_7bit add2(out2,t4,c[1],out[6:0],out[7]);


endmodule


module adder_7bit (
		input logic [6:0] a, b,
		input logic cin,
		output logic [6:0] s,
		output logic cout
		);
			logic [5:0] p;
			fulladder add0 (a[0],b[0],cin,s[0],p[0]);
			fulladder add1 (a[1],b[1],p[0],s[1],p[1]);
			fulladder add2 (a[2],b[2],p[1],s[2],p[2]);
			fulladder add3 (a[3],b[3],p[2],s[3],p[3]);
			fulladder add4 (a[4],b[4],p[3],s[4],p[4]);
			fulladder add5 (a[5],b[5],p[4],s[5],p[5]);
			fulladder add6 (a[6],b[6],p[5],s[6],cout);
endmodule


module fulladder (
	input logic a, b, cin,
	output logic s, cout);
		logic g;
		logic p;
		assign g = a & b;
		assign p = a ^ b;
		assign s = p ^ cin;
		assign cout = g | (p & cin);
endmodule


//module adder_4bit (
//		input logic [3:0] a, b,
//		input logic cin,
//		output logic [3:0] s,
//		output logic cout
//		);
//			logic [2:0] p;
//			fulladder add0 (a[0],b[0],cin,s[0],p[0]);
//			fulladder add1 (a[1],b[1],p[0],s[1],p[1]);
//			fulladder add2 (a[2],b[2],p[1],s[2],p[2]);
//			fulladder add3 (a[3],b[3],p[2],s[3],cout);
//endmodule

//module adder_4bit (
//				input logic a0, a1, a2, a3,
//				input logic b0, b1, b2, b3,
//				input logic cin,
//				output logic s0, s1, s2, s3,
//				output logic cout);
//	logic p0, p1, p2;
//	fulladder add0 (a0,b0,cin,s0,p0); // Instance 1, name add0
//	fulladder add1 (a1,b1,p0 ,s1,p1); // Instance 2, name add1
//	fulladder add2 (a2,b2,p1 ,s2,p2); // Instance 3, name add2
//	fulladder add3 (a3,b3,p2 ,s3,cout); // Instance 4, name add3
//endmodule
//
//module fulladder (input logic a, b, cin,output logic s, cout);
//	logic g;
//	logic p;
//	assign g = a & b;
//	assign p = a ^ b;
//	assign s = p ^ cin;
//	assign cout = g | (p & cin);
//endmodule






////useing all sw control HEX0
//module cde(input logic [9:0] SW,output logic [6:0] HEX1);
//
//
//	assign HEX1[0] = ~SW[0];
//	assign HEX1[1] = ~SW[1];
//	assign HEX1[2] = ~SW[2];
//	assign HEX1[3] = ~SW[3];
//	assign HEX1[4] = ~SW[4];
//	assign HEX1[5] = ~SW[5];
//	assign HEX1[6] = ~SW[6];
//	
//endmodule


//module cde ( input logic A,B, output logic Y );
//	logic E,F;
//	assign F = A & B; 
//	assign E = A & ~B; 
//	assign Y = E | F;
//endmodule

//module cde ( input logic A,B, output logic Y );
//	logic E,F;
//	assign F = A & B; 
//	assign E = A & ~B; 
//	assign Y = E | F;
//endmodule

//module cde(input logic [9:0] SW, output logic [6:0] LEDG);
//
////	assign LEDG = SW;
//	myhardware ins0(SW[0], SW[1], LEDG[0]);
//	myhardware ins1(SW[2], SW[3], LEDG[2]);
//	myhardware ins2(SW[1], SW[4], LEDG[5]);
////	assign LEDG[0] = SW[0];
////	assign LEDG[1] = SW[0]|SW[1];
////	assign LEDG[2] = SW[2]&SW[3];
////	assign LEDG[3] = SW[4];
//
//endmodule




//module myhardware( input logic C, output logic Y) ;
//
//	assign Y = C;
//	
//endmodule


//module circuit1 (input logic A,B,output logic Y);
//	assign Y = (A & ~B)|(A & B);
//endmodule
//
//module circuit2 (input logic A,B,output logic Y);
//	logic E,F;
//	assign F = A & B;
//	assign E = A & ~B;
//	assign Y = E | F;
//endmodule
//





