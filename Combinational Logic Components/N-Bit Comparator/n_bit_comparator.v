
module n_bit_comparator #(parameter N)(input a_gt_b, a_eq_b, a_lt_b, [N-1:0] a, b,
					output o_a_gt_b, o_a_eq_b, o_a_lt_b);

	assign o_a_gt_b = (a > b) || ((a == b) && (a_gt_b));
	assign o_a_eq_b = (a == b) && (a_eq_b);
	assign o_a_lt_b = (a < b) || ((a == b) && (a_lt_b));

endmodule
