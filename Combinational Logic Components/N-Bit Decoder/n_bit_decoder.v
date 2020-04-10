
module n_bit_decoder #(parameter N) (input enable, [N-1:0] in, 
				output reg [(2**N)-1:0] out);

	always @(in or enable) begin
		if (!enable) out <= 0;
		else begin
			out <= 0;
			out[in] <= 1'b1;
		end
	end

endmodule
