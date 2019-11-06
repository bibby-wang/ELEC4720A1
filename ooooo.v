
//***MUL/DIV***//
module multiply_divide 
	#(parameter n = 4)
	(input logic clk,
	 input logic [3:0] F, 
	 input logic [n-1:0] a, b,
	 output logic [n-1:0] y, 
	 output logic [2*n-1:0] out_2n);
  
	//intermediate logic
	logic [n-1:0] hi, lo;
	logic [n-1:0] R, Q;   //remainder and quotient from division operation
	logic [n-1:0] H, L;   //high and low bytes of the multiplication operation

	//Division and multiplication operations
	assign Q = a/b;
	assign R = a%b;
	assign {H,L} = a * b;

	logic En1,En2;   //control/enable signals derived from the F input signal

	assign En1 = F[3] | (~F[1] & F[0]);
	assign En2 = F[3] | ( F[1] & F[0]);

	//Intermediate logic
	logic [n-1:0] operation_hi, operation_lo, ff_input_hi, ff_input_lo;

	always_comb 
	begin  
	//Select one of the multiplication/division outputs
	  operation_hi <=F[1]? H:R;
	  operation_lo <=F[1]? L:Q;
	//select the operation output or a constant value
	  ff_input_hi <=F[3]? operation_hi:a;
	  ff_input_lo <=F[3]? operation_lo:a;
	//multiplexer to choose hi or lo as the final output
	  y =F[1]? hi:lo;
	end

	//if at the positive edge of the clk, and the register is enabled, pass output of above module to the output of the register
	always_ff @(posedge clk) 
	begin
	if (En1) hi <= ff_input_hi;
	if (En2) lo <= ff_input_lo;
	end


	//used simply to display result
	assign out_2n = {hi,lo};

endmodule
