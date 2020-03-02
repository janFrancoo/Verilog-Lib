module Mux_Test;
	reg [7:0]d;
	reg [2:0]s;
	wire o;

	Mux_8_to_1 uut (
		.d(d),
		.s(s),
		.o(o)
	);
	initial begin
			d = 8'b01010101; s = 3'b000;
		#10	d = 8'b01010101; s = 3'b001;
		#10	d = 8'b01010101; s = 3'b010;
		#10	d = 8'b01010101; s = 3'b011;
		#10	d = 8'b01010101; s = 3'b100;
		#10	d = 8'b01010101; s = 3'b101;
		#10	d = 8'b01010101; s = 3'b110;
		#10	d = 8'b01010101; s = 3'b111;
	end

	initial #90 $stop;
endmodule
