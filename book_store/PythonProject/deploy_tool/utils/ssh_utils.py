#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from typing import Optional
import paramiko
from scp import SCPClient
from rich.progress import Progress

from .log_utils import log_info, log_error

def create_ssh_client() -> Optional[paramiko.SSHClient]:
    """
    创建SSH客户端
    
    Returns:
        Optional[paramiko.SSHClient]: SSH客户端实例
    """
    try:
        client = paramiko.SSHClient()
        client.load_system_host_keys()
        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        
        # 获取连接信息
        host = os.getenv('SERVER_IP')
        user = os.getenv('SERVER_USER')
        key_file = os.path.expanduser('~/.ssh/id_rsa')
        
        if not all([host, user]):
            log_error("缺少SSH连接信息")
            return None
            
        # 连接服务器
        client.connect(
            hostname=host,
            username=user,
            key_filename=key_file
        )
        
        return client
    except Exception as e:
        log_error(f"SSH连接失败: {str(e)}")
        return None

def ssh_execute(command: str) -> Optional[str]:
    """
    执行SSH命令
    
    Args:
        command: 要执行的命令
        
    Returns:
        Optional[str]: 命令输出
    """
    client = create_ssh_client()
    if not client:
        return None
        
    try:
        stdin, stdout, stderr = client.exec_command(command)
        exit_status = stdout.channel.recv_exit_status()
        
        if exit_status != 0:
            error = stderr.read().decode().strip()
            log_error(f"命令执行失败: {error}")
            return None
            
        return stdout.read().decode().strip()
    except Exception as e:
        log_error(f"命令执行出错: {str(e)}")
        return None
    finally:
        client.close()

def scp_transfer(src_path: str, dest_path: str, progress: Optional[Progress] = None) -> bool:
    """
    使用SCP传输文件
    
    Args:
        src_path: 源文件路径
        dest_path: 目标路径
        progress: 进度条对象
        
    Returns:
        bool: 是否传输成功
    """
    client = create_ssh_client()
    if not client:
        return False
        
    try:
        with SCPClient(client.get_transport(), progress=progress) as scp:
            scp.put(src_path, dest_path)
        return True
    except Exception as e:
        log_error(f"文件传输失败: {str(e)}")
        return False
    finally:
        client.close() 