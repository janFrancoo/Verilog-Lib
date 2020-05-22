
module modulo_r_bc_tb;

	localparam N = 5;
	localparam R = 20;

	reg clk;
	reg reset;
	reg enable;
	wire cout;
	wire [N-1:0] Q;

	modulo_r_bc #(N, R) uut (clk, reset, enable, cout, Q);

	initial begin
			clk = 1'b0; reset = 1'b0; enable = 1'b0;
		#1	reset = 1'b1; enable = 1'b1;
		@(negedge cout) #10 $stop;
	end

	always #5 clk = ~clk;

endmodule
