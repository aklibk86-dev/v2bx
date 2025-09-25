#!/bin/bash

# === 警告：此脚本会自动执行未经验证的远程安装程序 ===
# === 请先手动检查 install.sh 的内容以确保安全     ===

echo "正在准备安装 V2bX..."
echo "警告：此操作将自动输入敏感信息，请确保您信任该脚本！"

# 使用管道传递自动应答
{
    echo y
    echo y
    echo "https://xboard.wufeng.me"
    echo "fW1oS7JqwZwZbFRnJJc7bC1j"
    echo y
    echo 2
    echo 100
    echo 2
    echo y
    echo n
} | bash <(wget -qO- https://raw.githubusercontent.com/wyx2685/V2bX-script/master/install.sh)

# 检查执行结果
if [ $? -eq 0 ]; then
    echo "安装脚本执行完毕。"
else
    echo "安装过程中出现错误。"
fi
