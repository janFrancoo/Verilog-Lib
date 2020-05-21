
module add_sub_tb;

	localparam N = 4;
	reg sub;
	reg [N-1:0] a, b;
	wire c_out;
	wire [N-1:0] s;

	n_bit_adder_subtructor #(N) uut (sub, a, b, c_out, s);

	initial begin
				sub = 0; a = $random; b = $random;
		repeat(5) #5	begin a = $random; b = $random; end
				sub = 1; a = 4'b1111; b = 4'b1111;
			  #5	a = 4'b1010; b = 4'b0011;	
			  #5	a = 4'b1111; b = 4'b1011;	
			  #5	$stop;
	end

endmodule
