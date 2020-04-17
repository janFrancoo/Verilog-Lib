
/*
	THIS IS JUST A MODELLING AND DOES NOT WORK PROPERLY!
	Note to myself: DO NOT TRY IT ON BREADBOARD (BBs can not handle racing conditions)
*/


module jk_flip_flop_tb;

	reg clk;
	reg J;
	reg K;
	wire Q;
	wire Q_;

	jk_flip_flop uut (clk, J, K, Q, Q_);

	initial begin
			J = 1; K = 0; clk = 0;

			/*
				INITIALLY THE CIRCUIT WILL BEGUN
				IN LOW MODE IN THE REAL WORLD
			*/
			force Q = 1'b1;
		#1	release Q;

		#5	J = 0; K = 1;
		#5	J = 0; K = 0;
		#5	J = 1; K = 1;
		#5	$stop;
	end

	always #3 clk = ~clk;

endmodule
