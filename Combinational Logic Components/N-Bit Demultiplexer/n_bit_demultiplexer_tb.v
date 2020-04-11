
module n_bit_demultiplexer_tb;

	localparam N = 3;
	reg in;
	reg enable;
	reg [N-1:0] sel;
	wire [(2 ** N)-1:0] out;
	integer i;

	n_bit_demultiplexer #(N) uut (in, enable, sel, out);

	initial begin
			in = 1'b1; enable = 0; sel = 0;
		#5	enable = 1;
			for (i=1; i<(2 ** N); i=i+1)
		#5		sel = i;
		#5	$stop;
	end

endmodule
