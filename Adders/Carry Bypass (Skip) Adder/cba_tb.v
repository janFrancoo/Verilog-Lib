
module carry_bypass_skip_adder_tb;

	reg c_in;
	reg [3:0] a, b;
	wire c_out;
	wire [3:0] s;

	carry_bypass_adder uut (c_in, a, b, c_out, s);

	initial begin
				   a = $random; b = $random; c_in = 0;
		repeat(5) begin #5 a = $random; b = $random; end 
				#5 $stop;
	end

endmodule
