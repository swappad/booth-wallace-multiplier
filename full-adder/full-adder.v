`timescale 1ns / 1ps

module full_adder(
	input in_a, 
	input in_b, 
	input in_carry, 
	output out, 
	output out_carry
);

	reg s_prime;
	reg carry_1, carry_2;

	always@(in_a, in_b, in_carry) begin
		s_prime = in_a ^ in_b;
		carry_2 = in_a & in_b;
		carry_1 = in_carry & s_prime;
	end

	assign out_carry = carry_1 | carry_2;
	assign out = in_carry ^ s_prime;

/*	`ifdef FORMAL
		assert property ({1'b0, in_a} + {1'b0, in_b} + {1'b0, in_carry} == {out_carry, out});
	`endif
	*/

endmodule
