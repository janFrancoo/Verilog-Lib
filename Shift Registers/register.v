
module n_bit_register #(parameter N=1)(input clk, [N-1:0] d,
					output reg [N-1:0] q);

	always @(posedge clk)
		q <= d;

endmodule

module n_bit_register_with_async_rst #(parameter N=1)(input clk, rst, [N-1:0] d,
							output reg [N-1:0] q);
	
	always @(posedge clk or negedge rst) begin
		if (!rst) 	q <= 0;
		else		q <= d;	
	end

endmodule

module n_bit_register_with_async_rst_sync_load #(parameter N=1)(input clk, rst, load, [N-1:0] d,
							output reg [N-1:0] q);
	
	always @(posedge clk or negedge rst) begin
		if (!rst) 	q <= 0;
		if (load)	q <= d;	
	end

endmodule
