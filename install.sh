#!/bin/bash

# 安装脚本名称
SCRIPT_NAME="install_v2bx.sh"

# 下载安装脚本
echo "📥 正在下载安装脚本..."
if ! wget -O "$SCRIPT_NAME" https://raw.githubusercontent.com/wyx2685/V2bX-script/master/install.sh; then
    echo "❌ 下载失败！"
    exit 1
fi

# 添加执行权限
chmod +x "$SCRIPT_NAME"

# 使用 expect 自动化交互
echo "🚀 开始运行安装脚本，自动填写配置..."

cat << 'EOF' > run_with_expect.exp
#!/usr/bin/expect -f

set timeout 30

spawn bash $env(HOME)/install_v2bx.sh

# 逐行发送输入
expect "是否继续？[Y/n]:" { send "y\r"; exp_continue }
expect "是否继续？[Y/n]:" { send "y\r"; exp_continue }

expect "请输入你的面板地址:" { send "https://xboard.wufeng.me\r"; exp_continue }
expect "请输入你的Token:" { send "fW1oS7JqwZwZbFRnJJc7bC1j\r"; exp_continue }

expect "是否启用自动更新？[Y/n]:" { send "y\r"; exp_continue }

# Node ID: 必须是数字，这里明确输入 2
expect "请输入Node ID:" { send "2\r"; exp_continue }

# Port: 也必须是数字
expect "请输入端口号:" { send "2\r"; exp_continue }

expect "是否开启Web管理界面？[Y/n]:" { send "y\r"; exp_continue }
expect "是否开启开机自启？[Y/n]:" { send "n\r"; exp_continue }

# 等待结束
expect eof
EOF

# 执行 expect 脚本
expect run_with_expect.exp

# 清理临时文件
rm -f run_with_expect.exp
rm -f install_v2bx.sh

echo "✅ 安装完成！"

