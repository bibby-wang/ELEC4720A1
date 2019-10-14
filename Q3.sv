//Binbin Wang c3214157 elec4720 Ass1 Q3
//two 8 bit wide numbers to produce a 15 bit wide result of multiplication.

module mult(
		input logic [7:0] a, b,
		output [15:0] out);
		
		assign out = {8'b0, a[7:0]*b[0]} + 		// i=1
					 {7'b0, a[7:0]*b[1], 1'b0} + // i=2
					 {6'b0, a[7:0]*b[2], 2'b0} + // i=3
					 {5'b0, a[7:0]*b[3], 3'b0} + // i=4
					 {4'b0, a[7:0]*b[4], 4'b0} + // i=5
					 {3'b0, a[7:0]*b[5], 5'b0} + // i=6
					 {2'b0, a[7:0]*b[6], 6'b0} + // i=7
					 {1'b0, a[7:0]*b[7], 7'b0};  // i=8

endmodule





