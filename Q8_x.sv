module q8 (input logic [9:0]SW, input logic [3:0]KEY, output logic [9:0]LEDR);
	pa #(2)(SW[3:2], SW[1:0], KEY[3], SW[9:6], LEDR[5:4],LEDR[3:2], LEDR[1:0] );
endmodule


module pa 
	#(parameter n= 4)
	(input logic [n-1:0]A,B, 
	 input logic clk,
	 input logic [3:0]F,			
	 output logic [n-1:0]y, C0,C1);
	
	logic en1, en2;
				
	logic [n-1:0] B1up,B1down,H, R, L, Q;

	logic [n-1:0]H, L, R, Q;


	assign en1 = F[3] | (~F[1]&F[0]);
	assign en2 = F[3] | ( F[1]&F[0]);
	assign y = F[1]? C1:C0;

					
	always_ff @(posedge clk) begin
		if(en1) C0 <= F[1]? B1up:A;
		if(en2) C1 <= F[1]? B1down:A;

		end

		
	assign B1up = F[1]? R:H;	
	assign B1down = F[1]? Q:L;	
			
	assign {H, L} = A * B;
	assign R = A % B;
	assign Q = A / B;

	
endmodule

