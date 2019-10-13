module Q3_test ();
	logic [7:0] a,b;
	logic [15:0] t,y;

	
// generate clock

	mult tesT1(a, b, y); // instantiate mult
			
	// apply inputs one at a time and check results
	initial begin
		a=0;//initial value
		b=0;//initial value

		for (int i=0;i<=255;i++)begin
			for (int j=0;j<=255;j++)begin
				#1;
				t=i*j;
				if(y !== t)	$display("test:a= %d, b= %d failed.",a,b);
				else $display("test:a*b is  %d * %d = %d ok.", a,b,y);
				y=0;
				a=a+1;

			end
			b=b+1;
			a=0; //resit
		end
	end

	
	
endmodule

