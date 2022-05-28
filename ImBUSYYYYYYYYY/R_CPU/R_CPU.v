`timescale 1ns / 1ps

module R_CPU(
    input clk,
    input reset,
    output [31:0] Inst_code,
    output [31:0] ALU_F,
    output OF,
    output ZF
    );

    reg [5:0] OP, func;
    reg [4:0] rs, rt, rd;
    reg Write_Reg, OF_reg, ZF_reg;
    reg [31:0] F_reg;
    wire [31:0] ALU_A, ALU_B, F_wire;
    wire [3:0] ALU_OP;
    wire Write_Wire, OF_wire, ZF_wire;

    assign clk_ = ~clk;

    always @* begin
        OP = Inst_code[31:26];
        rs = Inst_code[25:21];
        rt = Inst_code[20:16];
        rd = Inst_code[15:11];
        func = Inst_code[5:0];
        Write_Reg = Write_Wire;
        if (clk) begin
            F_reg = F_wire;
            ZF_reg = ZF_wire;
            if(ALU_OP==4'b0100 || ALU_OP==4'b0101)
                OF_reg = OF_wire;
            else
                OF_reg = 0;
        end
    end

    fetch fetch_inst(
        .clk(clk),
        .reset(reset),
        .Inst_code(Inst_code)
    );

    decode decode_inst(
        .clk(clk),
        .OP(OP),
        .func(func),
        .ALU_OP(ALU_OP),
        .Write_Wire(Write_Wire)
    );

    RegisterFile RF_inst(
        .R_Addr_A(rs),
        .R_Addr_B(rt),
        .W_Addr(rd),
        .W_Data(ALU_F),
        .reset(reset),
        .clk(clk_),
        .Write_Reg(Write_Reg),
        .R_Data_A(ALU_A),
        .R_Data_B(ALU_B)
    );

    ALU ALU_inst(
        .ALU_OP(ALU_OP),
        .A(ALU_A),
        .B(ALU_B),
        .F(F_wire),
        .OF(OF_wire),
        .ZF(ZF_wire)
    );

    assign ALU_F = F_reg;
    assign OF = OF_reg;
    assign ZF = ZF_reg;

endmodule
