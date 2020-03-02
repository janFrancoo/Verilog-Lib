module Comp_1_Bit(a, b, gt, eq, lt);
	
	input a, b;
	output gt, eq, lt;

	assign gt = a > b;
	assign eq = a == b;
	assign lt = a < b;

endmodule
