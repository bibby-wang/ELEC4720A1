//Binbin Wang c3214157 elec4720 Ass1 Q9
//design an arithmetic logic unit (ALU)
module Ass1(
	input logic [9:0]SW, 
	output logic [1:0]LEDG,
	output logic [9:0]LEDR,
	output logic [6:0] HEX3,HEX2,HEX0);
	logic [2:0]Y;
	logic C,OV;
	ALU #(.N(3)) arith(SW[9:7], SW[6:4], SW[3:0],Y,C,Ov);
	//input display
	//BIN A B
	assign LEDR[9:7]=SW[9:7];
	assign LEDR[6:4]=SW[6:4];
	//HEX A B
	seven_seg OUTA({1'b0,SW[9:7]},HEX3);
	seven_seg OUTB({1'b0,SW[6:4]},HEX2);		
	//output display
	//C OV
	assign LEDG[1]=C;
	assign LEDG[0]=Ov;
	//BIN Y
	assign LEDR[2:0]=Y[2:0];
	//HEX Y
	seven_seg OUTY({1'b0,Y},HEX0);
endmodule

// Q9
module ALU 
	#(parameter N = 4, W=N-1)
	(input logic [N-1:0]A,B,
	 input logic [3:0]F,
	 output logic [N-1:0]Y,
	 output logic Cout,OV);
	
	logic [W:0] tempB, S,Y_logop,AUout;
	logic OVs, OVu, SLT, OV_SLT;

	//assign tempB = B^{W{F[1]}};
	assign tempB = F[1]? ~B:B;
	
	//addition and subtraction
	assign {Cout, S} = A + tempB + F[1];
	assign OVu = F[1] ^ Cout;
	assign OVs = (S[W] ^ A[W]) & ~(A[W] ^ tempB[W]);
	
	assign OV = F[0]? OVu:OVs;
	
	assign OV_SLT = OVs? Cout:S[W];
	
	assign SLT = F[0]? ~Cout:OV_SLT;
	
	//arithmetic operation
	assign AUout = F[3] ? {{W{1'b0}},SLT}:S;

	//Logic operations
	 MUX4_1 #(N) logic_operations (A, B, F[1:0], Y_logop);

	// output Y
	assign Y = F[2] ? Y_logop:AUout;
  
endmodule

// Q4 4:1 MUX
module MUX4_1 
	#(parameter N = 4)
	(input logic [N-1:0]A,B,
	 input logic [1:0]F,
	 output logic [N-1:0]Y);
	 
	always_comb
	begin
		case(F)
			0: Y = A & B;  // 00 a and b
			1: Y = A | B;  // 01 a or b
			2: Y = A ^ B;  // 10 a xor b
			3: Y = ~(A|B); // 11 a nor b
		endcase
	end
endmodule



// HEX dispany 0 to F Simplified version
module seven_seg(
	input logic [3:0] S,
	output logic [6:0] HEX);
	always_comb
	begin
		case(S)
			4'h0: HEX=7'b1000000;
			4'h1: HEX=7'b1111001;
			4'h2: HEX=7'b0100100;
			4'h3: HEX=7'b0110000;
			4'h4: HEX=7'b0011001;
			4'h5: HEX=7'b0010010;
			4'h6: HEX=7'b0000010;
			4'h7: HEX=7'b1111000;
			4'h8: HEX=7'b0000000;
			4'h9: HEX=7'b0010000;
			4'ha: HEX=7'b0001000;
			4'hb: HEX=7'b0000011;
			4'hc: HEX=7'b1000110;
			4'hd: HEX=7'b0100001;
			4'he: HEX=7'b0000110;
			4'hf: HEX=7'b0001110;

		endcase
	end
endmodule




















