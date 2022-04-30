`timescale 1ns / 1ps

module top(
    input [1:32] sw,
    input [1:6] swb,
    input clk,
    output [2:0] which,
    output [7:0] seg,
    output reg enable=1,
    output [1:32] led
    );
    reg [2:0] ALU_OP;
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] F;
    wire ZF;
    wire OF;
    wire SF;
    wire CF;
    wire PF;

    reg [5:0] show_mode;
    reg [31:0] data;

    initial begin
        data = 32'h0000_0000;
        show_mode = 6'b000000;
    end

    ALU ALU(.ALU_OP(ALU_OP), .A(A), .B(B), .F(F), .ZF(ZF), .OF(OF), .SF(SF), .CF(CF), .PF(PF));

    always @(posedge |swb) begin
        case (swb)
            6'b100000: begin A <= sw; show_mode <= 6'b100000; end
            6'b010000: begin B <= sw; show_mode <= 6'b010000; end
            6'b001000: begin ALU_OP <= sw[1:4]; show_mode <= 6'b001000; end
            6'b000100: begin show_mode <= 6'b000100; end
            6'b000010: begin show_mode <= 6'b000010; end
            6'b000001: begin show_mode <= 6'b000001; end
            6'b000110: begin show_mode <= 6'b000000; end
        endcase
    end

    always @* begin
        case (show_mode)
            6'b000000: data <= sw;
            6'b100000: data <= A;
            6'b010000: data <= B;
            6'b001000: data <= sw;
            6'b000100: data <= A;
            6'b000010: data <= B;
            6'b000001: data <= F;
        endcase
    end

    NumDisplay Display(.clk(clk), .data(data), .which(which), .seg(seg));

    assign led[1] = ZF;
    assign led[2] = OF;
    assign led[3] = SF;
    assign led[4] = CF;
    assign led[5] = PF;
    assign led[6:32] = 0;

endmodule
