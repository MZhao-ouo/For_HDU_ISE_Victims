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
    // �������
    reg A, B, Cin;
    wire Cout, Sum;
    // ʵ����FullAdderģ��
    FullAdder uut(A, B, Cin, Cout, Sum);
    // ������д�������
    initial begin       // ����Ǵ���ģ��
        A=0;
        B=0;
        Cin=0;
        // ������д���Ե�����
        #100;       //�ӳ�100ns
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
