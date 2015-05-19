




//TOKEN!!!!!!




module randomizer(
	//input token, //the amount of time it takes the player to flip the switch
	input clk,
	input freq,
	input rst,
	output [7:0] LED,
	output enable_f, //disables the frequency module when LED is for 0.5s
	output [29:0] light_dur

);

	reg enable_freq;
	reg [7:0] LED_num; //8 LEDs on the FPGA
	reg [8:0] generator;
	wire [2:0] index; //0 ~ 7
	reg [29:0] light_duration; //how long the LED will be on (1 sec max) 
	
	assign LED = LED_num;
	assign enable_f = enable_freq;
	assign light_dur = light_duration;
	assign index = {generator[2:0]};

	//index register
	always @(posedge clk or posedge rst) begin
		if(rst) generator <= 0;
		else begin
			generator <= generator + 1;
			generator <= {generator[5:0], generator[8] ^ generator[7] , generator[7] ^ generator[6] , generator[6] ^ generator[5]};
		end
	end

	//LED register
	always @(posedge freq or posedge rst) begin
		if(rst) LED_num <= 0;
		else begin
			LED_num <= 0;
			LED_num[index] <= 1;
		end
	end

	//The LED remains only lit during light_duration
	always @(posedge clk) begin
		if(light_duration == 0'b111111)
			LED_num <= 0;	
	end

	//enable_freq register
	always @(posedge clk or posedge rst) begin
		if(rst) enable_freq <= 1;

		else if(!light_duration) //when LED expires, enable frequency
			enable_freq <= 1;
		else //disable the frequency input when LED is lit
			enable_freq <= 0; 
	end



	//light duration logic
	always @(posedge clk or posedge rst or posedge freq) begin
		if(rst) light_duration <= 0;
		else if(freq) light_duration <= 1; //turn on LED when frequency pulses
		else if(light_duration == 0'b111111) //0'h1DCD6500 
			light_duration <= 0;
		else if(!light_duration) light_duration <= 0;
		else light_duration <= light_duration + 1;
	end

endmodule
