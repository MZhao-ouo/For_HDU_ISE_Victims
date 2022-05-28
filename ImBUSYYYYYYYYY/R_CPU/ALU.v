`timescale 1ns / 1ps

module ALU(
    input [3:0] ALU_OP,
    input [31:0] A,
    input [31:0] B,
    output [31:0] F,
    output ZF,
    output OF,
    output SF,
    output CF,
    output PF
    );
    reg [31:0] A_reg, B_reg, F_reg;
    reg C0_add, C0_sub, Cout;
    wire Cout_add, Cout_sub;
    wire [31:0] F_add, F_sub;
    initial begin
        C0_add = 1'b0;
        C0_sub = 1'b1;
    end

    always @* begin
        A_reg <= A;
        B_reg <= B;
        case(ALU_OP)
            4'b0000: F_reg <= A_reg & B_reg;  //与
            4'b0001: F_reg <= A_reg | B_reg;   //或
            4'b0010: F_reg <= A_reg ^ B_reg;   //异或
            4'b0011: F_reg <= ~(A_reg | B_reg);   //或非
            4'b0100: begin F_reg <= F_add; Cout <= Cout_add; end   //算数+
            4'b0101: begin F_reg <= F_sub; Cout <= Cout_sub; end   //算数-
            4'b0110: F_reg <= (A_reg < B_reg);   //若A<B,输出1,反之0
            4'b0111: F_reg <= B_reg << A_reg;   //B逻辑左移A指定的位数
        endcase
    end

    LCA_32 Adder(.A(A_reg), .B(B_reg), .C0(C0_add), .F(F_add), .C2(Cout_add));
    LCA_32 Suber(.A(A_reg), .B(~B_reg), .C0(C0_sub), .F(F_sub), .C2(Cout_sub));

    assign F = F_reg;
    assign ZF = (F==32'h0000_0000);
    assign OF = A_reg[31]^B_reg[31]^F_reg[31]^Cout;
    assign SF = A_reg[31];
    assign CF = Cout;
    assign PF = ~^F;
endmodule

