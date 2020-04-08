
module pipo_tb;
	
	localparam N = 4;
	reg clk;
	reg clear;
	reg [N-1:0] d;
	wire [N-1:0] Q;

	n_pipo #(N) uut (clk, clear, d, Q);

	initial begin
			clk = 1'b0; clear = 1'b1; d = 4'b0000;
		#5	d = 4'b1111;
		#5	d = 4'b1010;
		#5	d = 4'b1100;
		#5	d = 4'b1001;
		#2	clear = 1'b0;
		#1	clear = 1'b1;
		#2	d = $random;
		#10	d = $random;
		#10	d = $random;
		#10	d = $random;

		#75	$stop;
	end

	always #5 clk = ~clk;

endmodule
