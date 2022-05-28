`timescale 1ns / 1ps
// 8 位七段数码管扫描显示模块 /////////////////////////////////////////////////////////
// 用法：
// input clk;
// output [2:0] which;
// output [7:0] seg;
// output reg enable = 1; // 默认开启数码管使能-1亮0灭
// reg [1:32] data;
// Display Display_Instance(.clk(clk), .data(sw), .which(which), .seg(seg));
//
// 管脚配置：
// set_property IOSTANDARD LVCMOS18 [get_ports seg]
// set_property PACKAGE_PIN H19 [get_ports {seg[7]}]
// set_property PACKAGE_PIN G20 [get_ports {seg[6]}]
// set_property PACKAGE_PIN J22 [get_ports {seg[5]}]
// set_property PACKAGE_PIN K22 [get_ports {seg[4]}]
// set_property PACKAGE_PIN K21 [get_ports {seg[3]}]
// set_property PACKAGE_PIN H20 [get_ports {seg[2]}]
// set_property PACKAGE_PIN H22 [get_ports {seg[1]}]
// set_property PACKAGE_PIN J21 [get_ports {seg[0]}]
// set_property IOSTANDARD LVCMOS18 [get_ports which]
// set_property PACKAGE_PIN N22 [get_ports {which[0]}]
// set_property PACKAGE_PIN M21 [get_ports {which[1]}]
// set_property PACKAGE_PIN M22 [get_ports {which[2]}]
// set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN L21} [get_ports enable]
// set_property -dict {IOSTANDARD LVCMOS18 PACKAGE_PIN H4} [get_ports clk]
// 
// set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
//////////////////////////////////////////////////////////////////////////////////
module NumDisplay(clk, data, which, seg,
    count, digit); // 调试接口
    input clk; // 接入系统时钟
    input [32:1] data; // 32 位显示数据
    output reg [2:0] which = 0; // 片选编码（驱动哪一位数码管），低电平有效
    output reg [7:0] seg; // 段选信号（点亮哪些笔划），低电平有效
    output reg [10:0] count = 0; // 分频扫描，从左至右循环驱动每一位数码管
    always @(posedge clk) count <= count + 1'b1;
    always @(negedge clk) if (&count) which <= which + 1'b1;
    output reg [3:0] digit; // 显示数据 片选得到 十六进制数码
    always @* case (which)
        0: digit <= data[32:29]; // 最高位
        1: digit <= data[28:25];
        2: digit <= data[24:21];
        3: digit <= data[20:17];
        4: digit <= data[16:13];
        5: digit <= data[12:09];
        6: digit <= data[08:05];
        7: digit <= data[04:01]; // 最低位
    endcase
    //数码管原理和设置详见本书 8.4.2 小节，HDU-XL-01 板卡上的数码管采用共阳极方式，
    //因此段选为 0 时点亮数码管
    always @* case (digit) // 十六进制数码 转换为 段选信号
        4'h0: seg <= 8'b0000_0011; // 除 g、dp 外全亮，显示数码 0
        4'h1: seg <= 8'b1001_1111; // 仅 b、c 亮，显示数码 1
        4'h2: seg <= 8'b0010_0101;
        4'h3: seg <= 8'b0000_1101;
        4'h4: seg <= 8'b1001_1001;
        4'h5: seg <= 8'b0100_1001;
        4'h6: seg <= 8'b0100_0001;
        4'h7: seg <= 8'b0001_1111;
        4'h8: seg <= 8'b0000_0001;
        4'h9: seg <= 8'b0000_1001;
        4'hA: seg <= 8'b0001_0001;
        4'hB: seg <= 8'b1100_0001;
        4'hC: seg <= 8'b0110_0011;
        4'hD: seg <= 8'b1000_0101;
        4'hE: seg <= 8'b0110_0001;
        4'hF: seg <= 8'b0111_0001;
    endcase
endmodule // Display
