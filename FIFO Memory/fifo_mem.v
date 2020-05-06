
module fifo_mem #(parameter DATA_WIDTH, ADDR_SIZE) (input clk, rst, write_en, 
														[$clog2(ADDR_SIZE)-1:0] read_addr, [DATA_WIDTH-1:0] data_in,
														output reg full, output [DATA_WIDTH-1:0] data_out);
										
	reg [DATA_WIDTH-1:0] arr [ADDR_SIZE-1:0];
	reg [$clog2(ADDR_SIZE)-1:0] write_addr = 0;
	reg round = 1'b0;
	
	always @ (posedge clk or negedge rst) begin
		if (!rst)
			write_addr = 0;
		else if (write_en) begin
			arr[write_addr] = data_in;
			write_addr = write_addr + 1;
			
			if (write_addr == ADDR_SIZE - 1) begin
				write_addr = 0;
				full = 1'b1;
				round = 1'b1;
			end else
				full = 1'b0;
		end
	end
	
	assign data_out = (read_addr < write_addr || round) ? arr[read_addr] : 0;
	
	initial forever #1 $display("%t %b %b %b %b %b %b", $time, write_en, write_addr, read_addr, data_in, data_out, full);

		
endmodule
