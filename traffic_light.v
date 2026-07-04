module traffic_light(
    input clk,
    input reset,

    output reg [2:0] north,
    output reg [2:0] east
);

parameter RED    = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN  = 3'b001;

// States
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge reset)
begin

    if(reset)
  case (state)
    S0: state <= S1;
    S1: state <= S2;
    S2: state <= S3;
    S3: state <= S0;
    default: state <= S0;
endcase

end

always @(*)
begin

case (state)

    S0: begin
        north = GREEN;
        east  = RED;
    end

    S1: begin
        north = YELLOW;
        east  = RED;
    end

    S2: begin
        north = RED;
        east  = GREEN;
    end

    S3: begin
        north = RED;
        east  = YELLOW;
    end

    default: begin
        north = RED;
        east  = RED;
    end

endcase
end

endmodule
