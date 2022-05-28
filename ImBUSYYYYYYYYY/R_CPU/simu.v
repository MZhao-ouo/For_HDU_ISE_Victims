`timescale 1ns / 1ps

module simu();
    reg clk;
    reg reset;
    wire [31:0] Inst_code;
    wire [31:0] ALU_F;
    wire OF;
    wire ZF;

    R_CPU r_cpu(clk, reset, Inst_code, ALU_F, OF, ZF);

    integer i;
    // reg [31:0] F_reg;
    // reg OF_reg, ZF_reg;
    initial begin
        clk = 0;
        reset = 0;
        #10;
        reset = 1;
        #10;
        reset = 0;
        for (i = 0; i < 64; i = i + 1) begin
            #10;
            clk = 1;
            #10;
            clk = 0;
        end
    end
endmodule
