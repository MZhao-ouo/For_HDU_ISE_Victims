`timescale 1ns / 1ps

module board(
    input clk,
    input [1:6] swb,
    output [2:0] which,
    output [7:0] seg,
    output reg enable=1,
    output [1:32] led
    );
    reg clk_swb, reset;
    wire [1:32] PC, data;

    initial begin
        clk_swb = 0;
        reset = 0;
    end
    always @* begin
        clk_swb = swb[1];
        reset = swb[2];
    end

    mips mips(.clk(clk_swb), .reset(reset), .PC(PC), .Inst_code(data));

    NumDisplay Display_Instance(.clk(clk), .data(data), .which(which), .seg(seg));

    assign led = PC;

endmodule
