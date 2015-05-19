module randomizer_tb();
	reg clk;
	wire freq;
	reg rst;
	wire [7:0] LED;
	wire enable_f; //disables the frequency module when LED is for 0.5s
	wire [29:0] light_dur;



frequency uut1(.clk(clk), .rst(rst), .freq(freq));
randomizer uut(.clk(clk), .freq(freq), .rst(rst), .LED(LED), .enable_f(enable_f), .light_dur(light_dur));

always begin
	#1 clk = ~clk;

end



initial begin
	clk <= 0;
	#5 rst <= 1;
	#5 rst <= 0;

end

endmodule