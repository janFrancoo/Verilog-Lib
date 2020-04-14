
module carry_save_adder_6_bit_tb;

	reg [5:0] a, b, c_in;
	wire [5:0] c_out, s;

	carry_save_adder_6_bit uut (a, b, c_in, c_out, s);

	initial begin
			     	    a = 6'b1; b = 6'b0; c_in = 6'b0;
		repeat (5) #5 begin a = $random; b = $random; c_in = $random; end
			   #5 	    $stop;
	end

endmodule
