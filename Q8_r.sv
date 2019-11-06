module q8 (input logic [9:0]SW, input logic [3:0]KEY, output logic [9:0]LEDR);
	pa #(2)(SW[3:2], SW[1:0], KEY[3], SW[9:6], LEDR[5:4],LEDR[3:2], LEDR[1:0] );
endmodule


module pa #(parameter n= 4)
(input logic [n-1:0]a,b, 
				input logic clk,

				input logic [3:0]F,			
				output logic [n-1:0]y, C0,C1);
			
logic en1, en2;
logic [n-1:0] hi,lo;				
logic [n-1:0] B1up,B1down, B0,A0, A1, A2, A3, Bout1, Bout2;

logic [n-1:0]H, L, R, Q;


assign en1 = F[3] | (~F[1]&F[0]);
assign en2 = F[3] | (F[1]&F[0]);
assign y = F[1]? C1:C0;

				
always_ff @(posedge clk) begin
	if(en1) C0 <= Bout1;
	if(en2) C1 <= Bout2;
//	else C0 = hi[n-1:0];
//			C1 = lo[n-1:0];
	end

	
assign Bout1 = F[1]? B1up:B0;	
assign Bout2 = F[1]? B1down:B0;	
	
assign B0 = a;
assign B1up = F[1]? A1:A0;	
assign B1down = F[1]? A3:A2;	
		

assign A0 = H;
assign A1 = R;
assign A2 = L;
assign A3 = Q;
assign {H, L} = a * b;
assign R = a % b;
assign Q = a / b;

	
endmodule

