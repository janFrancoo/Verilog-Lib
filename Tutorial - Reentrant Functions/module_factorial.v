
module factorial(n, result);

	input [7:0] n;
	output  reg [15:0] result;

	always @(n)
		result = fact(n);

	function automatic [15:0] fact;
		input [7:0] N;
		if (N == 1) fact = 1;
		else fact = N * fact(N - 1);
	endfunction

endmodule
