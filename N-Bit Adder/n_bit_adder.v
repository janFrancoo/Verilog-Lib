
module adder_n_bit(x, y, c_in, sum, c_out);
	parameter N = 4;

	input c_in;
	input [N-1:0] x, y;

	output c_out;
	output [N-1:0] sum;

	/*genvar i;
	wire [N-2:0] c; // internal wire
	
	generate for (i=0; i<N; i=i+1) begin : adder
		if (i == 0)
			full_adder fa (x[i], y[i], c_in, sum[i], c[i]);
		else if (i == N-1)
			full_adder fa (x[i], y[i], c[i-1], sum[i], c_out);
		else
			full_adder fa (x[i], y[i], c[i-1], sum[i], c[i]);
	end endgenerate*/

	genvar i;
	wire [N-2:0] c;

	for (i=0; i<N; i=i+1) begin
		if (i == 0)
			full_adder fa (x[i], y[i], c_in, sum[i], c[i]);
		else if (i == N-1)
			full_adder fa (x[i], y[i], c[i-1], sum[i], c_out);
		else
			full_adder fa (x[i], y[i], c[i-1], sum[i], c[i]);
	end

endmodule
