
module n_bit_comparator_tb;

	localparam n = 4;
	reg [7:0] a;
	reg [7:0] b;
	wire o_a_gt_b, o_a_gt_b_t;
	wire o_a_eq_b, o_a_eq_b_t;
	wire o_a_lt_b, o_a_lt_b_t;	

	n_bit_comparator #(n) comparator_1 (0, 1, 0, a[3:0], b[3:0], o_a_gt_b_t, o_a_eq_b_t, o_a_lt_b_t);
	n_bit_comparator #(n) comparator_2 (o_a_gt_b_t, o_a_eq_b_t, o_a_lt_b_t, a[7:4], b[7:4], o_a_gt_b, o_a_eq_b, o_a_lt_b);
	
	initial begin
			a = 8'b11111111; b = 8'b11111111;
		#5	a = 8'b11111111; b = 8'b10000000;
		#5	b = 8'b11111111; a = 8'b10000000;
		#5	$stop;
	end

endmodule
