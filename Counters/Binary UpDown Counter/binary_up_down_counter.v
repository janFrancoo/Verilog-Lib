
module binary_up_down #(parameter N) (input clk, reset, enable, mode,
			output cout, bout, output reg [N-1:0] Q);

	always @(posedge clk or negedge reset) begin
		if (!reset) Q <= 0;
		else if (enable) begin
			if (mode) Q <= Q + 1;
			else	Q <= Q - 1;
		end
	end

	assign cout = &Q;
	assign bout = ~|Q;

endmodule
