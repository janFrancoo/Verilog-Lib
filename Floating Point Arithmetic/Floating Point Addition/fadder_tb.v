
module floating_point_adder_tb;

    reg [31:0] a;
	reg [31:0] b;
    reg sub;
    reg [1:0] round_mode;
    wire [31:0] s;

    floating_point_adder uut (sub, a, b, round_mode, s);    

    initial begin
            round_mode  = 0;
            sub = 1;
            a   = 32'h3c600011;
            b   = 32'hbe820000;
        #10 round_mode  = 2'h1;
        #10 round_mode  = 2'h2;
        #10 round_mode  = 2'h3;
        #10 round_mode  = 2'h0;
            sub = 0;
        #10 round_mode  = 2'h1;
        #10 round_mode  = 2'h2;
        #10 round_mode  = 2'h3;
        #10 round_mode  = 2'h0;
            sub = 1;
            a   = 32'h3fffffff;
            b   = 32'hb3800000;
        #10 round_mode  = 2'h1;
        #10 round_mode  = 2'h2;
        #10 round_mode  = 2'h3;
        #10 round_mode  = 2'h0;
            sub = 0;
        #10 round_mode  = 2'h1;
        #10 round_mode  = 2'h2;
        #10 round_mode  = 2'h3;
        #10 round_mode  = 2'h0;
            a   = 32'h7f800000;
            b   = 32'h7f800000;
        #10 sub = 1;
        #10 sub = 0;
            a   = 32'h7f00ffff;
            b   = 32'h7fe0000f;
        #10 sub = 0;
            a   = 32'h7f7fffff;
            b   = 32'h7f7fffff;
        #10 sub = 0;
            a   = 32'h7f00ffff;
            b   = 32'h00000000;
        #10 sub = 0;
            a   = 32'h00800000;
            b   = 32'h007fffff;
        #10 sub = 0;
            a   = 32'h00000007;
            b   = 32'h00000008;
        #10 sub = 1;
    end
endmodule
