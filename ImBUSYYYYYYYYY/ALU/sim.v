`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/24 19:16:19
// Design Name: 
// Module Name: sim
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


module sim;
    reg [3:0] ALU_OP;
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] F;
    wire ZF;
    wire OF;
    wire SF;
    wire CF;
    wire PF;

    ALU ALU(
        .ALU_OP(ALU_OP),
        .A(A),
        .B(B),
        .F(F),
        .ZF(ZF),
        .OF(OF),
        .SF(SF),
        .CF(CF),
        .PF(PF)
    );

    initial begin
        // for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
        //     A = 32'h0;
        //     B = 32'hffff_ffff;
        //     #10;
        // end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'h1234_5678;
            B = 32'h9abc_def0;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'hffff_ffff;
            B = 32'h0000_0001;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'h0001_ffff;
            B = 32'hffff_0001;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'h0000_0000;
            B = 32'h0000_ffff;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'h8888_8888;
            B = 32'h8888_8888;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'h1010_1010;
            B = 32'h0101_0101;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'hf0f0_f0f0;
            B = 32'h0f0f_0f0f;
            #10;
        end
        for(ALU_OP = 4'b0000; ALU_OP <= 4'b0111; ALU_OP = ALU_OP + 1) begin
            A = 32'haaaa_aaaa;
            B = 32'h5555_5555;
            #10;
        end
    end
endmodule
