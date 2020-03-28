
module detect_110101(input clk, rst, in, output out);

	parameter IDLE = 0, S1 = 1, S11 = 2, S110 = 3, S1101 = 4, S11010 = 5, S110101 = 6;
	reg [2:0] current_state = IDLE, next_state = IDLE;

	assign out = current_state == S110101 ? 1 : 0;

	always @(posedge clk) begin
		if (rst)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	always @(current_state or in) begin
		case (current_state)
			IDLE: begin
				if (in)	next_state = S1;
				else next_state = IDLE;
			end

			S1: begin
				if (in) next_state = S11;
				else	next_state = IDLE;
			end

			S11: begin
				if (in) next_state = IDLE;
				else	next_state = S110;
			end

			S110: begin
				if (in)	next_state = S1101;
				else	next_state = IDLE;
			end

			S1101: begin
				if (in)	next_state = IDLE;
				else	next_state = S11010;
			end

			S11010: begin
				if (in)	next_state = S110101;
				else	next_state = IDLE;
			end

			S110101: begin
				if (in)	next_state = S1;
				else	next_state = IDLE;
			end
		endcase
	end

endmodule
