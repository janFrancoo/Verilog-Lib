
module carry_look_ahead_adder(input c_in, [3:0] a, b,
				output c_out, [3:0] s);

	wire [3:0] generator, propagator, carry;

	assign generator = a & b;
	assign propagator = a ^ b;

	assign c_out = generator[3] + (propagator[3] & generator[2] & generator[1]) + (propagator[3] & propagator[2] & propagator[1] & generator[0]) + 
			(propagator[3] & propagator[2] & propagator[1] & propagator[0] & c_in);
	assign carry[3] = generator[2] + (propagator[2] & generator[1]) + (propagator[2] & generator[1] & generator[0]) + 
			(propagator[2] & propagator[1] & propagator[0] & c_in); 
	assign carry[2] = generator[1] + (propagator[1] & generator[0]) + (propagator[1] & propagator[0] & c_in);
	assign carry[1] = generator[0] + (propagator[0] & c_in);
	assign carry[0] = c_in;
	
	assign s = propagator ^ carry;
	
endmodule
