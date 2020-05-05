
module debounce_tb;

	reg btn;
	reg clk;
	wire btn_out;
	wire single_pulse_out;
	
	debounce uut (btn, clk, btn_out, single_pulse_out);
	
	initial begin
			clk = 1; btn = 0;
		#1	btn = 1;
		#1 	btn = 0;
		#1 	btn = 1;
		#1 	btn = 0;
		#1 	btn = 1;
		#10 btn = 0;
		#1  btn = 1;
		#1  btn = 0;
		#1  btn = 1;
		#1  btn = 0;
		#1  btn = 1;
		#1  btn = 0;
		#50 $stop;
	end

	always #1 clk = ~clk;

endmodule
