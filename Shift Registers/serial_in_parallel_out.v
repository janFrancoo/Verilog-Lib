
module flip_flop(input clk, d, reset,
		output reg q);

	always @(posedge clk or negedge reset) begin
		if (!reset) q <= 0;
		else	q <= d;
	end

endmodule

module n_sipo #(parameter N)(input clk, clear, d,
			output [N-1:0] Q);

	genvar i;
	generate
		for (i=0; i<N; i=i+1) begin
			if (i == 0) flip_flop ff (clk, d, clear, Q[i]);
			else flip_flop ff (clk, Q[i-1], clear, Q[i]);
		end
	endgenerate

endmodule
