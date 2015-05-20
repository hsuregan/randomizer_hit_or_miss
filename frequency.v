module frequency(
	input clk,
	input rst,
	output reg freq
);

	reg [10:0] freq_reg;

	always @(posedge clk or posedge rst) begin
		if(rst) freq_reg <= 0;
		else if(freq_reg < 1334)	begin
			freq_reg <= freq_reg + 1;
			freq <= 0;
		end
		else if(freq_reg == 1334) begin
			freq_reg <= 0;
			freq <= 1;
		end
	end
endmodule