
module delay_timer_tb;
	
	reg clk;
	reg reset;
	reg trigger;
	reg [1:0] mode;
	reg [7:0] weight;
	wire out;

	delay_timer uut (clk, reset, trigger, mode, weight, out);
	
	initial begin
				clk = 1'b1; reset = 1'b1; trigger = 1'b0; mode = 2'b11; weight = 8'b00000011;
		#6		trigger = 1'b1;
		#24		trigger = 1'b0;
		#30		trigger = 1'b1;
		#6		trigger = 1'b0;
		#6		trigger = 1'b1;
		#24		trigger = 1'b0;
		#40 	$stop;
	end
	
	always #1 clk = ~clk;
					
endmodule
