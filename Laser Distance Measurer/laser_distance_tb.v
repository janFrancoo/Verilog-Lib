
module laser_distance_measurer_tb;

	reg clk;
	reg btn;
	reg rst;
	reg laser_reflect;
	wire [15:0] data;
	wire act_laser;
	
	laser_distance_measurer uut (clk, btn, rst, laser_reflect, data, act_laser);
	
	initial begin
				clk = 1'b1; btn = 1'b0; rst = 1'b1; laser_reflect = 1'b0;
		#10		btn = 1'b1;
		#2		btn = 1'b0;
		#50		laser_reflect = 1'b1;
		#2		laser_reflect = 1'b0;
		#5		$stop;
	end
	
	always #1 clk = ~clk;

endmodule
