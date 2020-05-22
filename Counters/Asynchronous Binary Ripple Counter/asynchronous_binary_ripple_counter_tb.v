
module async_binary_ripple_tb;

	localparam N = 8;
	reg clk;
	reg reset;
	wire [N-1:0] Q;
	
	async_binary_ripple #(N) uut (clk, reset, Q);

	initial begin
			reset = 1'b0; clk = 1'b0;
		#5	reset = 1'b1;
		#95	reset = 1'b0;
		#1	reset = 1'b1;
		#49	$stop;	
	end

	always #1 clk = ~clk;

endmodule
