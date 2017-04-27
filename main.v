module vr(input CLK, input[1:0] BTN, inout [48:1] pio);
reg[26:0] cnt;
always @ (posedge CLK)
begin
if(BTN[0] | BTN[1])
cnt <= cnt+27'b1;
else
cnt <= cnt-27'b1;
end
wire  [3:0] num  = cnt[26:23];

reg [6:0] abcdefg;
always@*
	
	case(num)
	4'h0: abcdefg = 7'b1111110;
	4'h1: abcdefg = 7'b0110000;
	4'h2: abcdefg = 7'b1101101;
	4'h3: abcdefg = 7'b1111001;
	4'h4: abcdefg = 7'b0110011;
	4'h5: abcdefg = 7'b1011011;
	4'h6: abcdefg = 7'b1011111;
	4'h7: abcdefg = 7'b1110000;
	4'h8: abcdefg = 7'b1111111;
	4'h9: abcdefg = 7'b1111011;
	4'ha: abcdefg = 7'b1110111;
	4'hb: abcdefg = 7'b0011111; 
	4'hc: abcdefg = 7'b1001110;
	4'hd: abcdefg = 7'b0111101;
	4'he: abcdefg = 7'b1001111;
	4'hf: abcdefg = 7'b1000111;
	        
	        
		assign pio[7:1] = abcdefg;
	
endmodule





