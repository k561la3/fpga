module frequency_generator
#
(
    parameter clock_frequency          = 12000000,  // 12 MHz
              output_frequency_mul_100 = 26163      // Частота ноты До   первой октавы * 100
)
(
    input      clock,
    input      reset_n,
    output reg out
);

    parameter [31:0] period_in_cycles
        = clock_frequency * 100 / output_frequency_mul_100;

    reg [15:0] counter;

    always @(posedge clock or negedge reset_n)
    begin
        if (! reset_n)
        begin
            counter <= 16'b0;
            out     <= 1'b0;
        end
        else
        begin
            if (counter == period_in_cycles / 2 - 1)
            begin
                out     <= ! out;
                counter <= 16'b0;
            end
            else
            begin
                counter <= counter + 16'b1;
            end
        end
 

endmodule

//----------------------------------------------------------------------------

module top
(
    input  [1:0]  BTN,
    input         CLK,         // Тактовый сигнал 12 MHz
    inout  [48:1] pio          // GPIO, General-Purpose Input/Output
);

    parameter clock_frequency      = 12000000;

    
    wire clock     = CLK;
     reg [19:0] freq;
     freq <= 14'b11111111111111;
     reg [8:0] clkreduce;

     # (
        .clock_frequency          ( clock_frequency      ),
        .output_frequency_mul_100 ( freq )
    )
    (
        .clock   ( clock     ),
        .reset_n ( BTN[0]),
        .out     ( note_c4   )
    );
always @ (posedge clock )
begin
clkreduce <= clkreduce + 9'b1;
end

always @ (posedge clkreduce[8])
begin
if(freq==20'hfffff)
freq <= 14'b11111111111111;
else
freq <= freq+1'b1;
end
 
  

    assign pio [48]   = note_c4;

endmodule
