// Code your testbench here
// or browse Examples
module freq_tb;
  
  reg [2:0] difficulty;
  reg clk;
  reg rst;
  wire [4:0] freq;
  
//  freq uut(.difficulty(0), .clk(clk), .rst(rst), .freq(freq[0]));

  genvar i;
  generate
    for(i=0; i < 4; i=i+1) begin: FREQ
      freq uut (.difficulty(i), 
                .clk(clk), 
                .rst(rst), 
                .freq(freq[i])
               );
    end
  endgenerate
  
  always begin
  	#1 clk = ~clk;
  end
  
  initial begin
	$dumpfile("dump.vcd");
  	$dumpvars(1);
   	clk = 0;
	difficulty = 0;
    rst = 0;
	#1 rst = 1;
    #1 rst = 0;
    
    #500 $finish;
  
  end
  

                                               
      
endmodule