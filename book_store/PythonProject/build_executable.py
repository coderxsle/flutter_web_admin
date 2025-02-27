#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
构建可执行文件的脚本
此脚本使用PyInstaller将run.py打包成可执行程序
"""

import os
import sys
import subprocess
import shutil
from pathlib import Path

def install_dependencies():
    """安装项目依赖和PyInstaller"""
    print("正在安装项目依赖...")
    # 使用setup.py安装依赖
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-e", "."])
    
    try:
        import PyInstaller
        print("PyInstaller已安装")
    except ImportError:
        print("正在安装PyInstaller...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyinstaller"])
        print("PyInstaller安装完成")

def build_executable():
    """构建可执行文件"""
    # 获取项目根目录
    project_root = Path(os.path.dirname(os.path.abspath(__file__)))
    run_py_path = project_root / "deploy_tool" / "run.py"
    
    # 确保run.py存在
    if not run_py_path.exists():
        print(f"错误：文件{run_py_path}不存在")
        return False
    
    # 创建输出目录
    dist_dir = project_root / "dist"
    os.makedirs(dist_dir, exist_ok=True)
    
    # 构建可执行文件
    print("正在构建可执行文件...")
    cmd = [
        "pyinstaller",
        "--name=deploy_tool",
        "--onefile",
        "--hidden-import=deploy_tool",
        "--hidden-import=deploy_tool.scripts",
        "--hidden-import=deploy_tool.scripts.main",
        "--hidden-import=deploy_tool.utils",
        "--paths", str(project_root),
        "--add-data", f"{project_root / 'deploy_tool' / 'config'}:config",
        str(run_py_path)
    ]
    
    # 在Windows系统上，路径分隔符不同
    if sys.platform.startswith('win'):
        cmd[9] = f"{project_root / 'deploy_tool' / 'config'};config"
    
    subprocess.check_call(cmd)
    
    print(f"构建完成! 可执行文件位于: {project_root / 'dist' / 'deploy_tool'}")
    return True

if __name__ == "__main__":
    install_dependencies()
    build_executable()