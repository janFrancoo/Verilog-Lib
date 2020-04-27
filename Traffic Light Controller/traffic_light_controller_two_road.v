
module traffic_light_control(input clk, rst, sensor_a, sensor_b,
							output reg [1:0] light_a, light_b);
							
	localparam A_RED_B_GRE = 2'b00, A_RED_B_YEL = 2'b01, 
				A_GRE_B_RED = 2'b10, A_YEL_B_RED = 2'b11;
	localparam GREEN = 2'b00, YELLOW = 2'b01, RED = 2'b10;
	reg time_up;
	reg [29:0] count, limit;
	reg [1:0] curr_state, next_state;
	
	always @ (posedge clk or negedge rst) begin
		if (!rst) begin
		curr_state <= A_RED_B_GRE;
		count <= 0;
		time_up <= 0;
		end else	curr_state <= next_state;
	end
	
	always @ (*) begin
		case (curr_state)
			A_RED_B_GRE:
				begin
					if (time_up && sensor_a) begin
						time_up = 1'b0;
						next_state = A_RED_B_YEL;
					end else
						next_state = A_RED_B_GRE;
				end
			A_RED_B_YEL:
				begin
					if (time_up) begin
						next_state = A_GRE_B_RED;
						time_up = 1'b0;
					end else
						next_state = A_RED_B_YEL;
				end
			A_GRE_B_RED:
				begin
					if (time_up && sensor_b) begin
						next_state = A_YEL_B_RED;
						time_up = 1'b0;
					end else
						next_state = A_GRE_B_RED;
				end
			A_YEL_B_RED:
				begin
					if (time_up) begin
						next_state = A_RED_B_GRE;
						time_up = 1'b0;
					end else
						next_state = A_YEL_B_RED;
				end
		endcase
	end
	
	always @ (posedge clk) begin
		if (count == limit) begin
			time_up = 1'b1;
			count = 0;
		end
		
		if (!time_up)
			count = count + 1'b1;
			
		case (curr_state)
			A_RED_B_GRE:
				begin
					limit = 5;	// 500 000 000
					light_a = RED;
					light_b = GREEN;
				end
			A_RED_B_YEL:
				begin
					limit = 2; // 200 000 000
					light_a = RED;
					light_b = YELLOW;
				end
			A_GRE_B_RED:
				begin
					limit = 5;
					light_a = GREEN;
					light_b = RED;
				end	
			A_YEL_B_RED:
				begin
					limit = 2;
					light_a = YELLOW;
					light_b = RED;
				end
		endcase
	end
	
	initial forever #1 $display("%t %b %b %b %b %b", $time, curr_state, next_state, count, limit, time_up);
			
endmodule
