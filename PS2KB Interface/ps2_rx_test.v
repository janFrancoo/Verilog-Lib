
module ps2kb_rx_test;

	reg clk, rst, ps2d, ps2c, rx_en;
	wire rx_done_tick;
	wire [7:0] dout;

	ps2kb_rx uut(.clk(clk), .rst(rst), .ps2d(ps2d), .ps2c(ps2c), .rx_en(rx_en), .rx_done_tick(rx_done_tick), .dout(dout));

	initial begin
			rst = 1; rx_en = 1; clk = 0; ps2c = 1; ps2d = 1;
		#3	rst = 0;
		forever #20 ps2d = $random;
	end

	always #1 clk = ~clk;
	always #10 ps2c = ~ps2c;

	initial #1000 $stop;

endmodule
