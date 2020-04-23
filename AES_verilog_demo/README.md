# AES加密算法的Verilog代码

## 基本说明

本项目完全基于标准AES的加密流程，利用verilog设计实现了ECB模式下的AES加密过程。

代码实现过程请参考和对照标准AES加密过程。

## 参数说明

- 顶层文件输入输出参数：
  - iKey，明文，长度128bit
  - iPlaintext，密钥，长度128bit
  - oCiphertext，密文，长度128bit
  - 数据的低位放置在变量的高位中
- 其余参数请参考代码文件中的注释部分

## 项目文件说明

项目包含三个文件夹

- ROM_2P

  - AES_sTable.mif：包含双端ROM的数据表，存放S盒数据

- simulation

  - AES_encryp_top.vt：testBench文件，给出一组测试明文、测试密钥
  - AES调试数据_1.txt：记录了一些测试过程中的数据
  - 仿真图x.png：给出了仿真截图

- RTL

  - 包含了所有Verilog代码，各文件关系由代码关系图.png给出。
  - 各文件主要内容请参考文件中的注释。

  

![image-20200423110748416](C:\Users\liupeng_Y500\AppData\Roaming\Typora\typora-user-images\image-20200423110748416.png)

​																					代码关系图.png



