
module carry_save_adder_6_bit (input [5:0] a, b, c_in,
				output [5:0] c_out, s);

	genvar i;
	generate 
		for (i=0; i<6; i=i+1) begin
			full_adder fa (a[i], b[i], c_in[i], c_out[i], s[i]);
		end
	endgenerate

endmodule

module full_adder (input a, b, c_in,
			output c_out, s);

	assign s = a ^ b ^ c_in;
	assign c_out = (a & b) | (c_in & (a ^ b));

endmodule
