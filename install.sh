#!/bin/bash

# 脚本名称: run_install_with_delayed_inputs.sh
# 功能: 下载并运行 V2bX 安装脚本，并以指定间隔自动提供交互输入

# 定义要传递给 install.sh 的输入内容数组
INPUTS=(
    "y"
    "y"
    "https://xboard.wufeng.me"
    "fW1oS7JqwZwZbFRnJJc7bC1j"
    "y"
    "2"
    "2"
    "y"
    "n"
)

# 定义输入间隔（秒）
INTERVAL=0.01 # 10 毫秒

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

# 3. 启动安装脚本作为协程 (coprocess)
echo "正在启动安装脚本..."
coproc INSTALL_PROC { bash install.sh; }

# 获取协程的文件描述符
INSTALL_IN="${INSTALL_PROC[1]}"  # 用于读取安装脚本的输出 (如果需要)
INSTALL_OUT="${INSTALL_PROC[0]}" # 用于向安装脚本写入输入

# 4. 循环发送输入
echo "开始按间隔发送输入..."
for input in "${INPUTS[@]}"; do
    # 将输入写入到安装脚本的标准输入
    echo "$input" >&"${INSTALL_OUT}"
    # 等待指定间隔
    sleep "$INTERVAL"
done

# 5. 关闭写入管道 (可选，但推荐)
# 这告诉安装脚本没有更多输入了
exec {INSTALL_OUT}>&-

# 6. (可选) 等待安装脚本完成并捕获其退出状态
wait "${INSTALL_PROC_PID}" 2>/dev/null
EXIT_STATUS=$?

# 7. 输出结果
if [ $EXIT_STATUS -eq 0 ]; then
    echo "安装和配置脚本成功执行完毕。"
else
    echo "安装和配置脚本执行完毕，但返回了非零退出状态: $EXIT_STATUS"
fi



