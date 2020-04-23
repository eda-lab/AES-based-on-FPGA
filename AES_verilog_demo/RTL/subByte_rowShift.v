module subByte_rowShift
(
	input clk,
	input rst_n,
	input [127 : 0] iBlockIn,
	output reg [127 : 0] oBlockout
);

wire [127 : 0] wSubOut, wRotShift;

//字节替换逻辑，用8个双口rom实现
rom_2p	rom_2p_inst0 ( 
	.address_a ( iBlockIn [127	:	120] ),
	.address_b ( iBlockIn [119	:	112] ),
	.clock ( clk ),
	.q_a ( wSubOut [127	:	120] ),
	.q_b ( wSubOut [119	:	112] )
	);
rom_2p	rom_2p_inst1 (
	.address_a ( iBlockIn [111	:	104] ),
	.address_b ( iBlockIn [103	:	96 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [111	:	104] ),
	.q_b ( wSubOut [103	:	96 ] )
	);
rom_2p	rom_2p_inst2 (
	.address_a ( iBlockIn [95	:	88 ] ),
	.address_b ( iBlockIn [87	:	80 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [95	:	88 ] ),
	.q_b ( wSubOut [87	:	80 ] )
	);
rom_2p	rom_2p_inst3 (
	.address_a ( iBlockIn [79	:	72 ] ),
	.address_b ( iBlockIn [71	:	64 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [79	:	72 ] ),
	.q_b ( wSubOut [71	:	64 ] )
	);
rom_2p	rom_2p_inst4 (
	.address_a ( iBlockIn [63	:	56 ] ),
	.address_b ( iBlockIn [55	:	48 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [63	:	56 ] ),
	.q_b ( wSubOut [55	:	48 ] )
	);
rom_2p	rom_2p_inst5 (
	.address_a ( iBlockIn [47	:	40 ] ),
	.address_b ( iBlockIn [39	:	32 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [47	:	40 ] ),
	.q_b ( wSubOut [39	:	32 ] )
	);
rom_2p	rom_2p_inst6 (
	.address_a ( iBlockIn [31	:	24 ] ),
	.address_b ( iBlockIn [23	:	16 ] ),
	.clock ( clk ),
	.q_a ( wSubOut [31	:	24 ] ),
	.q_b ( wSubOut [23	:	16 ] )
	);
rom_2p	rom_2p_inst7 (
	.address_a ( iBlockIn [15	:	8  ] ),
	.address_b ( iBlockIn [7	:	0  ] ),
	.clock ( clk ),
	.q_a ( wSubOut [15	:	8  ] ),
	.q_b ( wSubOut [7	:	0  ] )
	);

//行移位，直接将线路对应连接即可
assign wRotShift = {wSubOut [127 : 120],wSubOut [87 : 80],wSubOut [47 : 40],wSubOut [7 : 0],
wSubOut [95 : 88],wSubOut [55 : 48],wSubOut [15 : 8 ],wSubOut [103 : 96],
wSubOut [63 : 56],wSubOut [23 : 16],wSubOut [111 : 104],wSubOut [71 : 64],
wSubOut [31 : 24],wSubOut [119 : 112],wSubOut [79 : 72],wSubOut [39 : 32]};

//输出寄存器，传递给下一级信号
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		oBlockout <= 0;
	else 
		oBlockout <= wRotShift;
end


endmodule