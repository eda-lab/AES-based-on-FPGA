///////////////////////////////////////////////////////////////////////////////////////
// 密钥扩展模块
// 每次处理128bit密钥
// 以计算w4到w7为例，先计算w4，再计算w5，w6，w7
///////////////////////////////////////////////////////////////////////////////////////
module keyExp
(
	input clk,
	input rst_n,
	input [31 : 0] Rcon,//当前级的Rcon
	input [127 : 0] iBlockIn,
	output [127 : 0] oKeyValue,//轮密钥
	output [127 : 0] oBlockout
);

	
reg [127 : 0] keyTemp_0;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)
		keyTemp_0 <=0 ;
	else
		keyTemp_0 <= iBlockIn;
end

//以计算w4为例，先取w3，对其进行字节移位和字节替换操作
wire [31 : 0] wSubCol;
rom_2p	rom_2p_inst0 (
	.address_a ( iBlockIn [23	:	16] ),
	.address_b ( iBlockIn [15	:	8] ),
	.clock ( clk ),
	.q_a ( wSubCol [31	:	24] ),
	.q_b ( wSubCol [23	:	16] )
	);
rom_2p	rom_2p_inst1 (
	.address_a ( iBlockIn [7	:	0] ),
	.address_b ( iBlockIn [31	:	24] ),
	.clock ( clk ),
	.q_a ( wSubCol [15	:	8] ),
	.q_b ( wSubCol [7	:	0] )
	);
	
reg [31 : 0] colTemp_1;
reg [127 : 0] keyTemp_1;
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		keyTemp_1 <= 0;
	end
	else begin
		colTemp_1 = wSubCol ^ Rcon ^ keyTemp_0[127 : 96];//利用对w3处理的中间结果计算w4
		keyTemp_1 = {keyTemp_0[95 : 0], colTemp_1};
	end
end

//计算w5,w6,w7
reg [127 : 0] keyTemp_2;
always @(*)begin : W_1_2_3	
	reg [31 : 0] colTemp_2;
	integer i;
	
	keyTemp_2 = keyTemp_1;
	for(i = 0; i < 3; i = i + 1)begin
		colTemp_2 = keyTemp_2[127 : 96] ^ keyTemp_2[31 : 0];
		keyTemp_2 = {keyTemp_2[95 : 0], colTemp_2};
	end
end

assign oBlockout = keyTemp_2;
assign oKeyValue = keyTemp_2;

endmodule

