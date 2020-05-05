
module dff (input clk, d,
				output reg q);

	always @ (posedge clk) begin
		q <= d;
	end

endmodule

module clock_divider #(parameter DIV) (input clk, 
					output clk_out);

	reg [15:0] cnt = 16'b0;
	
	always @ (posedge clk) begin
		cnt <= cnt + 1;
		if (cnt >= (DIV - 1))
			cnt <= 16'b0;
	end
	
	assign clk_out = (cnt < (DIV / 2)) ? 1'b0 : 1'b1;

endmodule

module debounce(input btn, clk,
					output btn_out, single_pulse_out);
					
	wire slower_clk, q1, q2, q2_;
	
	clock_divider #(2) clk_div (clk, slower_clk);
	dff d1 (slower_clk, btn, q1);
	dff d2 (slower_clk, q1, q2);
	
	assign btn_out = q1;
	
	assign q2_ = ~q2;
	assign single_pulse_out = q1 & q2_;

endmodule
