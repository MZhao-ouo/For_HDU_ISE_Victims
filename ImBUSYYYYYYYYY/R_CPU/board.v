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
    wire [31:0] ND_data, LED_data;
    wire OF, ZF;
    reg [31:0] data;
    reg clk_cpu, reset_cpu;
    reg data_or_sign=0;

    always @* begin
        clk_cpu = swb[1];
        reset_cpu = swb[2];
    end
    always @(posedge swb[3]) begin
        data_or_sign = ~data_or_sign;
    end

    R_CPU r_cpu(
        .clk(clk_cpu),
        .reset(reset_cpu),
        .Inst_code(ND_data),
        .ALU_F(LED_data),
        .OF(OF),
        .ZF(ZF)
        );

    NumDisplay Display(.clk(clk), .data(ND_data), .which(which), .seg(seg));
    assign led = (data_or_sign)? LED_data:{OF,ZF} ;

endmodule
