//bibby.wang elec4720 Ass1 Q7
//shifter unit
module Ass1(

	input logic [9:0] SW,
	output logic [7:0] LEDG,
	output logic [9:0] LEDR);

	//input number dispaly
	assign LEDR = SW;
	// 8 bits shifter
	//            n=3       A:8bits        B:8bits     C:4bits  F:3bits  Y:8bits
	shifter_B #(.N(3))sh({8'b1001_0110},{5'd0,SW[9:7]},SW[6:3],SW[2:0],LEDG[7:0]);
endmodule

//Q7 b
module shifter_B 
	#(parameter N = 4)
	(input logic [2**N-1:0] A,B,
	 input logic [N:0] C,
	 input logic [2:0] F,//control 
	 output logic [2**N-1:0] Y);
	 logic [N:0]O;
	always_comb

	begin
		case(F[2])
			0: O=C;
			1: O[3:0]=B[3:0];
		endcase
	end
	shifter_A sh1(A,O,F[1:0],Y);
	
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
			2: Y = A;      // not shift
			3: Y = $signed(A) >>> Sh;
		endcase
	end
      
endmodule