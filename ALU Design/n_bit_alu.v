
module n_bit_alu #(parameter N) (input [2:0] F, [N-1:0] A, [N-1:0] B,
								output zero, overflow, [N-1:0] Y);
								
	reg [N-1:0] res;
	
	wire [N:0] a_plus_b;
	wire [N-1:0] a_minus_b;
	assign a_plus_b = {1'b0, A} + {1'b0, B};
	assign a_minus_b = A - B;
	
	always @ (*) begin
		case (F)
			3'b000:
				res = A & B;
			3'b001:
				res = A | B;
			3'b010:
				res = a_plus_b[N-1:0];
			3'b100:
				res = A & ~B;
			3'b101:
				res = A | ~B;
			3'b110:
				res = a_minus_b;
			3'b111:
				res = {N{a_minus_b[N-1]}};
			default:
				res = res;
		endcase
	end
		
	assign Y = res;
	assign zero = (Y == 0) ? 1'b1 : 1'b0;
	assign overflow = a_plus_b[N];

endmodule
