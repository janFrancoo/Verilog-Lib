
module n_bit_multiplexer_tb;

	localparam N = 3;
	reg [(2 ** N) - 1:0]in;
	reg [N-1:0] sel;
	wire out;
	integer i;

	n_bit_multiplexer #(N) uut (in, sel, out);
	
	initial begin
			in = 8'b10111101;
			for (i=0; i<(2 ** N); i=i+1)
		#5		sel = i;
		#5	$stop;
	end

endmodule
