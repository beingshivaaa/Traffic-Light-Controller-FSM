module tlc_tb;
reg clk,rst_n;
wire red,yellow,green;

rtl_code dut(clk,rst_n,red,yellow,green);

always #5 clk=~clk;

initial begin
$dumpfile("tlc_waveform.vcd");
$dumpvars(0);

clk=0; rst_n=0;
#10 rst_n=1;
#200 $finish; //end simulation

end
endmodule
