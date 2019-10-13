//bibby.wang elec4720 Ass1 Q3
//testing 0*0 to 255*255
module Q3_test ();
	logic [7:0] a,b;
	logic [15:0] t,y;

	mult tesT1(a, b, y); // instantiate mult
	
	// apply inputs one at a time and check results
	initial begin
		a=0;//initial value
		b=0;//initial value

		for (int i=0;i<=255;i++)begin
			for (int j=0;j<=255;j++)begin
				#1;
				t=i*j;
				if(y !== t)	$display("Testing:a= %d, b= %d failed.",a,b);
				else $display("Testing:a*b is  %d * %d = %d Passed", a,b,y);
				y=0;
				a=a+1;

			end
			b=b+1;
			a=0; //resit
		end
	end

endmodule

