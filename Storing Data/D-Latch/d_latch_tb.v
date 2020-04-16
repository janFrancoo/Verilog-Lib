
module d_latch_tb;

	reg d;
	reg en;
	wire q;
	wire q_;

	d_latch uut (d, en, q, q_);

	initial begin
			
			d = 0; en = 0;
		#5	en = 1;
		#5	d = 1;
		#5	en = 0;
		#5	d = 0;
		#5	en = 1;
		#5	$stop;

	end

endmodule
