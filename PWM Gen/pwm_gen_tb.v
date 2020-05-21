
module pwm_gen_tb;

	reg clk;
	reg increse_duty;
	reg decrease_duty;
	wire pwm_out;

	pwm_gen uut (clk, increse_duty, decrease_duty, pwm_out);
	
	integer i;
	
	initial begin
			clk = 1'b1; increse_duty = 1'b0; decrease_duty = 1'b0;
		#30	increse_duty = 1'b1;
		#3	increse_duty = 1'b0;
		for (i=0; i<5; i=i+1) begin
			#10	increse_duty = 1'b1;
			#3	increse_duty = 1'b0;
		end
		#30	decrease_duty = 1'b1;
		#3	decrease_duty = 1'b0;
		#80	$stop;
	end
	
	always #1 clk = ~clk;
				
endmodule
