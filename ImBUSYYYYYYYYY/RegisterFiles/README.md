# 32*32位寄存器堆
`RegisterFile.v` 为本实验的重要模块。

`top.v` 为顶层模块，同样实现了全板级操作。调用了 **RegisterFile**、**NumDisplay** 模块。

> `swb[1:2]`: 显示当前A/B的值
> 
> `swb[3]`: 将sw[1:32]的值写入W_Data
>
> `swb[4]`: 将sw[29:32]的值写入W_Addr
> 
> `swb[5]`: 切换回数码管实时显示32开关值
> 
> `swb[6]`: reset，将寄存器中的值清零

`simu.v` 为仿真模块，仅对 **RegisterFile** 模块进行了仿真。
