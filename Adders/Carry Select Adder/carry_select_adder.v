
module carry_select_adder_4x4 (input c_in, [15:0] a, b,
				output c_out, [15:0] s);

	wire [2:0] carry;

	carry_select_adder_four_bit s0 (c_in, a[3:0], b[3:0], carry[0], s[3:0]);
	carry_select_adder_four_bit s1 (carry[0], a[7:4], b[7:4], carry[1], s[7:4]);
	carry_select_adder_four_bit s2 (carry[1], a[11:8], b[11:8], carry[2], s[11:8]);
	carry_select_adder_four_bit s3 (carry[2], a[15:12], b[15:12], c_out, s[15:12]);

endmodule

module carry_select_adder_four_bit (input c_in, [3:0] a, b,
					output c_out, [3:0] s);

	genvar i;
	wire [3:0] carry_zero;
	wire [3:0] carry_one;
	wire [3:0] sum_zero;
	wire [3:0] sum_one;

	generate
		for (i=0; i<4; i=i+1) begin
			if (i==0) begin
				full_adder fa_zero (a[i], b[i], 1'b0, carry_zero[i], sum_zero[i]);
				full_adder fa_one (a[i], b[i], 1'b1, carry_one[i], sum_one[i]);
			end else begin
				full_adder fa_zero (a[i], b[i], carry_zero[i-1], carry_zero[i], sum_zero[i]);
				full_adder fa_one (a[i], b[i], carry_one[i-1], carry_one[i], sum_one[i]);
			end
			mux_2x1 sel_sum (sum_zero[i], sum_one[i], c_in, s[i]);
		end
	endgenerate

	mux_2x1 sel_c_out (carry_zero[3], carry_one[3], c_in, c_out);

endmodule

module full_adder (input a, b, c_in,
			output c_out, s);

	assign s = (a ^ b) ^ c_in;
	assign c_out = (a & b) | ((a ^ b) & (c_in));

endmodule

module mux_2x1 (input a, b, sel,
		output o);

	assign o = (sel == 0) ? a : b;

endmodule
