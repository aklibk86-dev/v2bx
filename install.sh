#!/bin/bash

# 脚本名称: run_install_with_inputs.sh
# 功能: 下载并运行 V2bX 安装脚本，并自动提供预设的交互输入

# 设置要传递给 install.sh 的输入内容
# 使用 Here Document 定义多行输入，EOF 可以用其他标记替换
INPUTS=$(cat <<EOF
y
y
https://xboard.wufeng.me
fW1oS7JqwZwZbFRnJJc7bC1j
y
2
2
y
n
)

# 1. 下载安装脚本
echo "正在下载安装脚本..."
if wget -N https://raw.githubusercontent.com/wyx2685/V2bX-script/master/install.sh; then
    echo "安装脚本下载成功。"
else
    echo "错误：安装脚本下载失败。"
    exit 1
fi

# 2. 确保脚本具有可执行权限
chmod +x install.sh

# 3. 将输入内容传递给安装脚本并执行
# 使用 bash -s 可以更好地处理从标准输入读取的脚本
echo "正在运行安装脚本并自动输入配置..."
bash install.sh <<< "$INPUTS"

# 或者使用管道方式 (取消下面两行注释，并注释掉上面的 bash install.sh <<< "$INPUTS" 行)
# echo -e "y\ny\nhttps://xboard.wufeng.me\nfW1oS7JqwZwZbFRnJJc7bC1j\ny\n2\n2\ny\nn" | bash install.sh

echo "安装和配置脚本执行完毕。"
