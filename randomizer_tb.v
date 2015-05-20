module randomizer_tb();
	reg clk;
	wire freq;
	reg rst;
	wire [7:0] LED;
	wire enable_f; //disables the frequency module when LED is for 0.5s
	wire [29:0] light_dur;
	reg [7:0] switch;
	wire [7:0] token_wire;
	wire hit;
	wire [7:0] changed_bit_wire;


/*
module hit_or_miss(
	input clk,
	input rst,
	input [7:0] switch,
	input [7:0] light,
	output [7:0] token, //this token is inputted back into randomizer to generate a random #
	output hit
);


module randomizer(
	input [7:0] token, //the amount of time it takes the player to flip the switch
	input clk,
	input freq,
	input rst,
	output [7:0] LED,
	output enable_f, //disables the frequency module when LED is for 0.5s
	output [29:0] light_dur

);

*/

hit_or_miss uut2(.changed_bit_wire(changed_bit_wire), .clk(clk), .rst(rst), .switch(switch), .LED(LED), .token(token_wire), .hit(hit));
frequency uut1(.clk(clk), .rst(rst), .freq(freq), .enable(enable_f));
randomizer uut(.clk(clk), .rst(rst), .freq(freq), .LED(LED), .enable_f(enable_f), .light_dur(light_dur), .token(token_wire));

always begin
	#1 clk = ~clk;

end



initial begin
	clk <= 0;
	switch <= 0;
	#5 rst <= 1;
	#5 rst <= 0;
	#50 switch = 8'b10000000;
	#10 switch = 8'b10000010;
	#200 switch = 8'b10000011;
end

endmodule