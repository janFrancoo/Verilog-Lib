
module n_bit_alu_tb;

	localparam N = 8;
	reg [2:0] F;
	reg [N-1:0] A;
	reg [N-1:0] B;
	wire zero;
	wire overflow;
	wire [N-1:0] Y;
	integer i;
	
	n_bit_alu #(N) uut (F, A, B, zero, overflow, Y);
	
	initial begin
			A = 8'b01101001; B = 8'b01100001; F = 3'b000;
			for (i=1; i<8; i=i+1)
				#5 F = i;
				
		#5 	A = 8'b00011001; B = 8'b00011100; F = 3'b000;
			for (i=1; i<8; i=i+1)
				#5 F = i;
			
		#5	$stop;
	end

endmodule
