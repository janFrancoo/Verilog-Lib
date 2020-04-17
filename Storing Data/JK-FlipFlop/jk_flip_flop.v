
module pos_edge_detect (input clk,
			output q);

	wire clk_not;

	not #1 (clk_not, clk);
	and    (q, clk, clk_not);

	/*
		SAME EFFECT CAN BE ACHIVED BY USING
		A CAPACITOR AND A RESISTOR
	*/

endmodule

/*
SR FlipFlop
-------
R S Clk Q Q_

0 0 pos Last State
0 1 pos 1 0
1 0 pos 0 1 
1 1 pos ? ? --- Undefined State!!!
X X  X  Last State 

JK FlipFlop
-----------
J K Clk Q Q_

0 0 pos Last State
0 1 pos 0 1
1 0 pos 1 0 
1 1 pos TOGGLE !!!
X X  X  Last State 
*/

module jk_flip_flop (input clk, J, K,
			output Q, Q_);

	wire pos_edge_clk, s, r;
	pos_edge_detect pos_edge_det (clk, pos_edge_clk);

	and (s, pos_edge_clk, J, Q_);
	and (r, pos_edge_clk, K, Q);

	nor(Q, s, Q_);
	not(Q_, r, Q);

endmodule
