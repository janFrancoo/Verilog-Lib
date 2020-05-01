
module barrel_shifter #(parameter N) (input [($clog2(N)-1):0] shift, [N-1:0] in, 
									output [N-1:0] out);

	wire [(2*N-1)-1:0]c_input;
	assign c_input = {in[N-1:0], in[N-1:1]};
	
	wire [N-1:0] input_arr [N-1:0];

	genvar i;
	generate
		for (i=0; i<N; i=i+1) begin
			assign input_arr[i] = c_input[((2*N-1)-1)-i:((2*N-1)-1)-i-4];
		end
	endgenerate
	
	assign out = input_arr[shift];
	
	initial forever #1 $display("%t %b %b %b %b %b", $time, in, shift, c_input, input_arr[shift], out);

endmodule
