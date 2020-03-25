
module n_bit_adder_test;

	parameter N = 8;

	reg [N-1:0] x, y;
	reg c_in;
	wire [N-1:0] sum;
	wire c_out;

	adder_n_bit #(.N(N)) uut (.x(x), .y(y), .c_in(c_in), .sum(sum), .c_out(c_out));
	
	initial begin
			x = 8'b00000000; y = 8'b00000000; c_in = 1'b0;
		#5	x = 8'b00000001; y = 8'b00000001;
		#5	x = 8'b01010101; y = 8'b10101010;
		#5	x = 8'b00000111; y = 8'b11110001;
		#5	x = 8'b00000011; y = 8'b11110110;
	end

	initial #20 $stop;

endmodule
