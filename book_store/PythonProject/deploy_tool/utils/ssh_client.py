#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SSH 客户端模块
提供 SSH 连接和操作的基础功能。
"""

from typing import Optional, Any
from fabric import Connection
from .env_utils import EnvUtils
from .log_utils import log_info, log_error

class SSHClient:
    """SSH 客户端类，提供连接和命令执行功能"""
    
    _instance = None  # 类变量，用于存储单例实例

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(SSHClient, cls).__new__(cls)
        return cls._instance

    def __init__(self):
        if not hasattr(self, 'conn'):  # 确保只初始化一次
            self.conn: Optional[Connection] = None


    def run(self, command: str, hide: bool = True) -> Any:
        """
        执行 SSH 命令
        参数:
            command: 要执行的命令
            hide: 是否隐藏输出
        返回:
            命令执行结果
        """
        if not self.__check_connection():
            return None
        try:
            print(f"执行命令: {command}")
            result = self.conn.run(command, hide=hide)
            return result.stdout.strip() if result.stdout else True
        except Exception as e:
            log_error(f"执行命令失败: {e}")
            return None

    def put(self, local_path: str, remote_path: str) -> bool:
        """
        通过 SCP 传输文件
        参数:
            local_path: 本地文件路径
            remote_path: 远程文件路径
        返回:
            bool: 传输是否成功
        """
        if not self.__check_connection():
            return False
        try:
            print(f"传输文件: {local_path} 到 {remote_path}")
            self.conn.put(local_path, remote_path)
            return True
        except Exception as e:
            log_error(f"文件传输失败: {e}")
            return False

    def disconnect(self):
        """关闭远程连接"""
        if self.conn:
            self.conn.close()
            log_info("远程连接已关闭")
            self.conn = None 

    def __create_connection(self) -> Optional[Connection]:
        """创建 SSH 连接"""
        try:
            server_ip = EnvUtils.get_env('SERVER_IP')
            server_user = EnvUtils.get_env('SERVER_USER')
            ssh_password = EnvUtils.get_env('SSH_PASSWORD')

            if not all([server_ip, server_user, ssh_password]):
                log_error("缺少必要的连接信息")
                return None

            # 创建链接
            log_info("正在创建链接...")
            log_info(f"连接信息: {server_ip}, {server_user}, {ssh_password}")
            self.conn = Connection(
                host=server_ip,
                user=server_user,
                connect_kwargs={
                    "password": ssh_password,
                    "banner_timeout": 60,
                    "timeout": 30,
                }
            )

            # 测试连接
            self.conn.run("echo 'Connection test'", hide=True)
            log_info("远程连接建立成功")
            return self.conn

        except Exception as e:
            log_error(f"建立连接失败: {str(e)}")
            return None

    def __check_connection(self) -> bool:
        """检查连接是否有效"""
        if self.conn is None:
            return self.__create_connection() is not None
        try:
            self.conn.run("echo 'Connection test'", hide=True)
            log_info("使用现有连接")
            return True
        except Exception:
            log_error("连接已断开，重新建立连接")
            return self.__create_connection() is not None
        





