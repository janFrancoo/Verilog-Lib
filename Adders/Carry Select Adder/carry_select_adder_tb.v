
module full_adder_and_mux_tb;

	reg a, b, c, d;
	reg sel, c_in;
	wire s, o, c_out;

	full_adder uut (a, b, c_in, c_out, s);
	mux_2x1 uut_2 (c, d, sel, o);
	
	initial begin
			a = 1; b = 1; c_in = 0;
			c = 1; d = 0; sel = 1;
		#5	c_in = 1; sel = 0;
		#5	a = 0;
		#5	$stop;
	end

endmodule

module carry_select_adder_four_bit_tb;

	reg c_in;
	reg [3:0] a, b;
	wire c_out;
	wire [3:0] s;

	carry_select_adder_four_bit uut (c_in, a, b, c_out, s);

	initial begin
			a = 4'b0000; b = 4'b0000; c_in = 1'b0;
		#5	a = 4'b1110; b = 4'b0001;
		#5	a = 4'b0011; b = 4'b1000;
		#5	a = 4'b1111; b = 4'b1111;
		#5	$stop;
	end

endmodule

module carry_select_adder_4x4_tb;

	reg c_in;
	reg [15:0] a, b;
	wire c_out;
	wire [15:0] s;

	carry_select_adder_4x4 uut (c_in, a, b, c_out, s);

	initial begin
				   a = $random; b = $random; c_in = 0;
		repeat(3) #5 begin a = $random; b = $random; end
		c_in = 1;
		repeat(3) #5 begin a = $random; b = $random; end
		#5	$stop;
	end

endmodule
