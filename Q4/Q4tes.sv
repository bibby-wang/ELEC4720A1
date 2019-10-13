module Q4tes();
	logic [7:0] a,b;
	logic [1:0] f;
	logic [7:0]out;
	
	MUX4_1 tsQ4(a,b,f,out);
	initial begin
		assign a=8'b1010_1011;
		assign b=8'b1100_1100;
		f=0;
		for(int i=0;i<4;i++)begin
		#1;
		
		$display("test:a= %d, b= %d ",a,b);
		$display("test:f= %d, out= %d ",f,out);
		f=i+1;
		end
	end
endmodule



