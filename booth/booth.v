module Booth #(parameter WORDLEN=32) (
	/* from LSB to MSB */
	input [2:0] S,
	input [WORDLEN-1:0] A,
	output wire [WORDLEN:0] Result,
	output wire Sign
);

	reg valency_2;
	reg valency_1;

	assign Sign = S[2];
	assign Result = ({(WORDLEN+1){S[2]}} ^ (valency_2 ? {A, 1'b0} : (valency_1 ? {1'b0, A} : {9'b0})));

	always@(S, A) begin
		valency_1 = S[0] ^ S[1];
		valency_2 = (S[1] ~^ S[2]) ~| valency_1;
	end

endmodule
