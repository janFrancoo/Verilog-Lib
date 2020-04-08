
module n_piso #(parameter N)(input clk, shift, [N-1:0] d,
			output reg q);

	reg [N-1:0] Q;

	always @(posedge clk or shift) begin
		if (!shift) Q <= d;
		else begin
			q <= Q[0];
			Q <= {d[N-1], Q[N-1:1]};
		end	
	end

	initial forever #5 $display("%b", Q);

endmodule
