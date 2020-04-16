
module sr_latch_tb;

	reg s;
	reg r;
	wire q;
	wire q_;

	sr_latch uut (s, r, q, q_);

	initial begin
			
			s = 1; r = 0;
		#5	s = 0;
		#5	r = 1;
		#1	r = 0;
		#4	s = 1;
		#1 	s = 0;
		#5	$stop;

	end

endmodule
