
module universal_shift_register_test;
	
	parameter N = 4;
	reg clk;
	reg rst;
	reg data;
	reg s0;
	reg s1;
	reg [N-1:0] wData;
	wire [N-1:0] q;

	universal_shift_register #(.N(N)) uut (.clk(clk), 
						.rst(rst), 
						.data(data), 
						.s0(s0), .s1(s1), 
						.wData(wData), .q(q));

	initial begin
			clk = 1'b1; rst = 1'b1; {s0, s1} = 2'b01; wData = 4'b1111; data = 1'b1;
		#5	data = 1'b0;
		#5	data = 1'b1;
		#5	data = 1'b1;
		#5	data = 1'b0;
		#5	data = 1'b1; 
		#1	rst = 1'b0;
		#4	rst = 1'b1; data = 1'b1; {s0, s1} = 2'b10;
		#50	$stop;
	end

	always #5 clk = ~clk;

endmodule
