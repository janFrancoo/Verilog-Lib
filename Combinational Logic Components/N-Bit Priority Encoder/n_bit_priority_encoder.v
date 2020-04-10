

module n_bit_encoder #(parameter N) (input enable, [(2 ** N) - 1:0] in,
					output reg [N-1:0] out);

	reg count;
	reg [N-1:0] counter;
	integer i;

	always @(in or enable) begin
		if (!enable) out = 0;
		else begin
			counter = 0; count = 1;
			for (i=(2 ** N); i>0; i=i-1) begin
				if (in[i] == 0 && count) counter = counter + 1;
				else if (in[i] == 1) count = 0;
			end
			out = counter;
			out = ~out;
		end
	end

endmodule
