`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/09 12:56:22
// Design Name: 
// Module Name: FullAdder
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


module FullAdder(A, B, Cin, Cout, Sum);
    input A, B, Cin;
    output Cout, Sum;
    wire S1, T1, T2, T3;
    
    xor uu1(S1, A, B);
    xor uu2(Sum, S1, Cin);
    
    and uu3(T1, A, B);
    and uu4(T2, A, Cin);
    and uu5(T3, B, Cin);
    
    or  uu6(Cout, T1, T2, T3);
endmodule
