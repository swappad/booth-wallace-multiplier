`include "../../booth/booth.v"
`include "../../wallace/wallace_adder_18.v"

// parameter WORDLEN should not be changed
module Mult_32 #(parameter WORDLEN=32) (
	input [WORDLEN-1:0] A,
	input [WORDLEN-1:0] B,
	output [2*WORDLEN-1:0] Result
);

	wire  [WORDLEN:0] B_res_1;
	wire  [WORDLEN:0] B_res_2;
	wire  [WORDLEN:0] B_res_3;
	wire  [WORDLEN:0] B_res_4;
	wire  [WORDLEN:0] B_res_5;
	wire  [WORDLEN:0] B_res_6;
	wire  [WORDLEN:0] B_res_7;
	wire  [WORDLEN:0] B_res_8;
	wire  [WORDLEN:0] B_res_9;
	wire  [WORDLEN:0] B_res_10;
	wire  [WORDLEN:0] B_res_11;
	wire  [WORDLEN:0] B_res_12;
	wire  [WORDLEN:0] B_res_13;
	wire  [WORDLEN:0] B_res_14;
	wire  [WORDLEN:0] B_res_15;
	wire  [WORDLEN:0] B_res_16;
	wire  [WORDLEN:0] B_res_17;

	wire  B_carry_1;
	wire  B_carry_2;
	wire  B_carry_3;
	wire  B_carry_4;
	wire  B_carry_5;
	wire  B_carry_6;
	wire  B_carry_7;
	wire  B_carry_8;
	wire  B_carry_9;
	wire  B_carry_10;
	wire  B_carry_11;
	wire  B_carry_12;
	wire  B_carry_13;
	wire  B_carry_14;
	wire  B_carry_15;
	wire  B_carry_16;
	wire  B_carry_17;

	// 32 bit numbers require 16+1 Booths
	Booth B1({A[1:0], 1'b0}, B, B_res_1, B_carry_1);
	Booth B2(A[3:1], B, B_res_2, B_carry_2);
	Booth B3(A[5:3], B, B_res_3, B_carry_3);
	Booth B4(A[7:5], B, B_res_4, B_carry_4);
	Booth B5(A[9:7], B, B_res_5, B_carry_5);
	Booth B6(A[11:9], B, B_res_6, B_carry_6);
	Booth B7(A[13:11], B, B_res_7, B_carry_7);
	Booth B8(A[15:13], B, B_res_8, B_carry_8);
	Booth B9(A[17:15], B, B_res_9, B_carry_9);
	Booth B10(A[19:17], B, B_res_10, B_carry_10);
	Booth B11(A[21:19], B, B_res_11, B_carry_11);
	Booth B12(A[23:21], B, B_res_12, B_carry_12);
	Booth B13(A[25:23], B, B_res_13, B_carry_13);
	Booth B14(A[27:25], B, B_res_14, B_carry_14);
	Booth B15(A[29:27], B, B_res_15, B_carry_15);
	Booth B16(A[31:29], B, B_res_16, B_carry_16);
	Booth B17({2'b0, A[31]}, B, B_res_17, B_carry_17);

	Wallace_adder_18 #(64) wallace_adder (
		// with modified sign extension
		.in_1({{31{B_carry_1}}, B_res_1}),
		.in_2({{29{B_carry_2}}, B_res_2, 1'b0, B_carry_1}),
		.in_3({{27{B_carry_3}}, B_res_3, 1'b0, B_carry_2, 2'b0}),
		.in_4({{25{B_carry_4}}, B_res_4, 1'b0, B_carry_3, 4'b0}),
		.in_5({{23{B_carry_5}}, B_res_5, 1'b0, B_carry_4, 6'b0}),
		.in_6({{21{B_carry_6}}, B_res_6, 1'b0, B_carry_5, 8'b0}),
		.in_7({{19{B_carry_7}}, B_res_7, 1'b0, B_carry_6, 10'b0}),
		.in_8({{17{B_carry_8}}, B_res_8, 1'b0, B_carry_7, 12'b0}),
		.in_9({{15{B_carry_9}}, B_res_9, 1'b0, B_carry_8, 14'b0}),
		.in_10({{13{B_carry_10}}, B_res_10, 1'b0, B_carry_9, 16'b0}),
		.in_11({{11{B_carry_11}}, B_res_11, 1'b0, B_carry_10, 18'b0}),
		.in_12({{9{B_carry_12}}, B_res_12, 1'b0, B_carry_11, 20'b0}),
		.in_13({{7{B_carry_13}}, B_res_13, 1'b0, B_carry_12, 22'b0}),
		.in_14({{5{B_carry_14}}, B_res_14, 1'b0, B_carry_13, 24'b0}),
		.in_15({{3{B_carry_15}}, B_res_15, 1'b0, B_carry_14, 26'b0}),
		.in_16({B_carry_16, B_res_16, 1'b0, B_carry_15, 28'b0}),
		.in_17({B_res_17[31:0], 1'b0, B_carry_16, 30'b0}),
		.in_18({31'b0, B_carry_17, 32'b0}),
		.out(Result)
	);

	`ifdef FORMAL
		assert property(A * B == Result);
	`endif
endmodule

