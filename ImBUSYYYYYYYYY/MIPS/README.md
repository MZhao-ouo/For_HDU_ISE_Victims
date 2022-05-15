# MIPS汇编器与模拟器实验+取指令与指令译码实验
`mips.v` 为本实验的重要模块。(还有软件生成的IP核)

`board.v` 为顶层模块，同样实现了全板级操作。调用了 **mips**、**NumDisplay** 模块。

> `swb[1]`: clk
> 
> `swb[2]`: reset

`simu.v` 为仿真模块，仅对 **mips** 模块进行了仿真。
