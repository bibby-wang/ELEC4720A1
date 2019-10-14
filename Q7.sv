module Q7(
	input logic [9:0] SW,
	output logic [7:0] LEDG,
	output logic [9:0] LEDR);

	//input number dispaly
	assign LEDR = SW;
	shifter_B sh({8'b1011_0110},{8'b{0000}SW[9:6]},SW[5:2],SW[2:0],LEDG[7:0]);
endmodule
//Q7 b
module shifter_B 
	#(parameter N = 4)
	(input logic [2**N-1:0] A,B,
	 input logic [N-1:0] C,
	 input logic [2:0] F,//control 
	 output logic [2**N-1:0] Y);
	always_comb
	begin
		if (F[2]) shifter_A sh1(A,B[3:0],F[1:0],Y);
		else shifter_A sh0(A,C,F[1:0],Y);
	end	 
endmodule
//Q7 a
module shifter_A 
	#(parameter N = 4)
	(input logic [2**N-1:0] A,
	 input logic [N-1:0] Sh,
	 input logic [1:0] F,//control 
	 output logic [2**N-1:0] Y);
	 
	always_comb
	begin
		case(F)
			0: Y = A << Sh;
			1: Y = A >> Sh;
			2: Y = A;
			3: Y = $signed(A) >>> Sh;
		endcase
	end
      
endmodule
