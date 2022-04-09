# 去你的 ISE，Vivado 我来啦




        **ISE** 早于2013年停止更新，而杭电的数电计组课还在使用 ISE。然而如今大多数同学的电脑都装着 Windows 10（或Windows 11），ISE 又没有对其的适配，很多同学可能安装不上，还得再折腾一个虚拟机。

        既然 Xilinx 放弃 ISE 转头开发了 **Vivado**，我们为什么不用适配更好、界面更现代、维护更稳定的 Vivado 呢？况且 Vivado 刚好支持杭电教学所用的开发板，我们用起来就更没什么可担心的了。

        这篇文章将告诉你如何<u> **安装 Vivado** </u>以及课程中<u> **使用 Vivado 的一般流程** </u>。

## Vivado 安装


### 1. 下载

        从 [Vivado 官网](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html) 下载 2020.1 的版本，点击 <u>Xilinx Unified Installer 2020.1: Windows Self Extracting Web Installer</u>，注意名称，如图：

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-16-06-image.png)

        此时会弹出登录界面，注册一个 Xilinx 账号即可。<u> 这个账号之后还会用到。</u>

        然是填个人信息，其实这块随便挑都能过的，填完后点 Download 下载。

### 2. 安装

        双击运行刚下好的安装器，会提示有新版本可用，直接叉掉，不更。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-25-40-image.png)

        跟着箭头走，配置按图中选

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-26-51-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-28-13-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-29-33-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-34-02-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-34-12-image.png)

        **重点来了，默认的 Devices 下载下来要<u> 23GB </u>，而我们只用到了 7 Series 的开发板，跟着图片选，下载的资源直降到<u> 10GB </u>**。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-38-58-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-01-40-53-image.png)

        然后点击 Install 就开始下载安装了。

        安装完成后点击 Finish 会弹出证书授权界面。

### 3. 获取 Licence

        [前往官网获取证书](https://www.xilinx.com/member/forms/license-form.html?group=esd_oms&os=nt64&version=2020.1&licensetype=4&ea=88a4c2a201d8,4c034f0a1118,4e034f0a1117,00ffdbbaaa50,005056c00001,005056c00008,4c034f0a111b,4c034f0a1117&ds=f0bb5ccc&di=&hn=MZhao-LEGION)，填完信息点 Next，我选了如图的Licence

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-25-28-image.png)

        导入 Licence

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-26-30-image.png)

        安装完成！

## HDU 常用流程


        接下来本文将用 **一位二进制全加器** 作为示例，来介绍 HDU 课上使用 Vivado 的一般流程。

### 1. 新建项目

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-43-08-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-44-37-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-44-54-image.png)

        之后 Add Sources 和 Add Constraints都不用管，直接点 Next 。

        然后是 **关键** 的一步，选开发板。HDU 用的是 `xc7a100tfgg484-2L`。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-47-42-image.png)

        选完之后点 Finish，项目创建完毕。

### 2. 模块编写

        点 **加号** 添加文件，选择 design sources，点 Next。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-52-59-image.png)

        点 Create File 创建文件，填写文件名，点 OK，然后点 Finish。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-54-47-image.png)

        下一步什么都不用管，直接点 OK，点 Yes。文件创建完毕。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-12-56-14-image.png)

        双击刚才创建的文件，编写module。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-01-12-image.png)

        此处用 **结构建模** 的方式编写，可直接复制下述代码。`Ctrl + S` 保存

```verilog
module FullAdder(A, B, Cin, Cout, Sum);
    input A, B, Cin;
    output Cout, Sum;
    wire S1, T1, T2, T3;

    xor uu1(S1, A, B);
    xor uu2(Sum, S1, Cin);

    and uu3(T1, A, B);
    and uu4(T2, A, Cin);
    and uu5(T3, B, Cin);

    or  uu6(Cout, T1, T2, T3);
endmodule
```

### 3. 语法检查

        点击左侧 Run Synthesis 进行语法检查。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-09-48-image.png)

        检查完毕后这个界面会帮你选择之后的步骤，不用管，直接叉掉。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-07-52-image.png)

### 4. 仿真模块

        点 **加号** 添加仿真文件，选择 simulation sources，点 Next。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-11-37-image.png)

        接下来的步骤和创建功能模块一样。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-13-04-image.png)

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-13-07-image.png)

        右键 Simulation Sources 里面的仿真模块，Set as Top置为顶层模块。双击在右侧编写测试模块。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-24-37-image.png)

        关键一步：Vivado 不会像 ISE 那样自动生成实例化模块的代码，接下来简单讲解一下编写仿真模块的代码，其实也并不麻烦。

```verilog
module simu;        // 仿真模块一般不需要输入输出，所以括号也不必要。
    // 定义变量
    reg A, B, Cin;
    wire Cout, Sum;
    // 实例化 FullAdder 模块
    FullAdder uut(A, B, Cin, Cout, Sum);
    // 接下来写仿真代码
    initial begin       // 这块是代码模板
        // 初始化输入变量
        A=0;
        B=0;
        Cin=0;
        // 在下面写测试的输入
        #100;       //延迟100ns
        A=0; B=0; Cin=0;
        #100;
        A=0; B=0; Cin=1;
        #100;
        A=0; B=1; Cin=0;
        #100;
        A=0; B=1; Cin=1;
        #100;
        A=1; B=0; Cin=0;
        #100;
        A=1; B=0; Cin=1;
        #100;
        A=1; B=1; Cin=0;
        #100;
        A=1; B=1; Cin=1;
    end
endmodule
```

### 5. 仿真测试

        点击左侧的 Run Simulation，选择 Run Behavioral Simulation 。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-33-35-image.png)

        点击如图按钮可以自动将波形图缩放到合适大小。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-36-22-image.png)

        点击右上角的叉关闭仿真

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-39-19-image.png)

### 6. 逻辑综合

        退出仿真后点击左侧 Run Implementation 即可进行逻辑综合。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-07-24-image.png)

### 7. 查看电路

        点击左侧 Open Elaborated Design 查看电路图

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-46-03-image.png)

### 8. 配置管脚

#### 方法一：图形化界面

        在电路图界面点击 I/O Ports即可在下方展示出配置管脚的界面。

        在这里要注意：虽说I/O Std的默认设置也是LVCMOS18，但也会有奇怪的问题，所以要手动再选一下。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-55-29-image.png)

        按`Ctrl + S`保存，填写文件名，点 OK，会在 Constraints 下生成 xdc 管脚文件。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-13-57-52-image.png)

#### 方法二：手写代码

        新建文件选择 Constraints 文件，在 xdc 文件中即可手写配置文件。![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-00-45-image.png)

### 9. 生成比特流文件

        右键点击左侧的 Generate Bitstream 选择比特流设置，在弹出界面选择下图框选蓝字

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-11-54-image.png)

        将比特流压缩设置为 TRUE，点击OK

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-13-18-image.png)

        然后点击 Generate Bitstream 即可生成  .bit 文件（可能会提示还需要进行逻辑综合 Implementation，执行就可以了）。

        .bit 文件存放在如图所示路径，即`*/*.runs/impl_1/*.bit` 

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-16-49-image.png)

### 10. 上板！

        用老师发布的 bit烧写工具，按压缩包中的安装说明即可，此处略过。

![](C:\Users\mzhao\AppData\Roaming\marktext\images\2022-04-09-14-23-04-image.png)

        选择刚刚生成的 .bit 文件，随便选一个 COM 口即可，然后点发送文件，大功告成！

## 参考文章


[从ISE到vivado - 赵子一的博客 (zz1.ink)](https://zz1.ink/2021/12/15/ise_to_vivado/)

HDU Vivado安装教程
