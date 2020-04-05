
module sr_latch_test;

	reg s, r;
	wire q, q_;

	sr_latch uut (.S(s), .R(r), .Q(q), .Q_(q_));

	initial begin
			s = 1'b1; r = 1'b0;
		#1	s = 1'b0; r = 1'b0;

		#10	s = 1'b1;
		#1	s = 1'b0;
		
		#10	r = 1'b1;
		#1	r = 1'b0;

		#10	s = 1'b1;
		#1	s = 1'b0;

		#10	r = 1'b1;
		#1	r = 1'b0;

		#50 	$stop;
	end

endmodule
