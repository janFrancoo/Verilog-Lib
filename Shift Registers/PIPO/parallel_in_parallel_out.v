
module flip_flop(input clk, d, reset,
		output reg q);

	always @(posedge clk or negedge reset) begin
		if (!reset) q <= 0;
		else	q <= d;
	end

endmodule

module n_pipo #(parameter N)(input clk, clear, [N-1:0] d,
			output [N-1:0] Q);

	genvar i;
	generate
		for (i=0; i<N; i=i+1)
			flip_flop ff (clk, d[i], clear, Q[i]);
	endgenerate

endmodule
