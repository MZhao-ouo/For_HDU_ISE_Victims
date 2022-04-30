`timescale 1ns / 1ps

module top(
    input [1:6] swb,
    input [1:32] sw,
    input clk,
    output [2:0] which,
    output [7:0] seg,
    output reg enable = 1
    );
    reg [5:0] R_Addr_A, R_Addr_B, W_Addr;
    reg [31:0] W_Data, Display_Data;
    reg [2:0] Display_mode;
    wire [31:0] R_Data_A, R_Data_B;
    assign Display_A = swb[1];
    assign Display_B = swb[2];
    assign Write_Reg = swb[3];
    assign Write_confirm = swb[4];
    assign Display_nomal = swb[5];
    assign reset = swb[6];

    initial begin 
        R_Addr_A = 5'b00000;
        R_Addr_B = 5'b00000;
        W_Addr = 5'b00000;
        W_Data = 32'h0000_0000;
    end
    RegisterFile uu1(R_Addr_A, R_Addr_B, W_Addr, W_Data, reset, clk, Write_Reg, R_Data_A, R_Data_B);
    
    always @* begin
        R_Addr_A = sw[1:5];
        R_Addr_B = sw[6:10];
        case (Display_mode)
            2'b00: Display_Data <= R_Data_A;
            2'b01: Display_Data <= R_Data_B;
            2'b10: Display_Data <= W_Data;
            2'b11: Display_Data <= sw;
        endcase
    end

    always @(posedge |swb) begin
        if(Display_A)
            Display_mode <= 2'b00;
        else if(Display_B)
            Display_mode <= 2'b01;
        else if(Write_Reg) begin
            Display_mode <= 2'b10;
            W_Data <= sw;
        end
        else if(Write_confirm) begin
            Display_mode <= 2'b11;
            W_Addr = sw[28:32];
        end
        else if(Display_nomal) begin
            Display_mode <= 2'b11;
        end
    end
    NumDisplay uu2(.clk(clk), .data(Display_Data), .which(which), .seg(seg));
endmodule
