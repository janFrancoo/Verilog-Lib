
module full_adder(x, y, c_in, sum, c_out);

	input x, y, c_in;
	output sum, c_out;

	assign {c_out, sum} = x + y + c_in;

endmodule
