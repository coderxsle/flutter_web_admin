#!/bin/bash

# 安装脚本 - 设置部署工具环境

# 设置颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # 无颜色

echo -e "${YELLOW}开始安装部署工具...${NC}"

# 检查Python版本
python_version=$(python3 --version 2>&1 | awk '{print $2}')
echo -e "${GREEN}检测到Python版本: ${python_version}${NC}"

# 创建虚拟环境
echo -e "${YELLOW}创建虚拟环境...${NC}"
python3 -m venv .venv
source .venv/bin/activate

# 安装依赖（使用setup.py）
echo -e "${YELLOW}安装依赖...${NC}"
pip install -e .

# 设置执行权限
echo -e "${YELLOW}设置执行权限...${NC}"
chmod +x deploy_tool/run.py

# 安装PyInstaller
echo -e "${YELLOW}安装PyInstaller...${NC}"
pip install pyinstaller

# 构建可执行文件
echo -e "${YELLOW}构建可执行文件...${NC}"
python build_executable.py

echo -e "${GREEN}安装完成!${NC}"
echo -e "${GREEN}可执行文件位于: $(pwd)/dist/deploy_tool${NC}"
echo -e "${YELLOW}您可以将可执行文件复制到系统路径中，或直接运行它${NC}" 