
module car_park_control(input clk, rst, park_sensor, entrance_sensor, exit_sensor, [4:0] pass,
						output red_led, green_led, lock);
						
	localparam IDLE = 2'b00, WAIT_PASS = 2'b01, RIGHT_PASS = 2'b10, EXIT = 2'b11;
	reg [1:0] curr_state, next_state;
	
	always @ (posedge clk or negedge rst) begin
		if (!rst) curr_state <= IDLE;
		else	curr_state <= next_state;
	end
	
	always @ (*) begin
		case (curr_state)
			IDLE:
				begin
					if (exit_sensor)
						next_state <= EXIT;
					else if (entrance_sensor && !park_sensor)
						next_state <= WAIT_PASS;
					else
						next_state = IDLE;
				end
			WAIT_PASS:
				begin
					if (pass == 5'b10101)
						next_state <= RIGHT_PASS;
					else if (entrance_sensor)
						next_state <= WAIT_PASS;
					else
						next_state <= IDLE;
				end
			RIGHT_PASS:
				begin
					if (park_sensor)
						next_state <= IDLE;
					else
						next_state <= RIGHT_PASS;
				end
			EXIT:
				begin
					if (!park_sensor)
						next_state <= IDLE;
					else
						next_state <= EXIT;
				end				
		endcase
	end
	
	assign red_led = (curr_state != RIGHT_PASS) ? 1'b1 : 1'b0;
	assign green_led = (curr_state == RIGHT_PASS) ? 1'b1 : 1'b0;
	assign lock = ((curr_state == RIGHT_PASS) || (curr_state == EXIT)) ? 1'b0 : 1'b1;
	
	initial forever #1 $display("%t %b %b %b", $time, curr_state, next_state, (curr_state == RIGHT_PASS || curr_state == EXIT));

endmodule
