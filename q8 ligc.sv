// Compilation Report
// Flow Status	Successful - Thu Oct 17 16:41:09 2019
// Quartus Prime Version	18.1.0 Build 625 09/12/2018 SJ Lite Edition
// Revision Name	
// Top-level Entity Name	
// Family	Cyclone V
// Device	5CGXFC5C6F27C7
// Timing Models	Final
// Logic utilization (in ALMs)	31 / 29,080 ( < 1 % )
// Total registers	11
// Total pins	49 / 364 ( 13 % )
// Total virtual pins	0
// Total block memory bits	0 / 4,567,040 ( 0 % )
// Total DSP Blocks	1 / 150 ( < 1 % )
// Total HSSI RX PCSs	0 / 6 ( 0 % )
// Total HSSI PMA RX Deserializers	0 / 6 ( 0 % )
// Total HSSI TX PCSs	0 / 6 ( 0 % )
// Total HSSI PMA TX Serializers	0 / 6 ( 0 % )
// Total PLLs	0 / 12 ( 0 % )
// Total DLLs	0 / 4 ( 0 % )


module cde(
	input logic [9:0]SW, 
	input logic KEY[0], 
	output logic [2:0]LEDR,
	output logic [5:0]LEDG,
	output logic [6:0] HEX3,HEX2,HEX1,HEX0);
	
	logic [2:0]Y;
	logic [7:0]outcheck;
	
	
	multi_div #(.N(3))MD(SW[9:7], SW[6:4], KEY[0], SW[3:0], Y, hiOUT,loOUT);
	
	assign outcheck={{2'b0},hiOUT,loOUT};
	assign LEDR[2:0] = Y;	
	assign LEDG[2:0] = loOUT;
	assign LEDG[5:3] = hiOUT;
	
	seven_seg OUTYh(outcheck[7:4],HEX1);	
	seven_seg OUTYl(outcheck[3:0],HEX0);

	seven_seg OUTA({1'b0,SW[9:7]},HEX3);
	seven_seg OUTB({1'b0,SW[6:4]},HEX2);

endmodule


module multi_div 
	#(parameter N= 4)
	(input logic [N-1:0]A,B, 
	 input logic clk,
	 input logic [3:0]F,			
	 output logic [N-1:0]Y,
	 output logic [N-1:0] out_hi,out_lo);
	 
	logic [N-1:0] Hi,Lo;
	
	always_ff @(posedge clk) 
	begin
	
		if(F[3])begin
			//funr 1000 or 1010
			if (F[1])begin
				Hi <= A % B;
				Lo <= A / B;
			end
			else begin
				{Hi, Lo} <= A * B;
			end
			
		end
		else begin
			//funt 0000--0011
			case (F[1:0])
				0: begin  Y<=Hi; out_hi<=Hi; Lo<=Lo; Hi<=Hi; end
				1: begin Lo<=Lo; Hi<=A; end
				2: begin  Y<=Lo; out_lo<=Lo; Lo<=Lo; Hi<=Hi; end
				3: begin Lo<=A;  Hi<=Hi; end
			endcase
		end
		
	end

endmodule


module seven_seg(
				input logic [3:0] S,
				output logic [6:0] HEX);

	//dispany 0 to f
	
	//~s2 ~s0 | ~s3 s1 | ~s3 s2 s0 | s2 s1 | s3 ~s2 ~s1 | s3 ~s0
	assign HEX[0] = ~((~S[2] & ~S[0]) | (~S[3] & S[1]) | (~S[3] & S[2] & S[0]) | (S[2] & S[1]) | (S[3] & ~S[2] & ~S[1]) | (S[3] & ~S[0]));	
	//~s3 ~s2 | ~s3 ~s1 ~s0 | ~s2 ~s0 | ~s3 s1 s0 | s3 ~s1 s0
	assign HEX[1] = ~((~S[3] & ~S[2]) | (~S[3] & ~S[1] & ~S[0]) | (~S[2] & ~S[0]) | (~S[3] & S[1] & S[0]) | (S[3] & ~S[1] & S[0]));	
	//~s3 ~s1 | ~s3 s0 | ~s1 s0 | ~s3 s2 | s3 ~s2
	assign HEX[2] = ~((~S[3] & ~S[1]) | (~S[3] & S[0]) | (~S[1] & S[0]) | (~S[3] & S[2]) | (S[3] & ~S[2]));	
	//~s3 ~s2 ~s0 | ~s2 s1 s0 | s2 ~s1 s0 | s2 s1 ~s0 | s3 ~s1
	assign HEX[3] = ~((~S[3] & ~S[2] & ~S[0]) | (~S[2] & S[1] & S[0]) | (S[2] & ~S[1] & S[0]) | (S[2] & S[1] & ~S[0]) | (S[3] & ~S[1]) );
	//~s2 ~s0 | s1 ~s0 | s3 s1 | s3 s2
	assign HEX[4] = ~((~S[2] & ~S[0]) | (S[1] & ~S[0]) | (S[3] & S[1]) | (S[3] & S[2]));	
	//~s1 ~s0 | ~s3 s2 ~s1 | s2 ~s0 | s3 ~s2 | s3 s1
	assign HEX[5] = ~((~S[1] & ~S[0]) | (~S[3] & S[2] & ~S[1]) | (S[2] & ~S[0]) | (S[3] & ~S[2]) | (S[3] & S[1]));
	//~s2 s1 | s1 ~s0 | ~s3 s2 ~s1 | s3 ~s2 | s3 s0
	assign HEX[6] = ~((~S[2] & S[1]) | (S[1] & ~S[0]) | (~S[3] & S[2] & ~S[1]) | (S[3] & ~S[2]) | (S[3] & S[0]));
endmodule