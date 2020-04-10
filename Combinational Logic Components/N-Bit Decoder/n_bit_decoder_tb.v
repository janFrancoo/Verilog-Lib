
module n_bit_decoder_tb;
	
	integer i;
	localparam N = 3;
	reg enable;
	reg [N-1:0] in;
	wire [(2**N)-1:0] out;

	n_bit_decoder #(N) uut (enable, in, out);

	initial begin
			enable = 1'b0; in = 3'b000;
		#5	enable = 1'b1;
			for (i=1; i<(2**N); i=i+1)
		#5 		in = i;
		#5	$stop;
		
			
	end

endmodule
