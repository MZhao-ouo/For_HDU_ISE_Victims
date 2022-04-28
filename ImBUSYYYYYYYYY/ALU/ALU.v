`timescale 1ns / 1ps

module ALU(
    input [1:32] sw,
    input [1:6] swb,
    input clk,
    output [2:0] which,
    output [7:0] seg,
    output reg enable=1,
    output ZF,
    output OF  );
    reg [1:32] A, B, F, data;
    reg [1:4] ALU_OP;
    reg [1:6] show_mode;
    reg C0_add, C0_sub, Cout;
    wire Cout_add, Cout_sub;
    wire [1:32] F_add, F_sub;

    initial begin
        data = 32'h0000_0000;
        show_mode = 6'b000000;
        C0_add = 1'b0;
        C0_sub = 1'b1;
    end

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
            case (ALU_OP)
            4'b0000: F <= A & B;  //与
            4'b0001: F <= A | B;   //或
            4'b0010: F <= A ^ B;   //异或
            4'b0011: F <= ~(A | B);   //或非
            4'b0100: begin F <= F_add; Cout <= Cout_add; end   //算数+
            4'b0101: begin F <= F_sub; Cout <= Cout_sub; end   //算数-
            4'b0110: F <= (A<B);   //若A<B,输出1,反之0
            4'b0111: F <= B<<A;   //B逻辑左移A指定的位数
            4'b1000: begin F <= A+1; A <= F; end   //自加1
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
    LCA_32 Adder(.A(A), .B(B), .C0(C0_add), .F(F_add), .C2(Cout_add));
    LCA_32 Suber(.A(A), .B(~B), .C0(C0_sub), .F(F_sub), .C2(Cout_sub));
    
    assign ZF = (F==0);
    assign OF = A[31]^B[31]^F[31]^Cout;

endmodule

