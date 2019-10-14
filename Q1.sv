module Ass1(
	input logic [3:0] SW,
	output logic [6:0] HEX0
);
	logic [3:0] Result;

	seven_seg  disp0(SW[3:0], HEX0);
	
endmodule


//Binbin Wang c3214157 elec4720 Ass1 Q1
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
