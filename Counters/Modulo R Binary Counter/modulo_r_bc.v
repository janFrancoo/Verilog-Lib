
module modulo_r_bc #(parameter N, R) (input clk, reset, enable, 
			output cout, output reg [N-1:0] Q);

	assign cout = (Q == R-1);

	always @(posedge clk or negedge reset) begin
		if (!reset) Q <= 0;
		else if (enable)
			if (cout) Q <= 0;
			else	Q <= Q + 1;
	end

endmodule
