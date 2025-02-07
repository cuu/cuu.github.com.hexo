---
title: ESP32-s3 jetbrain clion startup
date: 2025-02-07 21:03:00
tags: ESP32 clion 
---


# 安装esp-idf

```
git clone -b v5.4 --recursive https://github.com/espressif/esp-idf.git￼
./install.sh esp32s3

```
会遇到些问题
比如 components/xxxx/yyy is not a directoy ,这是git submodule 没有完全下载完全导致

删除 components/xxxx/yyy ,然后重新运行 

```
git submodule update --init --recursive
```

确保完整即可

在.bashrc里 增加一个 快捷命令 
```
alias get_idf='. $HOME/work/esp32/esp-idf/export.sh'
```
具体文档: https://docs.espressif.com/projects/esp-idf/en/v5.4/esp32s3/get-started/linux-macos-setup.html   


# 编译运行

以Hello world 为例  

先在 terminal 里 运行     

`get_idf`

然后 

`idf.py set-target esp32s3`

会创建一个build目录  

之后  
`idf.py menuconfig `  
如果需要做什么配置  

之后  
`idf.py build`  

自动编译  

编译完成 就是刷入   

`idf.py -p /dev/ttyACM1 flash`

查看串口信息 可以用 
`idf.py -p /dev/ttyACM1 monitor`

效果和 arduino IDE的 serial monitor 一样 

退出 monitor不是 ctrl+C, 而是 ctrl+]


# Jetbrain CLion  
## clion compiling  

在 打开的时候，cmake settings 界面 暂时不需要什么设置

然后

在 clion的 菜单 Settings->Build,Exection,Deployment->Toolchains 里
增加一个,比如esp32s3, 右边点击 Add enviroment -> From File
内容就是 export.sh
```
~/work/esp32/esp-idf/export.sh
```

然后 在cmake 的settings里  
可以设置:    
```
Toolchain: esp32s3 <- 必须选择
Build directoy 为build 
Enviroment: 里 增加  IDF_TARGET=esp32s3
```

手动 删除 目前任何残留的  build目录

重新 cmake 配置 即可 

## Flashing

cmake settings 里  Enviroment 里增加  `ESPPORT=/dev/ttyACM1`

然后在顶部菜单里，从hello_world.elf 换成 flash
点击 锄头的图标，就能完成刷写




