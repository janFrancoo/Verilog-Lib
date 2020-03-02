module Comp_2_Bit(a, b, gt, eq, lt);

	input [1:0]a;
	input [1:0]b;
	wire pgt, peq, plt;
	output gt, eq, lt;

	Comp_1_Bit uut(.a(a[0]), .b(b[0]), .gt(pgt), .eq(peq), .lt(plt));

	assign gt = (a[1] > b[1]) || ((a[1] == b[1]) && (pgt == 1));
	assign eq = (a[1] == b[1]) && (peq == 1);
	assign lt = (a[0] < b[0]) || ((a[1] == b[1] && (plt == 1)));

endmodule
