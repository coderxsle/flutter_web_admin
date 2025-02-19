"""
SSH 工具模块，用于处理远程服务器的 SSH 连接和操作
"""
import os
import subprocess
from pathlib import Path
from typing import Optional, Dict, Any
from . import config
from .log_utils import log_info, log_error, log_debug, log_warn
from tqdm import tqdm
import paramiko
from scp import SCPClient

class SSHConnection:
    """SSH 连接管理类"""
    _instance: Optional['SSHConnection'] = None
    _ssh_options: Dict[str, Any] = {}
    
    def __new__(cls) -> 'SSHConnection':
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __init__(self) -> None:
        # 确保 SSH 状态目录存在
        os.makedirs(config.SSH_STATUS_DIR, mode=0o700, exist_ok=True)
        self.load_ssh_options()
    
    def load_ssh_options(self) -> None:
        """加载 SSH 选项"""
        if os.path.exists(config.SSH_STATUS_FILE):
            with open(config.SSH_STATUS_FILE, 'r') as f:
                options = f.read().strip()
                if options:
                    self._ssh_options['options'] = options
                    log_info("已加载现有 SSH 连接配置")
    
    def save_ssh_options(self) -> None:
        """保存 SSH 选项"""
        if self._ssh_options.get('options'):
            with open(config.SSH_STATUS_FILE, 'w') as f:
                f.write(self._ssh_options['options'])
    
    def cleanup(self) -> None:
        """清理 SSH 连接"""
        if os.path.exists(config.SSH_STATUS_FILE):
            os.remove(config.SSH_STATUS_FILE)
        self._ssh_options.clear()
        
        # 清理控制连接
        server_user = os.getenv('SERVER_USER', '')
        server_ip = os.getenv('SERVER_IP', '')
        if server_user and server_ip:
            subprocess.run(
                ['ssh', '-O', 'exit', '-o', f'ControlPath=/tmp/ssh-%r@%h:%p', 
                 f'{server_user}@{server_ip}'],
                stderr=subprocess.DEVNULL
            )
    
    def _clean_host_key(self, host: str) -> None:
        """清理指定主机的 known_hosts 记录"""
        known_hosts = Path.home() / '.ssh' / 'known_hosts'
        if known_hosts.exists():
            subprocess.run(['ssh-keygen', '-R', host], 
                         stdout=subprocess.DEVNULL, 
                         stderr=subprocess.DEVNULL)
    
    def setup_connection(self) -> bool:
        """设置 SSH 连接"""
        server_ip = os.getenv('SERVER_IP')
        server_user = os.getenv('SERVER_USER')
        server_port = os.getenv('SERVER_PORT')
        ssh_key_path = os.getenv('SSH_KEY_PATH')
        
        if not all([server_ip, server_user, server_port]):
            log_error("缺少必要的 SSH 连接信息")
            return False
        
        log_info(f"开始设置SSH连接，服务器IP: {server_ip}, "
                f"用户: {server_user}, 端口: {server_port}")
        
        # 清理主机密钥
        self._clean_host_key(server_ip)
        
        # 基本 SSH 选项
        base_options = [
            "ControlMaster=auto",
            "ControlPath=/tmp/ssh-%r@%h:%p",
            "ControlPersist=10m",
            "StrictHostKeyChecking=no",
            "UserKnownHostsFile=/dev/null",
            "ServerAliveInterval=60"
        ]
        
        # 尝试使用密钥连接
        if ssh_key_path and os.path.exists(ssh_key_path):
            if self._try_key_connection(base_options, ssh_key_path):
                return True
        
        # 尝试使用密码连接
        return self._try_password_connection(base_options)
    
    def _try_key_connection(self, base_options: list, ssh_key_path: str) -> bool:
        """尝试使用密钥连接"""
        log_info("正在使用SSH密钥进行连接...")
        options = ' '.join(f'-o {opt}' for opt in base_options)
        cmd = (f'ssh -i {ssh_key_path} {options} '
               f'{os.getenv("SERVER_USER")}@{os.getenv("SERVER_IP")} echo "测试连接"')
        
        try:
            subprocess.run(cmd, shell=True, check=True, capture_output=True)
            self._ssh_options['options'] = f'{options} -i {ssh_key_path}'
            self.save_ssh_options()
            log_info("SSH密钥连接成功")
            return True
        except subprocess.CalledProcessError:
            log_warn("SSH密钥连接失败，将尝试密码连接")
            return False
    
    def _try_password_connection(self, base_options: list) -> bool:
        """尝试使用密码连接"""
        log_info("尝试使用密码连接...")
        options = ' '.join(f'-o {opt}' for opt in base_options)
        cmd = (f'ssh {options} '
               f'{os.getenv("SERVER_USER")}@{os.getenv("SERVER_IP")} echo "测试连接"')
        
        try:
            subprocess.run(cmd, shell=True, check=True, capture_output=True)
            self._ssh_options['options'] = options
            self.save_ssh_options()
            log_info("SSH密码连接成功")
            return True
        except subprocess.CalledProcessError:
            log_error("SSH连接失败！请检查连接信息和密码")
            return False

class SSHConnectionPool:
    """SSH 连接池"""
    _pool: Dict[str, SSHConnection] = {}
    
    @classmethod
    def get_connection(cls, host: str) -> SSHConnection:
        if host not in cls._pool:
            cls._pool[host] = SSHConnection()
        return cls._pool[host]
    
    @classmethod
    def cleanup_all(cls) -> None:
        """清理所有连接"""
        for conn in cls._pool.values():
            conn.cleanup()
        cls._pool.clear()

def get_ssh_connection() -> SSHConnection:
    """获取 SSH 连接实例"""
    return SSHConnection()

def ssh_execute(command: str) -> Optional[str]:
    """执行远程 SSH 命令"""
    ssh = get_ssh_connection()
    
    if not ssh._ssh_options.get('options'):
        if not ssh.setup_connection():
            return None
    
    try:
        options = ssh._ssh_options['options']
        cmd = (f'ssh {options} '
               f'{os.getenv("SERVER_USER")}@{os.getenv("SERVER_IP")} "{command}"')
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        log_error(f"执行命令失败: {e.stderr}")
        return None

def scp_transfer(src: str, dest: str) -> bool:
    """使用 SCP 传输文件，带进度条"""
    ssh = get_ssh_connection()
    
    if not ssh._ssh_options.get('options'):
        if not ssh.setup_connection():
            return False
    
    try:
        file_size = os.path.getsize(src)
        with tqdm(total=file_size, 
                 unit='B', 
                 unit_scale=True, 
                 desc=f"Transferring {os.path.basename(src)}") as pbar:
            
            def progress_callback(transferred: int, _: int) -> None:
                pbar.update(transferred - pbar.n)
            
            options = ssh._ssh_options['options']
            client = paramiko.SSHClient()
            client.load_system_host_keys()
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            
            # 使用 paramiko 的 SCP 实现，支持进度回调
            with client.connect(
                hostname=os.getenv('SERVER_IP'),
                username=os.getenv('SERVER_USER'),
                port=int(os.getenv('SERVER_PORT', 22))
            ):
                scp = SCPClient(client.get_transport(), progress=progress_callback)
                scp.put(src, dest)
                
        return True
    except Exception as e:
        log_error(f"文件传输失败: {e}")
        return False

"""通知模块，用于发送部署通知"""
import requests

def send_notification(
    env: str,
    version: str,
    status: str,
    message: Optional[str] = None
) -> bool:
    """发送部署通知"""
    notification_url = os.getenv('NOTIFICATION_URL')
    if not notification_url:
        return True
        
    try:
        data = {
            "env": env,
            "version": version,
            "status": status,
            "message": message or f"{env} 环境 {version} 版本部署{status}"
        }
        
        response = requests.post(notification_url, json=data)
        return response.status_code == 200
    except Exception as e:
        log_error(f"发送通知失败: {e}")
        return False 