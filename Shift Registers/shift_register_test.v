
module shift_register_test;

	parameter N = 4;	
	reg clk;
	reg rst;
	reg load;
	reg d;
	wire [N-1:0] q;

	shift_register #(.N(N)) uut (.clk(clk), .rst(rst), .load(load), .d(d), .q(q));

	initial begin
				clk = 1'b1; rst = 1'b1; load = 1'b1; d = 1'b1;
		repeat(10) #5	d = $random;	
		#50		$stop;
	end	

	always #5 clk = ~clk;

endmodule
