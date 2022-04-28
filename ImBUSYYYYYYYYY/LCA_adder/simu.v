`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/14 10:13:03
// Design Name: 
// Module Name: simu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module simu;
    reg [31:0] A, B;
    reg Cin;
    wire [31:0] F;
    wire Cout;

    LCA_32 uut(
        .A(A),
        .B(B),
        .C0(Cin),
        .C2(Cout),
        .F(F)
    );

    initial begin
        A = 32'h0000_0000;
        B = 32'h0000_0000;
        Cin = 1'b0;

        #100;
        A = 32'hffff_ffff;
        B = 32'h0000_0001;
        #100;
        A = 32'h0000_ffff;
        B = 32'hffff_0000;
        Cin = 1'b1;
        #100;
        A = 32'h0000_0900;
        B = 32'h0000_0100;

    end
endmodule
