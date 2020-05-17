
module alarm (input clk, /* assuming 50MHz */
					reset, alarm_enable, [3:0] h_msb, h_lsb, m_msb, m_lsb, 
				output disp_h_msb, disp_h_lsb, disp_m_msb, disp_m_lsb, reg alarm_out);

	reg [3:0] h_msb_cnt = 0, h_lsb_cnt = 0, m_msb_cnt = 0, m_lsb_cnt = 0;
	reg [5:0] secs = 0;
	reg [7:0] sec_cnt [2:0];

	wire a_second, slower_clk;

	clk_divider div (clk, slower_clk); // slower_clk <- 6250KHz

	always @ (negedge alarm_enable or negedge reset) begin
		if (!reset) begin
			h_msb_cnt <= 0;
			h_lsb_cnt <= 0;
			m_msb_cnt <= 0;
			m_lsb_cnt <= 0;
			alarm_out <= 0;
		end else if (!alarm_enable) begin
			h_msb_cnt <= h_msb;
			h_lsb_cnt <= h_lsb;
			m_msb_cnt <= m_msb;
			m_lsb_cnt <= m_lsb;
		end	
		
		secs <= 0;
	end
	
	always @ (posedge clk) begin
		if (sec_cnt[0] != 8'b01101000)
			sec_cnt[0] = sec_cnt[0] + 1'b1;
		else if (sec_cnt[1] != 8'b10001001)
			sec_cnt[1] = sec_cnt[1] + 1'b1;
		else if (sec_cnt[2] != 8'b00001001)
			sec_cnt[2] = sec_cnt[2] + 1'b1;
		else begin
			sec_cnt[0] = 0;
			sec_cnt[1] = 0;
			sec_cnt[2] = 0;
		end
	end
	
	assign a_second = (alarm_out == 1'b1) ? 1'b0 : 
						((sec_cnt[0] == 0 && sec_cnt[1] == 0 && sec_cnt[2] == 0) ? 1'b1 : 1'b0);
						
	always @ (posedge a_second) begin
		secs = secs + 1;
		
		if (secs == 6'b111100) begin // a minute passed
			secs = 0;
			m_lsb_cnt = m_lsb_cnt - 1;
		end
		
		if (m_lsb_cnt < 0) begin
			m_lsb_cnt = 4'b1001; // 9
			m_msb_cnt = m_msb_cnt - 1;
		end
		
		if (m_msb_cnt < 0) begin
			m_lsb_cnt = 4'b1001; // 9
			m_msb_cnt = 4'b0101; // 5
			h_lsb_cnt = h_lsb_cnt - 1;
		end
			
		if (h_lsb_cnt < 0) begin
			if (h_msb_cnt == 0)
				alarm_out = 1'b1;
			else begin
				h_lsb_cnt = 4'b1001; // 9
				h_msb_cnt = h_msb_cnt - 1;
			end
		end
		
		if (h_msb_cnt < 0) begin
			if (h_lsb_cnt == 0)
				alarm_out = 1'b1;
			else
				h_msb_cnt = 0;
		end
	end

	function [6:0] seven_segment_display (input [3:0] val);
		case (val)
			1:
				seven_segment_display = 7'b1001111;
			2:
				seven_segment_display = 7'b0010010;
			3:
				seven_segment_display = 7'b0000110;
			4:
				seven_segment_display = 7'b1001100;
			5:
				seven_segment_display = 7'b0100100;
			6:
				seven_segment_display = 7'b0100000;
			7:
				seven_segment_display = 7'b0001111;
			8:
				seven_segment_display = 7'b0000000;
			9:
				seven_segment_display = 7'b0000100;
			default: // 0
				seven_segment_display = 7'b0000001;
		endcase
	endfunction

	assign disp_h_msb = seven_segment_display(h_msb_cnt);
	assign disp_h_lsb = seven_segment_display(h_lsb_cnt);
	assign disp_m_msb = seven_segment_display(m_msb_cnt);
	assign disp_m_lsb = seven_segment_display(m_lsb_cnt);

endmodule

module clk_divider(input clk,
					output slower_clk);
	
	wire [7:0] conn;
	
	genvar i;
	generate
		for (i=0; i<8; i=i+1) begin
			if (i == 0)
				jk_flip_flop jk_ff (clk, 1'b1, 1'b1, conn[0]);
			else
				jk_flip_flop jk_ff (conn[i-1], 1'b1, 1'b1, conn[i]);
		end
	endgenerate
	
	assign slower_clk = conn[7];
	
endmodule

module jk_flip_flop(input clk, j, k,
						output reg q);
						
	initial q = 1'b0;
						
	always @ (posedge clk) begin
		case ({j, k})
			2'b01:
				q <= 1'b0;
			2'b10:
				q <= 1'b1;
			2'b11:
				q <= ~q;
		endcase
	end

endmodule
