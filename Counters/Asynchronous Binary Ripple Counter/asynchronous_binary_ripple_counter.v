
module async_binary_ripple #(parameter N) (input clk, reset, 
				output reg [N-1:0] Q);

	genvar i;
	generate
		for (i=0; i<N; i=i+1) begin
			if (i == 0)
				always @(negedge clk or negedge reset)
					if (!reset) Q[0] <= 1'b0;
					else	Q[0] <= ~Q[0];
			else
				always @(negedge Q[i-1])
					if (!reset) Q[i] <= 1'b0;
					else	Q[i] <= ~Q[i];
		end
	endgenerate

endmodule
