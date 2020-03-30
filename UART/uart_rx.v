
module uart_rx #(parameter DBIT = 8, SB_TICK = 16)(input clk, rst, rx, s_tick, output reg rx_done_tick, output [7:0] dout);

	localparam [1:0] idle = 2'b00, start = 2'b01, data = 2'b10, stop = 2'b11;

	reg [1:0] current_state, next_state;
	reg [3:0] s_reg, s_next;
	reg [2:0] n_reg, n_next;
	reg [7:0] b_reg, b_next;

	always @(posedge clk, posedge rst)
		if (rst) begin
			current_state <= idle;
			s_reg <= 0;
			n_reg <= 0;
			b_reg <= 0;
		end else begin
			current_state <= next_state;
			s_reg <= s_next;
			n_reg <= n_next;
			b_reg <= b_next;
		end

	always @* begin
		rx_done_tick = 1'b0;
		next_state = current_state;
		s_next = s_reg;
		n_next = n_reg;
		b_next = b_reg;
		case (current_state)
			idle:
				if (~rx) begin
					next_state = start;
					s_next = 0;
				end
			start:
				if (s_tick)
					if (s_reg == 7) begin
						next_state = data;
						s_next = 0;
						n_next = 0;
					end 
					else	s_next = s_reg + 1;
			data:
				if (s_tick) 
					if (s_reg == 15) begin
						s_next = 0;
						b_next = {rx, b_reg[7:1]};
						if (n_reg == (DBIT-1))
							next_state = stop;
						else
							n_next = n_reg + 1;
					end else	s_reg = s_reg + 1;
			stop:
				if (s_tick)
					if (s_reg == (SB_TICK)) begin
						next_state = idle;
						rx_done_tick = 1'b1;
					end
					else	s_next = s_reg + 1;
		endcase
	end

	assign dout = b_reg;

endmodule
