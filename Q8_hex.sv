module cde(
	input logic [9:0]SW, 
	input logic KEY[0], 
	output logic [2:0]LEDR,
	output logic [6:0] HEX3,HEX2,HEX0);
	
	logic [2:0]Y;
	seven_seg OUTY({1'b0,Y},HEX0);
	seven_seg OUTA({1'b0,SW[5:3]},HEX3);
	seven_seg OUTB({1'b0,SW[2:0]},HEX2);
	MUDV (SW[5:3], SW[2:0], KEY[0], SW[9:6], Y);
endmodule


module MUDV 
	#(parameter n= 3)
	
	(input logic [n-1:0]A,B, 
	 input logic clk,
	 input logic [3:0]F,			
	 output logic [n-1:0]Y);
			
	logic en1, en2;
	logic [n-1:0] C0,C1;
	logic [n-1:0] B1up, B1down, H, R, L, Q;

	assign en1 = F[3] | (~F[1]&F[0]);
	assign en2 = F[3] | ( F[1]&F[0]);
	assign Y = F[3]? C1:C0;

					
	always_ff @(posedge clk) 
		begin
		
			
			if(en1) C0 <= F[1]? B1up:A;
			if(en2) C1 <= F[1]? B1down:A;

		end

	assign B1up = F[1]? R:H;	
	assign B1down = F[1]? Q:L;	
			

	assign {H, L} = A * B;
	assign R = A % B;
	assign Q = A / B;

	
endmodule


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
