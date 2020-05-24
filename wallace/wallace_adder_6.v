`timescale 1ns / 1ps
`include "../full-adder/full-adder.v"

module Wallace_adder #(parameter WORDLEN=8) (
	input [WORDLEN-1:0] in_1,
	input [WORDLEN-1:0] in_2,
	input [WORDLEN-1:0] in_3,
	input [WORDLEN-1:0] in_4,
	input [WORDLEN-1:0] in_5,
	input [WORDLEN-1:0] in_6,
	output [WORDLEN-1:0] out
);
	reg [WORDLEN-1:0] s_row_11;
	reg [WORDLEN-1:0] s_row_12;
	reg [WORDLEN-1:0] s_row_2;
	reg [WORDLEN-1:0] s_row_3;

	reg [WORDLEN-1:0] c_row_11;
	reg [WORDLEN-1:0] c_row_12;
	reg [WORDLEN-1:0] c_row_2;
	reg [WORDLEN-1:0] c_row_3;

	full_adder FA_Row_11 [WORDLEN-1:0] (in_1, in_2, in_3, s_row_11, c_row_11);
	full_adder FA_Row_12 [WORDLEN-1:0] (in_4, in_5, in_6, s_row_12, c_row_12);

	full_adder FA_Row_21 [WORDLEN-1:0] (s_row_11, s_row_12, {c_row_11[WORDLEN-2:0], 1'b0}, s_row_2, c_row_2);
	full_adder FA_Row_31 [WORDLEN-1:0] (s_row_2, {c_row_2[WORDLEN-2:0], 1'b0}, {c_row_12[WORDLEN-2:0], 1'b0}, s_row_3, c_row_3);

	// CPA
	reg [WORDLEN-1:0] cpa_carry;
	full_adder CPA [WORDLEN-1:0] (s_row_3, {c_row_3[WORDLEN-2:0], 1'b0}, {cpa_carry[WORDLEN-2:0], 1'b0}, out, cpa_carry);
/*
	`ifdef FORMAL 
		assert property((in_1 + in_2 + in_3 + in_4 + in_5 + in_6) == out);
	`endif
	*/
endmodule
