module subColMix
(
	input [31 : 0] iBlockIn,
	output reg [31 : 0] oBlockout
);

wire [7 : 0] wS00 = iBlockIn[31 : 24];
wire [7 : 0] wS10 = iBlockIn[23 : 16];
wire [7 : 0] wS20 = iBlockIn[15 : 8];
wire [7 : 0] wS30 = iBlockIn[7 : 0];

wire [7 : 0] wS00_1 = iBlockIn[31] ? {iBlockIn[30 : 24],1'b0} ^ 8'h1b : {iBlockIn[30 : 24],1'b0};
wire [7 : 0] wS10_1 = iBlockIn[23] ? {iBlockIn[22 : 16],1'b0} ^ 8'h1b : {iBlockIn[22 : 16],1'b0};
wire [7 : 0] wS20_1 = iBlockIn[15] ? {iBlockIn[14 : 8],1'b0} ^ 8'h1b : {iBlockIn[14 : 8],1'b0};
wire [7 : 0] wS30_1 = iBlockIn[7] ? {iBlockIn[6 : 0],1'b0} ^ 8'h1b : {iBlockIn[6 : 0],1'b0};


always @(*)begin
	oBlockout[31 : 24] = wS00_1 ^ (wS10_1 ^ wS10) ^ wS20 ^ wS30;
	oBlockout[23 : 16] = wS00 ^ wS10_1 ^ (wS20_1 ^ wS20) ^ wS30;
	oBlockout[15 : 8] = wS00 ^ wS10 ^ wS20_1 ^ (wS30_1 ^ wS30);
	oBlockout[7 : 0] = (wS00_1 ^ wS00) ^ wS10 ^ wS20 ^ wS30_1;
end

endmodule

