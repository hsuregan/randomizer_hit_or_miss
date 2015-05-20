module hit_or_miss(
	input clk,
	input rst,
	input [7:0] switch,
	input [7:0] light,
	output [8:0] token, //this token is inputted back into randomizer to generate a random #
	output hit
);

/*
reg hit_reg;
reg allow; //used to allow switched bit
reg [8:0] old_bit;


always @(posedge clk or posedge rst) begin
	if(rst) token_value <= 0;
	else token_value <= token_value + 1;
end

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
*/

reg [8:0] token_value;
reg [7:0] changed_bit;
reg [7:0] switch_mem;
assign hit = (changed_bit == light)

//keeps track of which switch is flipped
always @(posedge clk or posedge rst) begin
	if(rst) begin
		changed_bit <= 0;
		switch_mem <= 0;
	end
	else if(switch_mem != switch) begin
		changed_bit <= switched_mem ^ switch;
		switch_mem <= switch;
	end
end


//token_value
always @(posedge clk or posedge rst) begin
	if(rst) token_value = 0;
	else if(changed_bit != light) token_value <= token_value + 1; //token value not the same
	else token_value <= 0;
end

always @(switch)


