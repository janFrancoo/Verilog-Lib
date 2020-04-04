
module n_bit_shifter_tb;

	parameter N=8;
	reg clk, res, en, dir;
	reg [N-1:0] in;
	wire [N-1:0] out;

	n_bit_shifter #(.N(N)) uut (.clk(clk), .res(res), .en(en), .dir(dir), .in(in), .out(out));

	initial begin
		in = 8'b10010101; en = 1'b1; res = 1'b1; dir = 1'b0; clk = 1'b1;
		#1 res = 1'b0;
		#19 dir = 1'b1;
		#100 $stop;
	end

	always #5 clk = ~clk;

endmodule
