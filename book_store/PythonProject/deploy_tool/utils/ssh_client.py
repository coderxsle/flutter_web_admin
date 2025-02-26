#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SSH 客户端模块
提供 SSH 连接和操作的基础功能。
"""

import os
import time
from typing import Optional, Any, Callable, List, Dict, Tuple
from fabric import Connection
from rich.progress import Progress, TaskID, BarColumn, TimeElapsedColumn, SpinnerColumn, TextColumn, DownloadColumn
import paramiko
from scp import SCPClient
import concurrent.futures
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

    def disconnect(self):
        """关闭远程连接"""
        if self.conn:
            self.conn.close()
            log_info("远程连接已关闭")
            self.conn = None

    def run(self, command: str, hide: bool = False) -> Any:
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


    def local_run(self, command: str, hide: bool = False) -> Any:
        """
        在本地执行命令
        参数:
            command: 要执行的命令
            hide: 是否隐藏输出
        返回:
            命令执行结果
        """
        try:
            print(f"在本地执行命令: {command}")
            # 创建一个新的连接实例，指向 localhost
            local_conn = Connection("localhost")
            result = local_conn.local(command, hide=hide, pty=True)  # 使用 Fabric 的 run 方法
            
            return result.stdout.strip() if result.stdout else True
            
        except Exception as e:
            log_error(f"本地命令执行失败: {e}")
            return None
        

       
    
    def put(self, local_path: str, remote_path: str) -> bool:
        """
        文件上传，实时显示进度
        
        参数:
            local_path: 本地文件路径
            remote_path: 远程文件路径
            
        返回:
            上传是否成功
        """
        # 我们现在使用新的 put_with_tqdm 实现，它提供真正的实时进度
        return self.__put_with_rich(local_path, remote_path)
    



    def put_multiple(self, file_list: List[Tuple[str, str]]) -> bool:
        """
        同时上传多个文件，并显示所有文件的上传进度
        
        参数:
            file_list: 文件列表，每个元素是 (本地路径, 远程路径) 元组
            
        返回:
            所有文件上传是否成功
        """
        if not self.__check_connection():
            return False
            
        try:
            # 创建一个 SSH 连接
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            
            # 获取 SSH 连接参数
            server_ip = EnvUtils.get('SERVER_IP')
            server_user = EnvUtils.get('SERVER_USER')
            ssh_password = EnvUtils.get('SSH_PASSWORD')
            
            # 建立 SSH 连接
            ssh.connect(
                hostname=server_ip,
                username=server_user,
                password=ssh_password,
                timeout=30
            )
            
            # 使用 Rich 来显示多个进度条，并自定义格式以显示速度和总用时
            # 使用自定义列显示传输速度和已用时间
            progress = Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                "[progress.percentage]{task.percentage:>3.0f}%",
                "•",
                DownloadColumn(),
                "•",
                TextColumn("[bold green]{task.fields[speed]}"),
                "•",
                TimeElapsedColumn(),
            )
            
            # 记录任务开始时间和上一次更新时间
            task_start_times = {}
            task_last_update = {}
            task_last_completed = {}
            
            with progress:
                # 为每个文件创建一个任务
                tasks = {}
                for local_path, remote_path in file_list:
                    if not os.path.exists(local_path):
                        log_error(f"文件不存在: {local_path}")
                        continue
                        
                    file_size = os.path.getsize(local_path)
                    file_name = os.path.basename(local_path)
                    
                    # 创建任务并存储开始时间和初始速度
                    task_id = progress.add_task(f"上传 {file_name}", total=file_size, speed="0 B/s")
                    tasks[local_path] = task_id
                    task_start_times[task_id] = time.time()
                    task_last_update[task_id] = time.time()
                    task_last_completed[task_id] = 0
                
                # 创建进度回调函数工厂
                def create_callback(task_id):
                    def callback(filename, size, sent):
                        current_time = time.time()
                        elapsed = current_time - task_last_update[task_id]
                        
                        # 计算传输速度（仅当经过了足够的时间才更新，避免频繁更新）
                        if elapsed > 0.5:  # 每0.5秒更新一次速度
                            bytes_since_last = sent - task_last_completed[task_id]
                            speed = bytes_since_last / elapsed
                            
                            # 格式化速度显示
                            speed_str = self.__format_speed(speed)
                            
                            # 更新进度条
                            progress.update(task_id, completed=sent, speed=speed_str)
                            
                            # 更新上次更新时间和完成字节数
                            task_last_update[task_id] = current_time
                            task_last_completed[task_id] = sent
                        else:
                            # 仅更新进度，不更新速度
                            progress.update(task_id, completed=sent)
                    
                    return callback
                
                # 使用线程池并行上传文件
                with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
                    futures = []
                    
                    for local_path, remote_path in file_list:
                        if local_path not in tasks:
                            continue
                            
                        # 创建一个 SCP 客户端，设置进度回调
                        transport = ssh.get_transport()
                        scp = SCPClient(transport, progress=create_callback(tasks[local_path]))
                        
                        # 提交上传任务到线程池
                        future = executor.submit(self._upload_file, scp, local_path, remote_path)
                        futures.append(future)
                    
                    # 等待所有上传任务完成
                    for future in concurrent.futures.as_completed(futures):
                        try:
                            future.result()
                        except Exception as e:
                            log_error(f"文件上传失败: {e}")
                            return False
            
            # 关闭 SSH 连接
            ssh.close()
            return True
            
        except Exception as e:
            log_error(f"多文件上传失败: {e}")
            return False
    
    def __format_speed(self, bytes_per_second: float) -> str:
        """格式化传输速度"""
        units = ['B/s', 'KB/s', 'MB/s', 'GB/s']
        unit_index = 0
        
        while bytes_per_second >= 1024 and unit_index < len(units) - 1:
            bytes_per_second /= 1024
            unit_index += 1
            
        return f"{bytes_per_second:.2f} {units[unit_index]}"


    def _upload_file(self, scp, local_path, remote_path):
        """辅助方法：上传单个文件"""
        try:
            scp.put(local_path, remote_path)
            return True
        except Exception as e:
            log_error(f"文件 {local_path} 上传失败: {e}")
            raise e
        finally:
            scp.close()


    def __put_with_rich(self, local_path: str, remote_path: str) -> bool:
        """
        使用 Rich 库显示文件上传进度
        
        参数:
            local_path: 本地文件路径
            remote_path: 远程文件路径
            
        返回:
            上传是否成功
        """
        if not self.__check_connection():
            return False
            
        try:
            # 获取文件大小
            file_size = os.path.getsize(local_path)
            file_name = os.path.basename(local_path)
            
            print(f"传输文件: {local_path} 到 {remote_path}")
            
            # 使用 Rich 显示进度条，自定义格式以显示速度和总用时
            # 使用自定义列显示传输速度和已用时间
            progress = Progress(
                TextColumn("[bold blue]{task.description}"),
                BarColumn(),
                "[progress.percentage]{task.percentage:>3.0f}%",
                "•",
                DownloadColumn(),
                "•",
                TextColumn("[bold green]{task.fields[speed]}"),
                "•",
                TimeElapsedColumn(),
            )
            
            with progress:
                # 创建任务并记录开始时间
                task = progress.add_task(f"上传 {file_name}", total=file_size, speed="0 B/s")
                last_update_time = time.time()
                last_completed = 0
                
                # 创建 SSHClient 实例
                ssh = paramiko.SSHClient()
                ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
                
                # 获取 SSH 连接参数
                server_ip = EnvUtils.get('SERVER_IP')
                server_user = EnvUtils.get('SERVER_USER')
                ssh_password = EnvUtils.get('SSH_PASSWORD')
                
                # 建立 SSH 连接
                ssh.connect(
                    hostname=server_ip,
                    username=server_user,
                    password=ssh_password,
                    timeout=30
                )
                
                # 自定义进度回调函数
                def progress_callback(filename, size, sent):
                    nonlocal last_update_time, last_completed
                    
                    current_time = time.time()
                    elapsed = current_time - last_update_time
                    
                    # 计算传输速度（仅当经过了足够的时间才更新，避免频繁更新）
                    if elapsed > 0.5:  # 每0.5秒更新一次速度
                        bytes_since_last = sent - last_completed
                        speed = bytes_since_last / elapsed
                        
                        # 格式化速度显示
                        speed_str = self.__format_speed(speed)
                        
                        # 更新进度条
                        progress.update(task, completed=sent, speed=speed_str)
                        
                        # 更新上次更新时间和完成字节数
                        last_update_time = current_time
                        last_completed = sent
                    else:
                        # 仅更新进度，不更新速度
                        progress.update(task, completed=sent)
                
                # 创建 SCP 客户端并设置进度回调
                with SCPClient(ssh.get_transport(), progress=progress_callback) as scp:
                    scp.put(local_path, remote_path)
                
                # 关闭 SSH 连接
                ssh.close()
                
                return True
                
        except Exception as e:
            log_error(f"文件传输失败: {e}")
            return False
 


    def __create_connection(self) -> Optional[Connection]:
        """创建 SSH 连接"""
        try:
            server_ip = EnvUtils.get('SERVER_IP')
            server_user = EnvUtils.get('SERVER_USER')
            ssh_password = EnvUtils.get('SSH_PASSWORD')

            if not all([server_ip, server_user, ssh_password]):
                log_error("缺少必要的连接信息")
                return None

            # 创建链接
            log_info(f"正在创建与服务器 {server_ip} 的链接...")
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
            return True
        except Exception:
            log_error("连接已断开，重新建立连接")
            return self.__create_connection() is not None





