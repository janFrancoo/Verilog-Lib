

module siso_tb;
	
	localparam N = 4;
	reg clk;
	reg clear;
	reg d;
	wire q;

	n_siso #(N) uut (clk, clear, d, q);

	initial begin
			clk = 1'b0; clear = 1'b1; d = 1'b0;
		#5	d = 1'b1;
		#5	d = 1'b1;
		#5	d = 1'b0;
		#5	d = 1'b1;
		#2	clear = 1'b0;
		#1	clear = 1'b1;
		#2	d = 1'b1;
		#10	d = 1'b0;
		#10	d = 1'b1;
		#10	d = 1'b0;

		#75	$stop;
	end

	always #5 clk = ~clk;

endmodule
