`timescale 1ns/1ps

module traffic_light_tb;

reg clk;
reg reset;

wire [2:0] north;
wire [2:0] east;

traffic_light uut(

    .clk(clk),
    .reset(reset),
    .north(north),
    .east(east)

);

always #5 clk = ~clk;

initial begin

    clk = 0;
    reset = 1;

    $dumpfile("traffic.vcd");
    $dumpvars(0,traffic_light_tb);

    #10;

    reset = 0;

    #100;

    $finish;

end

endmodule
