//Binbin Wang c3214157 elec4720 Ass1 Q8
//design a multiply-divide hardware
module Ass1(
	input logic [9:0]SW, 
	input logic KEY[0], 
	output logic [2:0]LEDR,
	output logic [5:0]LEDG,
	output logic [6:0] HEX3,HEX2,HEX1,HEX0);
	
	logic [5:0]fullout;
	
	multi_div #(.N(3))MD(SW[9:7], SW[6:4], KEY[0], SW[3:0], LEDR[2:0], fullout[5:3], fullout[2:0]);
	
	
	assign LEDG[5:0] = fullout[5:0];
	
	seven_seg OUTA({1'b0,SW[9:7]},HEX3);
	seven_seg OUTB({1'b0,SW[6:4]},HEX2);	
	seven_seg OUTYh({2'd0,fullout[5:4]},HEX1);	
	seven_seg OUTYl(fullout[3:0],HEX0);
	
endmodule
// Q8 multiply-divide
// from table 
// module multi_div 
	// #(parameter N=3)
	// (input logic [N-1:0]A,B, 
	 // input logic clk,
	 // input logic [3:0]F,			
	 // output logic [N-1:0]Y,
	 // output logic [N-1:0] Hi,Lo);
	// // always_comb
	// always_ff @(posedge clk) 
	// begin
		// if(F[3:0] == 0) begin  Y<=Hi; Lo<=Lo; Hi<=Hi;end
		// if(F[3:0] == 1) begin Lo<=Lo; Hi<=A;end
		// if(F[3:0] == 2) begin  Y<=Lo; Lo<=Lo;Hi<=Hi;end
		// if(F[3:0] == 3) begin Lo<=A; Hi<=Hi;end
		// if(F[3:0] == 8) begin {Hi,Lo}<=A*B; end
		// if(F[3:0] ==10) begin Hi<=A%B; Lo<=A/B;end

	// end

// endmodule

// Q8 multiply-divide
//from circuit
module multi_div 
	#(parameter N= 4)
	(input logic [N-1:0]A,B, 
	 input logic clk,
	 input logic [3:0]F,//3改成2 //组合版	
	 output logic [N-1:0]Y,
	 output logic [N-1:0] out_hi,out_lo);
	assign {out_hi,out_lo}={C_hi,C_lo};
	
	logic EN1, EN2;
	logic [N-1:0] Hi,Lo,H, L, R, Q, C_hi,C_lo;
	//修改 删除 F[2] 3改成2 //组合版
	assign EN1 = (F[3] | (~F[1] & F[0]))& ~F[2];
	assign EN2 = (F[3] | ( F[1] & F[0]))& ~F[2];
	
	always_ff @(posedge clk) 
	begin

		if(EN1) C_hi <= F[3]? Hi:A;
		if(EN2) C_lo <= F[3]? Lo:A;

	end
	
	assign {H, L} = A * B;
	assign R = A % B;
	assign Q = A / B;
	assign Y = F[1]? C_lo:C_hi;
	assign Hi = F[1]? R:H;
	assign Lo = F[1]? Q:L;
	
endmodule


// Q1
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