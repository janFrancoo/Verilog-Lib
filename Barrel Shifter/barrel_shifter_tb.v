
module barrel_shifter_tb;

	localparam N = 5;
	reg [$clog2(N)-1:0] shift;
	reg [N-1:0] in;
	wire [N-1:0] out;

	barrel_shifter #(N) uut (shift, in, out);
	
	initial begin
			shift = 2'b11; in = 5'b10111;
		#5	in = 5'b00111;
		#5	in = 5'b10001;
		#5	in = 5'b10101;
		#5	in = 5'b10000;
		#5	$stop;
	end

endmodule
