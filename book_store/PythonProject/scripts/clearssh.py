"""
SSH 连接清理模块
"""
import os
import sys

from utils.log_utils import log_info
from utils.env_utils import load_env
from utils.ssh_utils import get_ssh_connection

def cleanup_ssh() -> None:
    """清理 SSH 连接"""
    log_info("开始清理SSH连接...")
    ssh = get_ssh_connection()
    ssh.cleanup()
    log_info("SSH连接清理完成")

def main() -> None:
    """主函数"""
    # 默认使用 prod 环境
    env = sys.argv[1] if len(sys.argv) > 1 else "prod"
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行清理
    cleanup_ssh()

if __name__ == "__main__":
    main() 