
module n_bit_encoder_tb;

	localparam N = 3;
	reg enable;
	reg [(2 ** N) - 1:0] in;
	wire [N-1:0] out;
	integer i;

	n_bit_encoder #(N) uut (enable, in, out);
	
	initial begin
			enable = 1'b0; in = 8'b0;
		#5	enable = 1'b1;
			for (i=1; i<(2 ** N); i=i+1) begin
		#5		in = 8'b0;
				in[i] = 1'b1;
			end
		#5	$stop;
	end


endmodule
