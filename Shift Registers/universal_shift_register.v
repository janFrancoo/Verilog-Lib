
module universal_shift_register #(parameter N=4) (input clk, rst, data, s0, s1, [N-1:0]wData,
						output reg [N-1:0] q);

	always @(posedge clk or negedge rst) begin
		if (!rst)	q <= 0;
		else case ({s0, s1})
			2'b00: ;
			2'b01: q <= {data, q[N-1:1]};
			2'b10: q <= {q[N-2:0], data};
			2'b11: q <= wData;
		endcase
	end

endmodule
