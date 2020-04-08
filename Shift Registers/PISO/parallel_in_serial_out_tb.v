
module piso_tb;
	
	localparam N = 4;
	reg clk;
	reg shift;
	reg [N-1:0] d;
	wire q;

	n_piso #(N) uut (clk, shift, d, q);

	initial begin
			clk = 1'b0; d = 4'b1111; shift = 1'b0;
		#1	shift = 1'b1;
		#1	d = 4'b0000;
		#20	d = 4'b1001;
		#20	d = $random;
		#20	$stop;
	end

	always #5 clk = ~clk;

endmodule
