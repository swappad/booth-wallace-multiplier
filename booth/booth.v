module Booth(
	/* from LSB to MSB */
	input [2:0] S,
	input [7:0] A,
	output wire [8:0] Result,
	output wire Sign
);

	reg valency_2;
	reg valency_1;

	assign Sign = S[2];
	assign Result = ({9{S[2]}} ^ (valency_2 ? {A, 1'b0} : (valency_1 ? {1'b0, A} : {9'b0})));

	always@(S) begin
		valency_1 = S[0] ^ S[1];
		valency_2 = (S[1] ~^ S[2]) ~| valency_1;
	end

endmodule
