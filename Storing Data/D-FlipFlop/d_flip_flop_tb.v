
module d_flip_flop_tb;

	reg d;
	reg clk;
	wire q;
	wire q_;

	d_flip_flop uut (d, clk, q, q_);

	initial begin
			clk = 0; d = 0;
		#3	d = 1;
		#8 	d = 0;
		#2	d = 1;
		#1	d = 0;
		#5	$stop;
	end

	always #4 clk = ~clk;

endmodule
