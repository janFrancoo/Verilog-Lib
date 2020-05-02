
module car_park_control_tb;
	
	reg clk;
	reg rst;
	reg park_sensor;
	reg entrance_sensor;
	reg exit_sensor;
	reg [4:0] pass;
	wire red_led;
	wire green_led;
	wire lock;

	car_park_control uut (clk, rst, park_sensor, entrance_sensor, exit_sensor, 
							pass, red_led, green_led, lock);
							
	initial begin
			clk = 1'b1; rst = 1'b1; park_sensor = 1'b0; entrance_sensor = 1'b0; 
			exit_sensor = 1'b0;
		#1	rst = 1'b0;
		#5	rst = 1'b1;
		#10 entrance_sensor = 1'b1;
		#5	pass = 5'b00011;
		#5	pass = 5'b10101;
		#5	park_sensor = 1'b1; entrance_sensor = 1'b0;
		#20	exit_sensor = 1'b1;
		#1	exit_sensor = 1'b0;
		#5	park_sensor = 1'b0;
		#10 $stop;
	end
	
	always #1 clk = ~clk;

endmodule
