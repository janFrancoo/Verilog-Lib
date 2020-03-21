
module sr_latch_test;
	reg s, r;
	wire q;

	m_sr_latch uut (.q(q), .s(s), .r(r));
	
	initial begin
			s = 1'b1; r = 1'b1;
		#5	s = 1'b1; r = 1'b0;
		#5	s = 1'b0; r = 1'b1;
		#5	s = 1'b0; r = 1'b0;
		#5	s = 1'b0; r = 1'b0;
		#5	s = 1'b1; r = 1'b0;
		#5	s = 1'b0; r = 1'b0;
		#5	s = 1'b0; r = 1'b0;
		#5	s = 1'b0; r = 1'b0;
	end

	initial #50 $stop;

endmodule
