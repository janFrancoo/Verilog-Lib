
module delay_timer(input clk, reset, trigger, [1:0] mode, [7:0] weight,
					output reg out);

	localparam ONE_SHOT = 2'b00, DELAYED_OPERATE = 2'b01, DELAYED_RELEASE = 2'b10, DUAL_DELAY = 2'b11;
	
	reg cnt_active;
	reg [7:0] count;
	reg posedge_trigger, negedge_trigger, prev_trigger;
	reg [2:0] hold_trigger;

	initial begin
		hold_trigger = 3'b000;
		out = 1'b1;
	end

	always @ (posedge clk or posedge cnt_active or negedge reset) begin
		if (!reset) begin
			out = 1'b1;
			negedge_trigger = 1'b0;
			posedge_trigger = 1'b0;
			prev_trigger = 1'b0;
			cnt_active = 1'b0;
			count = 8'b0;
			hold_trigger = 3'b0;
		end
		
		if (cnt_active == 1'b1)
			count = count + 1'b1;
		else
			count = 8'b0;
			
		posedge_trigger = 1'b0;
		negedge_trigger = 1'b0;
		hold_trigger = {hold_trigger[1:0], trigger};
		
		if (~|hold_trigger) begin
			if (prev_trigger == 1'b1)
				negedge_trigger = 1'b1;
			prev_trigger = 1'b0;
		end else if (&hold_trigger) begin
			if (prev_trigger == 1'b0)
				posedge_trigger = 1'b1;
			prev_trigger = 1'b1;
		end
	end
	
	always @ (posedge_trigger or negedge_trigger or count) begin
		case (mode)
			ONE_SHOT:
				begin
					if (posedge_trigger) begin
						cnt_active = 1'b1;
						out = 1'b0;
						count = 8'b0;
					end
					if (count == weight) begin
						cnt_active = 1'b0;
						count = 8'b0;
						out = 1'b1;
					end
				end
			DELAYED_OPERATE:
				begin
					if (posedge_trigger) begin
						cnt_active = 1'b1;
						out = 1'b1;
						count = 8'b0;
					end
					if (count == weight) begin
						cnt_active = 1'b0;
						count = 8'b0;
						out = 1'b0;
					end
					if (negedge_trigger) begin
						cnt_active = 1'b0;
						out = 1'b1;
						count = 8'b0;
					end
				end
			DELAYED_RELEASE:
				begin
					if (posedge_trigger) begin
						out = 1'b0;
						count = 8'b0;
						cnt_active = 1'b0;
					end
					if (negedge_trigger) begin
						count = 8'b0;
						cnt_active = 1'b1;
						out = 1'b0;
					end
					if (count == weight) begin
						cnt_active = 1'b0;
						count = 8'b0;
						out = 1'b1;
					end
				end
			DUAL_DELAY:
				begin
					if (posedge_trigger) begin
						out = 1'b1;
						count = 8'b0;
						cnt_active = 1'b1;
					end
					if (negedge_trigger) begin
						count = 8'b0;
						cnt_active = 1'b1;
						out = 1'b0;
					end
					if (count == weight) begin
						cnt_active = 1'b0;	
						count = 8'b0;
						if (out)
							out = 1'b0;
						else if (!out)
							out = 1'b1;
					end
				end
		endcase
	end
	
	initial forever #1 $display("%t %b %b", $time, posedge_trigger, negedge_trigger);

endmodule
