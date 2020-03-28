
module detect_110101_tf;
	reg clk, in, rst;
	wire out;

	detect_110101 uut (.clk(clk),
			.rst(rst),
			.in(in),
			.out(out));

	initial begin
		clk <= 0; rst <= 0; in <= 0;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 0;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 0;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 0;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 0;
		@(posedge clk) in <= 1;
		@(posedge clk) in <= 1;

		#80 $stop;
	end

	always #5 clk = ~clk;

endmodule
