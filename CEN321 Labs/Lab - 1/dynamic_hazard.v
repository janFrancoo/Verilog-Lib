module Dynamic_Hazard(w, x, y, z, f);
	input w, x, y, z;
	output f;
	wire a, b, c, d, e;

	nand #5 g1(b, x, w);
	not #5 g2(a, w);
	nand #5 g3(c, a, y);
	nand #5 g4(d, b, c);
	nand #5 g5(e, w, z);
	nand #5 g6(f, d, e);
endmodule
