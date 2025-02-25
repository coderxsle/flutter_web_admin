#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
部署工具入口脚本
"""

import os
import sys
import asyncio

# 添加项目根目录到 Python 路径
project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, project_root)

from deploy_tool.scripts.main import app

if __name__ == "__main__":
    asyncio.run(app())  # 使用 asyncio.run 运行异步函数 