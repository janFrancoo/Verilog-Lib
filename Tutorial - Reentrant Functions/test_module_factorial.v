
module factorial_test;

	reg [7:0] n;
	wire [15:0] result;

	factorial uut (.n(n), .result(result));
	
	initial begin
			n = 8'b00000000;
		#5	n = 8'b00000001;
		#5	n = 8'b00000010;
		#5	n = 8'b00000011;
		#5	n = 8'b00000100;
		#5	n = 8'b00000101;
		#5	n = 8'b00000110;
		#5	n = 8'b00000111;
		#5	n = 8'b00001000;
	end

	initial #50 $stop;

endmodule
