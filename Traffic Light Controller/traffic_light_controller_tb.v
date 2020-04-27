// Not time adjustment for simulation purpose!!!

module traffic_light_controller_tb;

	reg clk;
	reg rst;
	reg sensor_a;
	reg sensor_b;
	wire [1:0] light_a;
	wire [1:0] light_b;
	
	traffic_light_control uut (clk, rst, sensor_a, sensor_b, light_a, light_b);
	
	initial begin
			rst = 1'b0; clk =  1'b1; sensor_a = 1'b1; sensor_b = 1'b1;
		#1	rst = 1'b1;
		#100 $stop;
	end
	
	always #1 clk = ~clk;

endmodule
