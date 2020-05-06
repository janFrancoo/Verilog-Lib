
module fifo_mem_tb;

	localparam DATA_WIDTH = 8;
	localparam ADDR_SIZE = 16;
	
	reg clk;
	reg rst;
	reg write_en;
	reg [$clog2(ADDR_SIZE)-1:0] read_addr;
	reg [DATA_WIDTH-1:0] data_in;
	
	wire full;
	wire [DATA_WIDTH-1:0] data_out;
	
	integer i;
	
	fifo_mem #(DATA_WIDTH, ADDR_SIZE) uut (clk, rst, write_en, read_addr, data_in, full, data_out);
	
	initial begin
			clk = 1'b1; rst = 1'b1; read_addr = 4'b0000; write_en = 1'b0; data_in = 8'b10101010;
		
		#1	rst = 1'b0;
		#1	rst = 1'b1;
		#1	write_en = 1'b1;
		
		for (i=0; i<16; i=i+1)
			#2	data_in = $random;
		
		#1 	write_en = 0;
		#2	data_in = $random;
		#2	data_in = $random;
		#2	data_in = $random;
		#2	data_in = $random;
		
		for (i=0; i<16; i=i+1)
			#2	read_addr = i;
		
		#10 $stop;
	end
	
	always #1 clk = ~clk;

endmodule
