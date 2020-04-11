
module n_bit_multiplexer #(parameter N)(input [(N ** 2) - 1:0] in, [N-1:0] sel,
					output out);

	assign out = in[sel];

endmodule
