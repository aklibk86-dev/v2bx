#!/bin/bash

# 下载安装脚本
echo "正在下载 V2bX 安装脚本..."
if ! wget -O install_v2bx.sh https://raw.githubusercontent.com/wyx2685/V2bX-script/master/install.sh; then
    echo "❌ 下载失败，请检查网络或 URL"
    exit 1
fi

# 添加可执行权限
chmod +x install_v2bx.sh

# 定义自动输入内容（根据你的需求）
INPUTS="y
y
https://xboard.wufeng.me
fW1oS7JqwZwZbFRnJJc7bC1j
y
2
2
y
n"

# 执行安装脚本并自动传入输入
echo "🚀 开始运行安装脚本，自动输入配置..."
echo -e "$INPUTS" | bash install_v2bx.sh

# 检查执行结果
if [ $? -eq 0 ]; then
    echo "✅ 安装脚本执行成功！"
else
    echo "❌ 安装脚本执行失败，退出码: $?"
fi


