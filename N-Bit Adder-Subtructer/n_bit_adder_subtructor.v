
module full_adder (input a, b, c_in,
		output s, c_out);
	
	wire w1, w2, w3;

	xor (s, a, b, c_in);
	and (w1, a, b);
	and (w2, b, c_in);
	and (w3, a, c_in);
	or (c_out, w1, w2, w3);

endmodule


module n_bit_adder_subtructor #(parameter N) (input sub, [N-1:0] a, b,
						output c_out, [N-1:0]s);

	wire [N-1:0] c_out_w;

	genvar i;
	generate
		for (i=0; i<N; i=i+1) begin
			if (i == 0)
				full_adder fa (a[i], b[i] ^ sub, 0 ^ sub, s[i], c_out_w[i]);
			else
				full_adder fa (a[i], b[i] ^ sub, c_out_w[i-1], s[i], c_out_w[i]);
		end
	endgenerate

	assign c_out = c_out_w[N-1];

endmodule
