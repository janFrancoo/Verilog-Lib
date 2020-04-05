
module n_bit_register_with_async_rst_test;

	parameter N = 4;
	reg clk;
	reg rst;
	reg [N-1:0] d;
	wire [N-1:0] q;

	n_bit_register_with_async_rst #(.N(N)) uut (.clk(clk), .rst(rst), .d(d), .q(q));

	initial begin
			clk = 1'b1; rst = 1'b1; d = 4'b0000;
		#5	d = 4'b1010;
		#5	d = 4'b1111; 
		#1	rst = 1'b0;
		#6	d = 4'b0011; rst = 1'b1;
		repeat(10) 
			#5 d = $random;
		#50 $stop;
	end

	always #5 clk = ~clk;

endmodule
