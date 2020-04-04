
module n_bit_shifter #(parameter N=4) (input clk, res, en, dir, [N-1:0] in,
			output reg [N-1:0] out);

	integer i;
	reg [N-1:0] out_next;

	always @(posedge clk) begin
		if (en)
			out = out_next;
		else
			out = in;
	end

	always @(posedge clk or res) begin
		if (res) begin
			out = in;
			out_next = out;
		end else
			if (!dir) begin
				for (i=N-1; i>0; i=i-1)
					out_next[i] = out_next[i-1];
				out_next[0] = 0;
			end else begin
				for (i=0; i<N-1; i=i+1)
					out_next[i] = out_next[i+1];
				out_next[N-1] = 0;
			end
	end

endmodule
