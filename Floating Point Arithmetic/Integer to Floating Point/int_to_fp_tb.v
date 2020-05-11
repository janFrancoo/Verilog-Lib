
module int32_to_floating_point_tb;

	reg [31:0] d;
	wire [31:0] v;
	wire p_lost;
	
	int32_to_floating_point uut (d, v, p_lost);
	
	initial begin
			d = 32'b0;
		#5	d = $random;
		#5	d = $random;
		#5	d = $random;
		#5	d = $random;
		#5	d = 32'h1fffffff;
		#5	d = 32'h00000001;
		#5	d = 32'h80000000;
		#5	d = 32'hffffffff;
	end

endmodule
