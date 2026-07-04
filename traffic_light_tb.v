timescale 1ns/1ps

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

task check_state;
    input [2:0] expected_north;
    input [2:0] expected_east;
    input [127:0] state_name;

    begin
        if (north == expected_north && east == expected_east)
            $display("PASS: %s", state_name);
        else
            $display("FAIL: %s  North=%b East=%b", state_name, north, east);
    end
endtask

initial begin

    clk = 0;
    reset = 1;

    $dumpfile("traffic.vcd");
    $dumpvars(0, traffic_light_tb);

// First rising edge -> S1
@(posedge clk);
#1;
check_state(3'b010, 3'b100, "North Yellow");

// Second rising edge -> S2
@(posedge clk);
#1;
check_state(3'b100, 3'b001, "East Green");

// Third rising edge -> S3
@(posedge clk);
#1;
check_state(3'b100, 3'b010, "East Yellow");

// Fourth rising edge -> S0
@(posedge clk);
#1;
check_state(3'b001, 3'b100, "North Green");

    $display("----------------------------");
    $display("Simulation Complete");
    $display("----------------------------");

    $finish;

end
endmodule
