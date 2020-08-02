# Xilinx2020_wbbb
2020年新工科联盟-Xilinx暑期学校（Summer School）
小组成员：
刘龙吉 2018112736 （组长）
王静 2018112729
项目名称：数字识别
项目概要：通过MIPI OV5647摄像头获取白底黑字数字的图像信息，利用FPGA对图像进行加速处理，根据数字字符的不同特征成功识别0-9十个数字。并把识别结果显示在电脑显示器或LCD上显示屏上
相关知识：基于模版匹配的识别方法、基于数字特征的识别方法、Verilog编程、mini HDMI 转VGA 1280*720 显示、MIPI OV5647摄像驱动读取
设计目的：利用FPGA实现数字特征的识别算法
设想应用场景：车牌识别、证件识别、名片识别、汽车VIN码识别、文字识别
已实现功能：利用MIPI驱动、HDMI显示成功显示0-9等十个数字并在显示屏上
使用工具：
·Vivado 2018.3 
·ardunio1.8
板卡型号：
SPARTAN-7 xc7s15ftg196-1
外设列表:
·MIPI OV5647摄像头
·mini HDMI
仓库⽬录介绍:
·可执行文件：存放bitstream文件
·源代码：Camera_Demo.v process.v Driver_MIPI.v Driver_Csi_To_Dvp.v Driver_Bayer_To_RGB.v OV5647_Init.v Driver_IIC.v
·图片：演示照片，视频
