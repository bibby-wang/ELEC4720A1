module Q6(
	input logic [5:0] SW,
	output logic [6:0] LEDG,
	output logic [5:0] LEDR
	);

	//input number dispaly
	assign LEDR = SW;

	//instruction_Classifier_6 out(SW[5:0],LEDG[6],LEDG[5],LEDG[4],LEDG[3],LEDG[2],LEDG[1],LEDG[0]);
	Priority_6 p4(SW[5:0],LEDG[6:0]);
endmodule

//Q6
module Priority_6
	(input logic [5:0] a,
	 output logic [6:0] b);

	logic [2:0] e;
	logic [4:0] f;
	
	Priority_2 a54(a[5:4],e[2:0]);
	Priority_4 a30(a[3:0],f[4:0]);
	
	assign b[6:5] = e[2:1];
	assign b[4:0] = f[4:0] & {5{e[0]}};

endmodule
//do not know down part
// 4-bit priority circuit from 2-bit priority circuits
module Priority_4	
	(input logic [3:0] a,
	 output logic [4:0] b);

	logic [2:0] e;
	logic [2:0] f;
	
	Priority_2 a32(a[3:2],e[2:0]);
	Priority_2 a10(a[1:0],f[2:0]);

	assign b[4:3] = e[2:1];
	assign b[2:0] = f[2:0] & {3{e[0]}};
	
	
endmodule
// 2-bit priority circuit from 1-bit priority circuits
module Priority_2	
	(input logic [1:0] a,
	 output logic [2:0] b);

	logic [1:0] e;
	logic [1:0] f;
	
	Priority_1 a0(a[0],f[1:0]);
	Priority_1 a1(a[1],e[1:0]);

	assign b[2] = e[1];
	assign b[1] = e[0] & f[1];
	assign b[0] = e[0] & f[0];


endmodule
// 1-bit priority circuits
module Priority_1	
	(input logic a,
	 output logic [1:0] b);
	assign b[0]= ~a;
	assign b[1]= a;	
	
endmodule