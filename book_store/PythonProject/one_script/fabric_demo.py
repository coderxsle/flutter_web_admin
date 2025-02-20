#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Fabric 使用示例脚本
演示基本的远程服务器操作和部署功能
"""

import os
from fabric import Connection, Config
from pathlib import Path
from rich.console import Console
from rich.panel import Panel

console = Console()

def get_connection(host: str, user: str, key_path: str) -> Connection:
    """创建一个安全的 SSH 连接"""
    config = Config(overrides={'ssh_key_path': key_path})
    return Connection(
        host=host,
        user=user,
        config=config,
        connect_kwargs={
            "key_filename": key_path,
        }
    )

def check_system_status(conn: Connection) -> None:
    """检查服务器状态"""
    console.print(Panel("正在检查系统状态...", style="blue"))
    
    # 检查系统负载
    uptime = conn.run('uptime', hide=True)
    console.print(f"系统负载: {uptime.stdout.strip()}")
    
    # 检查内存使用
    memory = conn.run('free -h', hide=True)
    console.print(f"内存使用:\n{memory.stdout}")
    
    # 检查磁盘使用
    disk = conn.run('df -h /', hide=True)
    console.print(f"磁盘使用:\n{disk.stdout}")

def deploy_application(conn: Connection, app_path: str) -> None:
    """部署应用程序"""
    console.print(Panel("开始部署应用...", style="green"))
    
    # 创建部署目录
    conn.run('mkdir -p ~/app')
    
    # 上传应用文件
    conn.put(app_path, '~/app/')
    
    # 安装依赖
    with conn.cd('~/app'):
        conn.run('python3 -m venv venv')
        conn.run('source venv/bin/activate && pip install -r requirements.txt')

def main():
    # 配置信息
    HOST = os.getenv('SERVER_HOST', 'aiziran.top')
    USER = os.getenv('SERVER_USER', 'root')
    KEY_PATH = os.getenv('SSH_KEY_PATH', str(Path.home() / '.ssh' / 'id_rsa'))
    
    try:
        # 建立连接
        conn = get_connection(HOST, USER, KEY_PATH)
        console.print(Panel(f"成功连接到服务器: {HOST}", style="green"))
        
        # 执行操作
        check_system_status(conn)
        # deploy_application(conn, './your_app_path')  # 取消注释以执行部署
        
    except Exception as e:
        console.print(f"[red]错误: {str(e)}[/red]")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == '__main__':
    main() 