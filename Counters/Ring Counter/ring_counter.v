
module ring_counter #(parameter N)(input clk, reset, 
			output reg [0:N-1] Q);

	always @(posedge clk or negedge reset) begin
		if (!reset) Q <= {1'b1, {N-1{1'b0}}};
		else	Q <= {Q[N-1], Q[0:N-2]};
	end

endmodule
