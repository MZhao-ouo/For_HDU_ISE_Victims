`timescale 1ns / 1ps

module fetch(
    input clk,
    input reset,
    output [31:0] PC,
    output [31:0] Inst_code
    );
    reg [31:0] PC_reg, PC_new, d;
    reg write_enable;

    initial begin
        PC_reg = 0;
        PC_new = 0;
        write_enable = 0;
        d = 0;
    end

    always @(posedge clk) begin
        PC_new = PC_reg + 4;
    end

    always @(negedge clk or posedge reset) begin
        if (reset) begin
            PC_reg = 0;
        end
        else begin
            PC_reg = PC_new;
        end
    end

    IR_ROM ins_rom_inst(.a(PC_reg[7:2]),
                          .spo(Inst_code));

    assign PC = PC_reg;
endmodule
