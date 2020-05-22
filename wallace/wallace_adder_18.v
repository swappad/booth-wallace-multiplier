`timescale 1ns / 1ps
`include "../full-adder/full-adder.v"

// 18 Input Wallace adder
module Wallace_adder_18 #(parameter WORDLEN=3) (
	input [WORDLEN-1:0] in_1,
	input [WORDLEN-1:0] in_2,
	input [WORDLEN-1:0] in_3,
	input [WORDLEN-1:0] in_4,
	input [WORDLEN-1:0] in_5,
	input [WORDLEN-1:0] in_6,
	input [WORDLEN-1:0] in_7,
	input [WORDLEN-1:0] in_8,
	input [WORDLEN-1:0] in_9,
	input [WORDLEN-1:0] in_10,
	input [WORDLEN-1:0] in_11,
	input [WORDLEN-1:0] in_12,
	input [WORDLEN-1:0] in_13,
	input [WORDLEN-1:0] in_14,
	input [WORDLEN-1:0] in_15,
	input [WORDLEN-1:0] in_16,
	input [WORDLEN-1:0] in_17,
	input [WORDLEN-1:0] in_18,
	output [WORDLEN-1:0] out
);
	reg [WORDLEN-1:0] s_row_11;
	reg [WORDLEN-1:0] s_row_12;
	reg [WORDLEN-1:0] s_row_13;
	reg [WORDLEN-1:0] s_row_14;
	reg [WORDLEN-1:0] s_row_15;
	reg [WORDLEN-1:0] s_row_16;

	reg [WORDLEN-1:0] s_row_21;
	reg [WORDLEN-1:0] s_row_22;
	reg [WORDLEN-1:0] s_row_23;
	reg [WORDLEN-1:0] s_row_24;

	reg [WORDLEN-1:0] s_row_31;
	reg [WORDLEN-1:0] s_row_32;

	reg [WORDLEN-1:0] s_row_41;
	reg [WORDLEN-1:0] s_row_42;

	reg [WORDLEN-1:0] s_row_5;
	reg [WORDLEN-1:0] s_row_6;


	reg [WORDLEN-1:0] c_row_11;
	reg [WORDLEN-1:0] c_row_12;
	reg [WORDLEN-1:0] c_row_13;
	reg [WORDLEN-1:0] c_row_14;
	reg [WORDLEN-1:0] c_row_15;
	reg [WORDLEN-1:0] c_row_16;

	reg [WORDLEN-1:0] c_row_21;
	reg [WORDLEN-1:0] c_row_22;
	reg [WORDLEN-1:0] c_row_23;
	reg [WORDLEN-1:0] c_row_24;

	reg [WORDLEN-1:0] c_row_31;
	reg [WORDLEN-1:0] c_row_32;

	reg [WORDLEN-1:0] c_row_41;
	reg [WORDLEN-1:0] c_row_42;

	reg [WORDLEN-1:0] c_row_5;
	reg [WORDLEN-1:0] c_row_6;

	full_adder FA_Row_11 [WORDLEN-1:0] (in_1, in_2, in_3, s_row_11, c_row_11);
	full_adder FA_Row_12 [WORDLEN-1:0] (in_4, in_5, in_6, s_row_12, c_row_12);
	full_adder FA_Row_13 [WORDLEN-1:0] (in_7, in_8, in_9, s_row_13, c_row_13);
	full_adder FA_Row_14 [WORDLEN-1:0] (in_10, in_11, in_12, s_row_14, c_row_14);
	full_adder FA_Row_15 [WORDLEN-1:0] (in_13, in_14, in_15, s_row_15, c_row_15);
	full_adder FA_Row_16 [WORDLEN-1:0] (in_16, in_17, in_18, s_row_16, c_row_16);


	full_adder FA_Row_21 [WORDLEN-1:0] (s_row_11, {c_row_11[WORDLEN-2:0], 1'b0}, s_row_12, s_row_21, c_row_21);
	full_adder FA_Row_22 [WORDLEN-1:0] ({c_row_12[WORDLEN-2:0], 1'b0}, s_row_13, {c_row_13[WORDLEN-2:0], 1'b0}, s_row_22, c_row_22);
	full_adder FA_Row_23 [WORDLEN-1:0] (s_row_14, {c_row_14[WORDLEN-2:0], 1'b0}, s_row_15, s_row_23, c_row_23);
	full_adder FA_Row_24 [WORDLEN-1:0] ({c_row_15[WORDLEN-2:0], 1'b0}, s_row_16, {c_row_16[WORDLEN-2:0], 1'b0}, s_row_24, c_row_24);

	full_adder FA_Row_31 [WORDLEN-1:0] (s_row_21, {c_row_21[WORDLEN-2:0], 1'b0}, s_row_22, s_row_31, c_row_31);
	full_adder FA_Row_32 [WORDLEN-1:0] ({c_row_22[WORDLEN-2:0], 1'b0}, s_row_23, {c_row_23[WORDLEN-2:0], 1'b0}, s_row_32, c_row_32);

	full_adder FA_Row_41 [WORDLEN-1:0] (s_row_31, {c_row_31[WORDLEN-2:0], 1'b0}, s_row_32, s_row_41, c_row_41);
	full_adder FA_Row_42 [WORDLEN-1:0] ({c_row_32[WORDLEN-2:0], 1'b0}, s_row_24, {c_row_24[WORDLEN-2:0], 1'b0}, s_row_42, c_row_42);

	full_adder FA_Row_5 [WORDLEN-1:0] (s_row_41, {c_row_41[WORDLEN-2:0], 1'b0}, s_row_42, s_row_5, c_row_5);

	full_adder FA_Row_6 [WORDLEN-1:0] (s_row_5, {c_row_5[WORDLEN-2:0], 1'b0}, {c_row_42[WORDLEN-2:0], 1'b0}, s_row_6, c_row_6);

	// CPA
	reg [WORDLEN-1:0] cpa_carry;
	full_adder CPA [WORDLEN-1:0] (s_row_6, {c_row_6[WORDLEN-2:0], 1'b0}, {cpa_carry[WORDLEN-2:0], 1'b0}, out, cpa_carry);

	`ifdef FORMAL 
		assert property((in_1 + in_2 + in_3 + in_4 + in_5 + in_6 + in_7 + in_8 + in_9 + in_10 + in_11 + in_12 + in_13 + in_14 + in_15 + in_16 + in_17 + in_18) == out);
	`endif
endmodule
