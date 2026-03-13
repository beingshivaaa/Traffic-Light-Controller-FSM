module rtl_code(
    input clk,rst_n,
    output reg red,
    output reg yellow,
    output reg green
);

reg [1:0] state,next_state;
reg [3:0] count;

//STATE BINARY ENCODING
parameter RED=2'b00;
parameter YELLOW=2'b01;
parameter GREEN=2'b10;

//TIMING PARAMETERS
parameter red_time=5; //wait for 5 cycles
parameter yellow_time=2; //wait for 2 cycles
parameter green_time=5; //wait for 5 cycles

//STATE REGISTER
always @(posedge clk or negedge rst_n) begin
        if(!rst_n) state<=RED;
        else state<=next_state;
end

//COUNTER for the duration of traffic light colours
always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
        count<=0;
        else if(state!=next_state) //state transition occured,so timer starts again
        count<=0;
        else
        count<= count+1;
end

//NEXT STATE LOGIC  red->green>yellow->red->green->yellow .....
always@(state or count) begin
case(state)

        RED: if(count==red_time-1) 
                next_state<=GREEN;
             else 
                next_state<=RED;
        
        GREEN: if(count==green_time-1)
                 next_state<=YELLOW;
               else
                 next_state<=GREEN;
        
        YELLOW: if(count==yellow_time-1)
                 next_state<=RED;
                else
                 next_state<=YELLOW;

        default: next_state<=RED;

endcase
end

//OUTPUT LOGIC(MOORE)
always @(*)
begin
red = 0;
yellow = 0;
green = 0;

case(state)
RED: red = 1;
GREEN: green = 1;
YELLOW: yellow = 1;
endcase
end

endmodule

