
module full_adder (input a, b, c_in,
		output c_out, s);
	
	wire w1, w2, w3;    
	
	xor (w1, a, b);
	and (w2, a, b);
 	and (w3, w1, c_in);
 	or (c_out, w2, w3);
    	xor (s, w1, c_in); 

endmodule

module carry_bypass_adder(input c_in, [3:0] a, b,
				output c_out, [3:0] s);

	wire [3:0] carry_o;
	wire [3:0] propagate;
	wire p_bit;

	genvar i;
	generate
		for (i=0; i<4; i=i+1) begin
			if (i == 0)
				full_adder fa (a[i], b[i], c_in, carry_o[i], s[i]);
			else
				full_adder fa (a[i], b[i], carry_o[i-1], carry_o[i], s[i]);
		end
	endgenerate
	
	assign propagate = a ^ b;
	assign p_bit = &propagate;
	assign c_out = (p_bit == 0) ? carry_o[3]  : c_in;
	
endmodule
