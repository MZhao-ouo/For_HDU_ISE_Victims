`timescale 1ns / 1ps

module simu;
    reg reset;
    reg clk;
    reg Write_Reg;
    reg [5:0] R_Addr_A;
    reg [5:0] R_Addr_B;
    reg [5:0] W_Addr;
    reg [31:0] W_Data;
    wire [31:0] R_Data_A;
    wire [31:0] R_Data_B;
    
    RegisterFile uut(
        .R_Addr_A(R_Addr_A),
        .R_Addr_B(R_Addr_B),
        .W_Addr(W_Addr),
        .W_Data(W_Data),
        .reset(reset),
        .clk(clk),
        .Write_Reg(Write_Reg),
        .R_Data_A(R_Data_A),
        .R_Data_B(R_Data_B)
    );
    
    initial begin
        clk = 0;
        reset = 0;
        Write_Reg = 0;
        R_Addr_A = 0;
        R_Addr_B = 0;
        W_Addr = 0;
        W_Data = 0;
        #10;
        R_Addr_A = 5'b00001;
        R_Addr_B = 5'b00010;
        W_Addr = 5'b00001;
        W_Data = 32'h12345678;
        Write_Reg = 1;
        clk = 1;
        #10;
        clk = 0;
        #10;
        W_Addr = 5'b00010;
        W_Data = 32'h87654321;
        Write_Reg = 1;
        clk = 1;
        #10;
        clk = 0;
        #10;
        R_Addr_A = 0;
        R_Addr_B = 0;
        W_Addr = 5'b11111;
        W_Data = 32'h89abcedef;
        Write_Reg = 1;
        clk = 1;
        #10;
        clk = 0;
        #10;
        W_Addr = 5'b10101;
        W_Data = 32'h9890acfe;
        Write_Reg = 1;
        clk = 1;
        #10;
        Write_Reg = 0;
        R_Addr_A = 5'b11111;
        R_Addr_B = 5'b10101;
        clk = 0;
        #10;
        reset = 1;
        clk = 1;
        #10;
        R_Addr_A = 5'b00001;
        R_Addr_B = 5'b00010;
        clk = 0;
        #10;
        R_Addr_A = 5'b11111;
        R_Addr_B = 5'b10101;
        
    end
endmodule
