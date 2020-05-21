
module div_resoting_tb;

	reg start;
	reg clk;
	reg clrn;
	reg [31:0] a;
	reg [15:0] b;
	
	wire [31:0] q;
	wire [15:0] r;

	signed_div uut (start, clk, clrn, a, b, q, r);

	initial begin
		start = 1; clrn = 0; clk = 0;
		a = -32'd100;
		b = 16'd10;
		#3 clrn = 1;
		#3 start = 1;
		#1 start = 0;
		#200 $stop;
	end

	always #3 clk = ~clk;

endmodule
