module Dynamic_Hazard_Test;
	// Inputs
	reg w;
	reg x;
	reg y;
	reg z;
	// Outputs
	wire f;
	// Instantiate the Unit Under Test (UUT)
	Dynamic_Hazard uut (
		.w(w),
		.x(x),
		.y(y),
		.z(z),
		.f(f)
	);
	initial begin
		// Initialize Inputs
			w = 1'b0; x = 1'b0; y = 1'b0; z = 1'b0;
		#5 	x = 1'b1; y = 1'b1; z = 1'b1;
		#30 	w = 1'b1;
		#20 	w = 1'b0;
	end
endmodule
