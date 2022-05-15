`timescale 1ns / 1ps

module simu();
    reg clk;
    reg reset;
    wire [31:0] PC;
    wire [31:0] Inst_code;

    integer i;

    mips mips_inst(.clk(clk), .reset(reset), .PC(PC), .Inst_code(Inst_code));

    initial begin
        clk = 0;
        reset = 0;
        for (i = 0; i < 31; i = i + 1) begin
            #10;
            clk = 1;
            #10;
            clk = 0;
        end
        #10;
        reset = 1;
    end
endmodule
