module Comp_Test;
	reg [1:0]a;
	reg [1:0]b;
	wire gt, eq, lt;

	Comp_2_Bit uut(
		.a(a),
		.b(b),
		.gt(gt),
		.eq(eq),
		.lt(lt)
	);

	initial begin
			a = 2'b00; b = 2'b00;
		#5	a = 2'b00; b = 2'b01;
		#5	a = 2'b01; b = 2'b00;
		#5	a = 2'b11; b = 2'b11;
	end

	initial #20 $stop;

endmodule
