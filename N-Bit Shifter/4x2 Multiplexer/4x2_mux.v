
module mux_4x1 #(parameter N=1) (input [N-1:0] i0, [N-1:0] i1, [N-1:0] i2, [N-1:0] i3, [1:0] sel,
				output [N-1:0] out);

	assign out = sel == 2'b00 ? i0 : (sel == 2'b01 ? i1 : (sel == 2'b10 ? i2 : i3));

endmodule

module mux_4x2 #(parameter N=1) (input [N-1:0] i0, [N-1:0] i1, [N-1:0] i2, [N-1:0] i3, [1:0] sel0, [1:0] sel1,
				output [(2 * N)-1:0] out);

	wire [N-1:0] d0, d1;

	mux_4x1 #(.N(N)) m0(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .sel(sel0), .out(d0));
	mux_4x1 #(.N(N)) m1(.i0(i0), .i1(i1), .i2(i2), .i3(i3), .sel(sel1), .out(d1));

	assign out = {d1, d0};

endmodule

