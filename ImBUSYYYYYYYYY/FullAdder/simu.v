`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/09 13:12:27
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
    // 定义变量
    reg A, B, Cin;
    wire Cout, Sum;
    // 实例化FullAdder模块
    FullAdder uut(A, B, Cin, Cout, Sum);
    // 接下来写仿真代码
    initial begin       // 这块是代码模板
        A=0;
        B=0;
        Cin=0;
        // 在下面写测试的输入
        #100;       //延迟100ns
        A=0; B=0; Cin=0;
        #100;
        A=0; B=0; Cin=1;
        #100;
        A=0; B=1; Cin=0;
        #100;
        A=0; B=1; Cin=1;
        #100;
        A=1; B=0; Cin=0;
        #100;
        A=1; B=0; Cin=1;
        #100;
        A=1; B=1; Cin=0;
        #100;
        A=1; B=1; Cin=1;
    end
endmodule
