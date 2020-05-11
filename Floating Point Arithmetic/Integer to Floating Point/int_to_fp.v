
module int32_to_floating_point(input [31:0] d, 
								output [31:0] v, p_lost);

	wire sign;
	wire [31:0] f5, f4, f3, f2, f1, f0;
	wire [4:0] sa;
	wire [22:0] fraction;
	wire [7:0] exponent;

	assign sign = d[31];		
	assign f5 = sign ? -d : d;	// if d is negative, convert it
	
	// shifting
	assign sa[4] = ~|f5[31:16];
	assign f4 = sa[4] ? {f5[15:0], 16'b0} : f5;
	
	assign sa[3] = ~|f4[31:24];
	assign f3 = sa[3] ? {f4[23:0], 8'b0} : f4;
	
	assign sa[2] = ~|f3[31:28];
	assign f2 = sa[2] ? {f3[27:0], 4'b0} : f3;
	
	assign sa[1] = ~|f2[31:30];
	assign f1 = sa[1] ? {f2[29:0], 2'b0} : f2;
	
	assign sa[0] = ~|f1[31];
	assign f0 = sa[0] ? {f1[30:0], 1'b0} : f1;
	
	assign p_lost = |f0[7:0];
	assign fraction = f0[30:8];
	assign exponent = 8'h9e - {3'h0 - sa};
	assign v = (d == 0) ? 0 : {sign, exponent, fraction};

endmodule
