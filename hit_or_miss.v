module hit_or_miss(
	input clk,
	input rst,
	input [7:0] switch,
	input [7:0] LED,
	output [7:0] token, //this token is inputted back into randomizer to generate a random #
	output hit,
	output [7:0] changed_bit_wire
);


reg [7:0] token_value;
reg [7:0] changed_bit;
reg [7:0] switch_mem; //keeps track of previous set of switch
//wire [7:0] switch_mem_wire;
assign changed_bit_wire = changed_bit;

assign hit = (changed_bit == LED);
assign token = token_value; //{token_value[0], token_value[1:0], token_value[1:0], token_value[1:0]};

//keeps track of which switch is flipped
always @(posedge clk or posedge rst) begin
	if(rst) begin
		changed_bit <= 0;
		switch_mem <= 0;
	end
	else if(switch_mem != switch) begin
		changed_bit <= switch_mem ^ switch;
		switch_mem <= switch;
	end
end


//token_value
always @(posedge clk or posedge rst) begin
	if(rst) token_value = 0;
	else if(changed_bit != LED) token_value <= token_value + 1; //token value not the same
	else token_value <= 0;
end


endmodule


