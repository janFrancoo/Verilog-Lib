
module fp_multiplication(input [31:0] f_1, f_2,
							output f_nan, f_inf, [31:0] s);

	localparam N = 24;

	wire sign;
	wire [7:0] tmp_exp, exp;
	wire [47:0] mantissa_mult_res;
	wire [22:0] tmp_mantissa, mantissa;
	wire mantissa_all_zeros, exp_all_ones, exp_all_zeros;
	wire zero_condition;
	
	// sign
	assign sign = f_1[31] ^ f_2[31];
	
	// exp
	assign tmp_exp = f_1[30:23] + f_2[30:23] - 32'd127;
	
	// mantissa
	// mult
	unsigned_binary_multiplier #(N) mantissa_mult ({1'b1, f_1[22:0]}, {1'b1, f_2[22:0]}, 
													mantissa_mult_res);
	// normalizing -> if carry = 1, shift right (+1 exp)
	assign exp = (mantissa_mult_res[47] == 1'b1) ? (tmp_exp + 1'b1) : tmp_exp;
	assign tmp_mantissa = mantissa_mult_res[46:24];
	// round
	assign mantissa = (tmp_mantissa[2] == 1'b1) ? (tmp_mantissa + 1'b1) : tmp_mantissa;
	
	// special cases
	// e == 255, f == 0, inf
	// e == 255, f != 0, nan
	// e == 0, f == 0, 0
	assign mantissa_all_zeros = ~|mantissa;
	assign exp_all_ones = &exp;
	assign exp_all_zeros = ~|exp;
	assign f_nan = exp_all_ones & ~mantissa_all_zeros;
	assign f_inf = exp_all_ones & mantissa_all_zeros;
	assign zero_condition = exp_all_zeros & mantissa_all_zeros;
	
	// assign s = (zero_condition) ? 32'b0 : {sign, exp, mantissa};
	assign s = {sign, exp, mantissa};
	
	initial forever #4 $display("%t %b %b %b %b", $time, s, mantissa_mult_res, tmp_mantissa, mantissa);

endmodule

module unsigned_binary_multiplier #(parameter N) (input [N-1:0] x, y,
						output reg [(2*N)-1:0] res);

	reg [N-1:0] i = 0;
	reg [(2*N)-1:0] t_x;

	always @ (x or y) begin
		res = 0;
		t_x = x;
		for (i=0; i<N; i=i+1) begin
			if (y[i] == 1)
				res = res + t_x;
			t_x = t_x << 1;
		end
	end

endmodule
