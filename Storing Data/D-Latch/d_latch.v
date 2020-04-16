
module d_latch (input d, en,
		output q, q_);

	wire s, r, r_in;

	not (r_in, d);
	and (s, en, d);
	and (r, en, r_in);

	nor (q, r, q_);
	nor (q_, s, q);

endmodule
