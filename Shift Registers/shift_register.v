
module shift_register #(parameter N=4)(input clk, rst, load, d,
					output reg [N-1:0] q);

	always @(posedge clk or negedge rst) begin
		if (!rst)	q <= 0;
		if (load)	q <= {d, q[N-1:1]};
	end

endmodule
