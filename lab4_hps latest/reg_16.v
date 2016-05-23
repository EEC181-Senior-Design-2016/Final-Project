module reg_16(clock, reset, a, b);
	input clock;
	input reset;
	input [15:0] a;
	output [15:0] b;
	
	wire clock;
	wire reset;
	wire [15:0] a;
	reg [15:0] b;
	
	always @(posedge clock)
		if (reset == 1'b1) begin
			b <= 15'b0;
		end else begin
			b <= a;
		end
endmodule
