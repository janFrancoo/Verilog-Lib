
module n_bit_register_test;

	parameter N = 4;
	reg clk;
	reg [N-1:0] d;
	wire [N-1:0] q;

	n_bit_register #(.N(N)) uut (.clk(clk), .d(d), .q(q));

	initial begin
			clk = 1'b1; d = 4'b0000;
		repeat(10) 
			#5 d = $random;
		#50 $stop;
	end

	always #5 clk = ~clk;

endmodule
