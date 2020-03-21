module zero_count_task_test;

	reg [7:0] data;
	wire [3:0] out;

	zero_count_task uut (.data(data), .out(out));
	
	initial begin
			data = 8'b11111111;
		#5	data = 8'b00000000;
		#5	data = 8'b00000001;
		#5	data = 8'b00000011;
		#5	data = 8'b00000111;
		#5	data = 8'b00001111;
		#5	data = 8'b00011111;
		#5	data = 8'b00111111;
		#5	data = 8'b01111111;
		#5	data = 8'b11111111;
		#5	data = 8'b00000000;
	end

	initial #50 $stop;

endmodule
