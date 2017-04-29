module main(input clk,inout [48:1] pio);
reg [15:0]count = 1'b0;
reg [1:0]dynamic_temp = 1'b0;
reg [15:0] chislo = 0; 
reg [6:0]ind=0;
reg [3:0] digit=0;
reg [7:0] toshow=0;
reg [5:0] div = 0;

reg[111:0] bufr;//GrOSSdEUtSCHLAND

reg[111:0] temp = 112'b0111101101000001111111101101110110110111101111001011111011110001101101011100111101000111000111011110101001011110;//GrOSSdEUtSCHLAND

always @ (posedge clk) begin
 
  count <= count + 1'b1;           
  if(count == 0)                  
  begin
    dynamic_temp <= dynamic_temp + 1'b1;//CLOCK DIVIDER
    //chislo<=chislo+1;
    div<=div+1;
    if(div==0)
    begin
    bufr<=bufr<<7;
         if(bufr[111:105]==6'b0)
          begin
          bufr<=temp;
          end 
          end
  end
 
  case(dynamic_temp)//DISPLAY 4 LAST ENTERED CHARS
    2'b00 :  
    begin
    toshow<=bufr[90:84];
     ind<=toshow;
     digit <= 4'b1110;     
    end
 
    2'b01 :  
    begin
      toshow<=bufr[97:91];
        ind<=toshow;
     digit <= 4'b1101;     
    end 
 
    2'b10 :  
    begin
      toshow<=bufr[104:98];
        ind<=toshow;
     digit <= 4'b1011;   
    end
 
    2'b11 : 
    begin
      toshow<=bufr[111:105];
        ind<=toshow;
     digit <= 4'b0111;
     
    end
    
  endcase
 
 
end 
assign pio[7:1] = ind;
assign pio[12:8] = digit; 
 
endmodule









