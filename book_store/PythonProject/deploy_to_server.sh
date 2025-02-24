#!/bin/bash

# 设置环境变量
export ENV=${ENV:-"prod"}  # 默认使用 prod 环境
export PROJECT_ROOT=$(pwd)  # 使用当前目录作为项目根目录

# 运行部署工具
./deploy_tool 