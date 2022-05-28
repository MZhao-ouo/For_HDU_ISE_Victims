`timescale 1ns / 1ps

module decode(
    input clk,
    input [5:0] OP,
    input [5:0] func,
    output [3:0] ALU_OP,
    output Write_Wire
    );
    reg Write_Reg;
    reg [3:0] ALU_OP_reg;
    initial begin
        Write_Reg = 0;
    end
    always @(posedge clk) begin
        if(clk) begin
            if(OP == 6'b000000) begin
                case(func)
                    6'b100000: begin ALU_OP_reg = 4'b0100; Write_Reg = 1; end
                    6'b100010: begin ALU_OP_reg = 4'b0101; Write_Reg = 1; end
                    6'b100100: begin ALU_OP_reg = 4'b0000; Write_Reg = 1; end
                    6'b100101: begin ALU_OP_reg = 4'b0001; Write_Reg = 1; end
                    6'b100110: begin ALU_OP_reg = 4'b0010; Write_Reg = 1; end
                    6'b100111: begin ALU_OP_reg = 4'b0011; Write_Reg = 1; end
                    6'b101011: begin ALU_OP_reg = 4'b0110; Write_Reg = 1; end
                    6'b000100: begin ALU_OP_reg = 4'b0111; Write_Reg = 1; end
                endcase
            end
        end
    end
    assign ALU_OP = ALU_OP_reg;
    assign Write_Wire = Write_Reg;
endmodule
