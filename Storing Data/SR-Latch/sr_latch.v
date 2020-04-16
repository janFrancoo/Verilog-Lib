
module sr_latch (input s, r,
			output q, q_);

	nor (q_, q, s);
	nor (q, q_, r);

endmodule
