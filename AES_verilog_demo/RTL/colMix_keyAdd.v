module colMix_keyAdd
(
	input clk,
	input rst_n,
	input [127 : 0] iBlockIn,
	input [127 : 0] iKeyValue,//轮密钥
	output [127 : 0] oBlockout
);

wire [127 : 0] wColMixOut;

//列混淆
subColMix subColMix_inst0//列1
(
	.iBlockIn(iBlockIn[127 : 96]),
	.oBlockout(wColMixOut[127 : 96])
 );
 
subColMix subColMix_inst1//列2
(
	.iBlockIn(iBlockIn[95 : 64]),
	.oBlockout(wColMixOut[95 : 64])
 );

subColMix subColMix_inst2//列3
(
	.iBlockIn(iBlockIn[63 : 32]),
	.oBlockout(wColMixOut[63 : 32])
 );
 
subColMix subColMix_inst3//列4
(
	.iBlockIn(iBlockIn[31 : 0]),
	.oBlockout(wColMixOut[31 : 0])
 );

//轮密钥加
assign oBlockout = wColMixOut ^ iKeyValue;//由于字节替换的初始位置有寄存器，
											//所以这里不再加入寄存器

endmodule