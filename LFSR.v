module LFSR (
	//input enable,
    input clock,
    input reset,
    output [12:0] rnd,
    output [7:0] LED,
    );

reg [3:0] final;
reg [12:0] random, random_next, random_done;
reg [3:0] count, count_next; //to keep track of the shifts
wire feedback = random[12] ^ random[3] ^ random[2] ^ random[0];

always @ (posedge clock or posedge reset)
begin
 if (reset)
 begin
  random <= 13'hF; //An LFSR cannot have an all 0 state, thus reset to FF
  count <= 0;
 end
  
 else
 begin
  random <= random_next;
  count <= count_next;
 end
end
 
always @ (*)
begin
 random_next = random; //default state stays the same
 count_next = count;
 
  random_next = {random[11:0], feedback}; //shift left the xor'd every posedge clock
  count_next = count + 1;
 
 if (count == 13)
 begin
  count = 0;
  random_done = random; //assign the random number to output after 13 shifts
 end
  
end

always @(posedge clock posedge reset)
begin
	final = random_done[3:0];
end

assign LED =(final == 0) ? 8'b00000001 :
			(final == 1) ? 8'b00000010 :
			(final == 2) ? 8'b00000100 :
			(final == 3) ? 8'b00001000 :
			(final == 4) ? 8'b00010000 :
			(final == 5) ? 8'b00100000 :
			(final == 6) ? 8'b01000000 :
			(final == 7) ? 8'b10000000 : 8'b00000001; 


assign rnd = random_done;//enable ? random_done : 0;
 
endmodule
