
`include "./mult_32.v"

module mult_tb ();
	reg [31:0] A; 
	reg [31:0] B;
	wire [63:0] Result;

	Mult dut(
		A,
		B,
		Result
	);
	 
	initial begin
		$monitor("A=%d, B=%d, Result=%d", A, B, Result);
		// $dumpfile("mult_tb.vcd");
		// $dumpvars(0, mult_tb);
		A = 32'd0;
		B = 32'd0;
		
		#10
		A = 32'd4;
		B = 32'd25;

		#10
		A = 32'd2394324;
		B = 32'd394;

		#10
		A = 32'd3394;
		B = 32'd4925;

	end
endmodule
