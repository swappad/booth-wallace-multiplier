`include "../../booth/booth.v"
`include "../../wallace/wallace_adder_6.v"

// WORDLEN should not be changed
module Mult_8 #(parameter WORDLEN=8) (
	input [WORDLEN-1:0] A,
	input [WORDLEN-1:0] B,
	output [2*WORDLEN-1:0] Result
);

	reg [WORDLEN:0] B_res_1;
	reg [WORDLEN:0] B_res_2;
	reg [WORDLEN:0] B_res_3;
	reg [WORDLEN:0] B_res_4;
	reg [WORDLEN:0] B_res_5;

	reg B_carry_1;
	reg B_carry_2;
	reg B_carry_3;
	reg B_carry_4;
	reg B_carry_5;

	// 8 bit numbers require 4 Booths
	Booth B1({A[1:0], 1'b0}, B, B_res_1, B_carry_1);
	Booth B2(A[3:1], B, B_res_2, B_carry_2);
	Booth B3(A[5:3], B, B_res_3, B_carry_3);
	Booth B4(A[7:5], B, B_res_4, B_carry_4);
	Booth B5({2'b0, A[7]}, B, B_res_5, B_carry_5);

	Wallace_adder #(16) wallace_adder (
		// with modified sign extension
		{{7{B_carry_1}}, B_res_1},
		{{5{B_carry_2}}, B_res_2, 1'b0, B_carry_1},
		{{3{B_carry_3}}, B_res_3, 1'b0, B_carry_2, 2'b0},
		{B_carry_4, B_res_4, 1'b0, B_carry_3, 4'b0},
		{B_res_5[7:0], 1'b0, B_carry_4, 6'b0},
		{7'b0, B_carry_5, 8'b0},
		Result
	);

	`ifdef FORMAL
		assert property(A * B == Result);
	`endif
endmodule

