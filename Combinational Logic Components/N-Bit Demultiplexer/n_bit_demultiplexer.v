
module n_bit_demultiplexer #(parameter N) (input in, enable, [N-1:0] sel, 
				output reg [(2 ** N)-1:0] out);

	always @(enable or sel) begin
		if (!enable) out <= 0;
		else begin
			out <= 0;
			out[sel] <= in;
		end
	end

endmodule
