`timescale 1ns / 1ps

module RegisterFile(
    input [4:0] R_Addr_A,
    input [4:0] R_Addr_B,
    input [4:0] W_Addr,
    input [31:0] W_Data,
    input reset,
    input clk,
    input Write_Reg,
    output [31:0] R_Data_A,
    output [31:0] R_Data_B
    );
    
    reg [31:0] REG_Files[0:31];
    reg [5:0] i;
    //写操作
    assign reset_ = ~reset;
    always  @(posedge clk or negedge reset_) begin
        if(!reset_)
            for (i=0;i<=31;i=i+1)
                REG_Files[i] <= 32'h0000_0000;
        else begin
            if (Write_Reg && W_Addr!=0)
                REG_Files[W_Addr] <= W_Data;
        end
    end
    
    //读操作
    assign R_Data_A = REG_Files[R_Addr_A];
    assign R_Data_B = REG_Files[R_Addr_B];
endmodule
