module hit_or_miss(
	input clk,
	input rst,
	input enable,
	input [7:0] switch,
	input [7:0] light,
	output [8:0] token, //this token is inputted back into randomizer to generate a random #
	output hit
);

reg hit_reg;
reg switched_bit;
reg [8:0] token_value;
reg allow;


always @ (posedge clk or posedge rst) begin
	if(rst) allow <= 1;
	else if(enable) hit_reg <= 1;
end



always @(posedge clk or posedge rst) begin
	if(rst) switched_bit <= 0;
	else if(!enable && allow) switched_bit <= switched_bit ^ switch; //when enable is low, the switched_bit can be
end



always @ (posedge clk or posedge rst) begin
	if(rst) hit_reg <= 0;
	else if(switched_bit == light) hit_reg <= 1;
end


