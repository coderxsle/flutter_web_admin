"""
配置文件，用于存储全局变量和常量
"""
import os
import pathlib

# 日志级别
LOG_LEVEL_DEBUG = 0
LOG_LEVEL_INFO = 1
LOG_LEVEL_WARN = 2
LOG_LEVEL_ERROR = 3

# 默认日志级别
CURRENT_LOG_LEVEL = LOG_LEVEL_INFO

# 项目根目录
SCRIPT_DIR = pathlib.Path(__file__).parent.parent
PROJECT_ROOT = SCRIPT_DIR.parent.parent

# SSH 相关配置
SSH_STATUS_DIR = "/tmp/book_store_ssh"
SSH_STATUS_FILE = os.path.join(SSH_STATUS_DIR, f"ssh_status_{os.getenv('USER', os.getlogin())}") 