`timescale 1ns / 1ps

module board(
    input [1:32] sw,
    input [1:6] swb,
    input clk,
    output [2:0] which,
    output [7:0] seg,
    output reg enable=1,
    output [1:32] led
    );
    wire [1:32] data;
    reg somebutton1, somebutton2;
    reg someswitch1, someswitch2;

    always @* begin
        somebutton1 = swb[1];
        somebutton2 = swb[2];
        someswitch1 = sw[1];
        someswitch2 = sw[2];
    end

    NumDisplay Display(.clk(clk), .data(ND_data), .which(which), .seg(seg));
    assign led = data;

endmodule
