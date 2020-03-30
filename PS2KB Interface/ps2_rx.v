
module ps2kb_rx(input clk, rst, ps2d, ps2c, rx_en, output reg rx_done_tick, output [7:0] dout);

	localparam [1:0] idle = 2'b00, dps = 2'b01, load = 2'b10;

	reg [1:0] current_state, next_state;
	reg [3:0] n_reg, n_next;
	reg [10:0] b_reg, b_next;
	reg [3:0] filter_reg;
	wire [3:0] filter_next;
	reg f_ps2c_reg;
	wire f_ps2c_next;
	wire fall_edge;

	always @(posedge clk, posedge rst)
		if (rst) begin
			filter_reg <= 0;
			f_ps2c_reg <= 0;
		end else begin
			filter_reg <= filter_next;
			f_ps2c_reg <= f_ps2c_next;
		end

	assign filter_next = {ps2c, filter_reg[3:1]};
	assign f_ps2c_next = (filter_reg == 4'b1111) ? 1'b1 : (filter_reg == 4'b0000) ? 1'b0 : f_ps2c_reg;
	assign fall_edge = f_ps2c_reg & ~f_ps2c_next;

	always @(posedge clk, posedge rst)
		if (rst) begin
			current_state <= idle;
			n_reg <= 0;
			b_reg <= 0;
		end else begin
			current_state <= next_state;
			n_reg <= n_next;
			b_reg <= b_next;
		end
	
	always @* begin
		next_state = current_state;
		rx_done_tick = 1'b0;
		n_next = n_reg;
		b_next = b_reg;
		
		case (current_state)
			idle:
				if (fall_edge & rx_en) begin
					b_next = {ps2d, b_reg[10:1]};
					n_next = 4'b1001;
					next_state = dps;
				end
			dps:
				if (fall_edge) begin
					b_next = {ps2d, b_reg[10:1]};
					if (n_reg == 0)
						next_state = load;
					else
						n_next = n_reg - 1;
				end
			load:
				begin
					next_state = idle;
					rx_done_tick = 1'b1;
				end
		endcase
	end

	initial begin
		forever #5 $display("[%0t] curent_state=%b - next_state=%b - n_reg=%b - n_next=%b - b_reg=%b - b_next=%b - filter_reg=%b", 
			$time, current_state, next_state, n_reg, n_next, b_reg, b_next, filter_reg);
	end
	
	assign dout = b_reg[8:1];

endmodule
