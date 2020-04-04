
module mux_test;

	localparam N = 2;

	reg [N-1:0] i0, i1, i2, i3;
	reg [1:0] sel0, sel1;
	wire [(2 * N)-1:0] out;

	mux_4x2 #(.N(N)) uut (.i0(i0), .i1(i1), .i2(i2), .i3(i3), .sel0(sel0), .sel1(sel1), .out(out));
	integer i;

	initial begin
		i0 = 2'b00; i1 = 2'b01; i2 = 2'b10; i3 = 2'b11; sel0 = 2'b00; sel1 = 2'b00;
		for (i=0; i<16; i=i+1)
			#5 {sel1, sel0} = i;
		#100 $stop;
	end

endmodule
