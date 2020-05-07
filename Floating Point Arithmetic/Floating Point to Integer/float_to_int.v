// v = s_eeeeeeee_fffffffffffffffffffffff
// if s == 1, v < 0 else v > 0
// if e in 0-255, v = 1.f x 2^(e-127)
// if e == 0, v = 0.f x 2^(-126) -> denormalized
// if e == 0 && f == 0, v = 0
// if e == 255, v = nan
// if e == 255 && f == 0, v = inf

module float_to_int(input [31:0] v,
					output denorm, reg p_lost, invalid, [31:0] d);
					
	wire hidden_bit, frac_is_not_0, is_zero, sign;
	wire [8:0] shift_right_bits;
	wire [31:0] int32, frac0, f_abs;
	
	assign hidden_bit = |v[30:23];
	assign frac_is_not_0 = |v[22:0];
	
	assign denorm = ~hidden_bit & frac_is_not_0;
	assign is_zero = ~hidden_bit & ~frac_is_not_0;
	assign sign = v[31];
	
	assign shift_right_bits = 9'd158 - {1'b0, v[30:23]};
	assign frac0 = {hidden_bit, v[22:0], 8'b0};
	assign f_abs = frac0 >> shift_right_bits;
	
	assign int32 = sign ? ~f_abs + 1 : f_abs;
	
	always @ (*) begin
		if (denorm) begin
			p_lost = 1;
			invalid = 0;
			d = 32'b0;
		end else begin
			if (shift_right_bits[8]) begin	// if e > 158 shift_right_bits[8] == 1
				p_lost = 0;
				invalid = 1;
				d = 32'h80000000;
			end else begin
				if (shift_right_bits[7:0] > 8'h1f) begin	// e < 126
					if (is_zero) p_lost = 1;
					else	p_lost = 0;
					invalid = 0;
					d = 32'b0;
				end else begin
					if (sign != int32[31]) begin
						p_lost = 0;
						invalid = 1;
						d = 32'h80000000;
					end else begin
						invalid = 0;
						p_lost = 0;
						d = int32;
					end
				end
			end
		end
	end
	
endmodule
