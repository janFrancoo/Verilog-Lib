
module zero_count_task(data, out);

input [7:0] data;
output reg [3:0] out;

always @(data)
	count_0s_in_byte(data, out);

task count_0s_in_byte(input [7:0] data, output reg [3:0] count);
	integer i;
	begin
		count = 0;
		for(i=0; i<=7; i=i+1)
			if (data[i] == 0)
				count = count + 1;
	end
endtask

endmodule