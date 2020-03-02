module Mux_8_to_1(d, s, o);

	input [7:0]d;
	input [2:0]s;
	output o;

	assign o = (~s[2] & ~s[1] & ~s[0] & d[0]) |
		(~s[2] & ~s[1] &  s[0] & d[1]) |
		(~s[2] &  s[1] & ~s[0] & d[2]) |
		(~s[2] &  s[1] &  s[0] & d[3]) |
		( s[2] & ~s[1] & ~s[0] & d[4]) |
		( s[2] & ~s[1] &  s[0] & d[5]) |
		( s[2] &  s[1] & ~s[0] & d[6]) |
		( s[2] &  s[1] &  s[0] & d[7]);

endmodule 
