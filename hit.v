module hit(
	input clk;
	input freq;
	input [7:0] random;
	input [7:0] switch;
	output hit;
	output miss;
);

reg hit;
reg miss;
reg [7:0] LEDnumber;
reg [31:0] counter;
reg [7:0] changed_bit;
reg [7:0] switch_mem; //keeps track of previous set of switch
assign changed_bit_wire = changed_bit;


//light_duration
  //IDLE STATE 0
//ACTIVE STATE 100000001
always @(posedge clk or posedge rst or posedge freq)
begin
	if(rst) counter <= 0;
	else if(freq) counter <= 1
	else if(counter == 100000000) counter <= 0;
	else if(counter == 0) counter <= 0;
	else if(counter > 0) counter <= counter +1;
end

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

//loads random number
always @(posedge freq or posedge rst) begin
	if(rst) LEDnumber <= 0;
	else if(freq) LEDnumber <= random;
	else LEDnumber <= 0;
end

always @(posedge clk or posedge rst) begin
	if(rst) begin
		hit <= 0;
		miss <= 0;
	end else if(!counter) begin
		hit <= 0;
		miss <= 0;
	end else if((counter > 0) and changed_bit == LEDnumber) begin
		hit <= 1;
		miss <= 0;
	end else if((!counter) and changed_bit != LEDnumber) begin
		hit <= 0;
		miss <= 1;
	end
end
