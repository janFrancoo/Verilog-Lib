
module clock_divider #(parameter DIV) (input clk, 
					output clk_out);

	reg [15:0] cnt = 16'b0;
	
	always @ (posedge clk) begin
		cnt <= cnt + 1;
		if (cnt >= (DIV - 1))
			cnt <= 16'b0;
	end
	
	assign clk_out = (cnt < (DIV / 2)) ? 1'b0 : 1'b1;

endmodule


module clock_divider_tb;

	localparam DIV = 4;
	reg clk;
	wire clk_out;

	clock_divider #(DIV) uut (clk, clk_out);
	
	initial begin
		clk = 1'b1;
		#200 $stop;
	end
	
	always #2 clk = ~clk;
										
endmodule
