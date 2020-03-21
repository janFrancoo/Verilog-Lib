
primitive sr_latch(q, s, r);
	input s, r;
	output reg q;
	initial q = 0;

	table
	     // s r : q : q+
		0 0 : 1 : 1;
		0 0 : 0 : 0;
		0 1 : ? : 0;
		1 0 : ? : 1;
		1 1 : ? : 0;
	endtable
endprimitive

module m_sr_latch(q, s, r);
	input s, r;
	output q;
	sr_latch(q, s, r);
endmodule
