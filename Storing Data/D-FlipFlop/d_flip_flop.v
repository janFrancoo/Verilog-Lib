
module pos_edge_detect (input clk, 
			output q);

	wire clk_not;
	not #1 (clk_not, clk);
	and (q, clk, clk_not);

	/*
		THIS EFFECT CAN ALSO BE ACHIEVED BY A
		CAPACITOR AND A RESISTOR
	*/

endmodule

module d_flip_flop (input d, clk,
			output q, q_);

	wire pos_edge, d_not, s, r;
	pos_edge_detect edge_trigger (clk, pos_edge);
	
	not (d_not, d);
	and (r, pos_edge, d_not);
	and (s, pos_edge, d);

	nor (q, r, q_);
	nor (q_, s, q);

endmodule
