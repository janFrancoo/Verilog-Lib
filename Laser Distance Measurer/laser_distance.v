
module laser_distance_measurer(input clk, btn, rst, laser_reflect,
								output [15:0] data, output reg act_laser);

	localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
	reg [2:0] curr_state, next_state;
	reg [15:0] distance;
	reg [16:0] counter;
	
	initial curr_state = 3'b000;
	
	always @ (posedge clk or negedge rst) begin
		if (!rst)
			curr_state <= S0;
		else
			curr_state <= next_state;
	end
	
	always @ (*) begin
		case (curr_state) 
			S0: 
				next_state <= S1;
			S1:
				if (btn) next_state <= S2;
				else	next_state <= S1;
			S2:
				next_state <= S3;
			S3:
				if (laser_reflect) next_state <= S4;
				else	next_state <= S3;
			S4:
				next_state <= S1;
		endcase
	end
	
	always @ (posedge clk) begin
		case (curr_state) 
			S0:
				begin
					act_laser = 1'b0;
					distance = 16'b0;
				end
			S1:
				counter = 17'b0;
			S2:
				act_laser = 1'b1;
			S3:
				begin
					act_laser = 1'b0;
					counter = counter + 1'b1;
				end
			S4:
				distance = counter[15:0];
		endcase
	end
	
	assign data = distance;
	
	initial forever #1 $display("%t %b %b %b", $time, curr_state, next_state, counter);
	
endmodule
