
module sr_latch (input S, R,
		output Q, Q_);

	nor (Q_, Q, S);
	nor (Q, Q_, R);

endmodule
