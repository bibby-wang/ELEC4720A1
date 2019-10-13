module Q7(
	input logic [5:0] SW,
	output logic [7:0] LEDG,
	output logic [5:0] LEDR);

	//input number dispaly
	assign LEDR = SW;
	shifter_A sh({8'b1011_0110},SW[5:2],SW[1:0],LEDG[7:0]);
endmodule
//Q7 b



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
