
module pwm_gen(input clk, increse_duty, decrease_duty,
				output pwm_out);
				
	wire [3:0] slower_clks;
	wire slower_clk;
	wire single_pulse_inc, single_pulse_dec;
		
	reg [3:0] duty = 4, counter = 0;
	
	clk_divider clk_div (clk, slower_clks);
	assign slower_clk = slower_clks[1];
	
	btn_debouncer increase_btn (increse_duty, slower_clk, single_pulse_inc);
	btn_debouncer decrease_btn (decrease_duty, slower_clk, single_pulse_dec);
	
	always @ (posedge single_pulse_inc) begin
		if (duty <= 9)
			duty = duty + 1;
	end
	
	always @ (posedge single_pulse_dec) begin
		if (duty >= 0)
			duty = duty - 1;
	end
	
	always @ (posedge clk) begin
		counter = counter + 1;
		if (counter == 9)
			counter = 0;
	end
	
	assign pwm_out = (counter <= duty) ? 1'b1 : 1'b0;
	
endmodule

module clk_divider(input clk,
					output [3:0] qout);
					
	wire [3:0] conn;

	genvar i;
	generate 
		for (i=0; i<4; i=i+1) begin
			if (!i)
				jk_flip_flop jk_ff (clk, 1'b1, 1'b1, conn[0]);
			else
				jk_flip_flop jk_ff (conn[i-1], 1'b1, 1'b1, conn[i]);
		end
	endgenerate
	
	assign qout[0] = conn[0];
	assign qout[1] = conn[1];
	assign qout[2] = conn[2];
	assign qout[3] = conn[3];
		
endmodule

module btn_debouncer(input push_signal, slow_clk,
						output single_pulse_out);
						
	wire q1, q2;
						
	d_flip_flop dff_1 (slow_clk, push_signal, q1);
	d_flip_flop dff_2 (slow_clk, q1, q2);
	
	assign single_pulse_out = q1 & ~q2;
	
	initial forever #1 $display("%t %b %b", $time, q1, q2);
	
endmodule

module d_flip_flop (input clk, d,
					output reg q);
					
	initial q = 0;
					
	always @ (posedge clk) begin
		q <= d;
	end
	
endmodule

module jk_flip_flop (input clk, j, k,
						output reg q);
						
	initial q = 0;
					
	always @ (posedge clk) begin
		if (j == 1'b1 && k == 1'b0)
			q <= 1'b1;
		else if (j == 1'b0 && k == 1'b1)
			q <= 1'b0;
		else if (j == 1'b1 && k == 1'b1)
			q <= ~q;
	end
	
endmodule
