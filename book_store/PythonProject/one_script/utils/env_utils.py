"""
环境变量工具模块
"""
import os
from typing import Optional
from pathlib import Path
from . import config
from .log_utils import log_info, log_error, log_debug, log_warn

def get_env_file_name(env: str) -> Optional[str]:
    """获取环境变量文件名"""
    env = str(env)  # 确保是字符串
    env_map = {
        "1": ".env.production",
        "2": ".env.test",
        "3": ".env.development"
    }
    
    if env not in env_map:
        log_error(f"未 知 的 环 境: {env}")
        return None
    return env_map[env]

def load_env(env: str) -> bool:
    """加载环境变量"""
    log_info("正在验证环境变量...")
    
    env_file_name = get_env_file_name(env)
    if not env_file_name:
        return False
    
    # 修改环境变量文件路径，指向 book_store_server/env 目录
    server_env_path = Path(config.PROJECT_ROOT).parent / "book_store_server" / "env" / env_file_name
    
    log_debug(f"脚本目录: {config.SCRIPT_DIR}")
    log_debug(f"项目根目录: {config.PROJECT_ROOT}")
    log_debug(f"环境文件路径: {server_env_path}")
    
    if not server_env_path.exists():
        log_error(f"环境变量文件不存在: {server_env_path}")
        return False
    
    # 读取并设置环境变量
    with open(server_env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):
                key, value = line.split('=', 1)
                os.environ[key.strip()] = value.strip()
    
    return validate_env_vars()

def validate_env_vars() -> bool:
    """验证环境变量"""
    required_vars = [
        "POSTGRES_DB",
        "POSTGRES_USER",
        "POSTGRES_PASSWORD",
        "REDIS_PASSWORD",
        "SERVICE_SECRET",
        "HUAWEI_REGISTRY_USERNAME",
        "HUAWEI_REGISTRY_PASSWORD",
        "SERVER_IP",
        "SERVER_USER",
        "SERVER_PORT",
        "DEPLOY_PATH"
    ]
    
    missing_vars = []
    for var in required_vars:
        if not os.getenv(var):
            missing_vars.append(var)
    
    if missing_vars:
        log_error("缺少以下必需的环境变量:")
        for var in missing_vars:
            log_error(f"  - {var}")
        return False
    
    log_info("环境变量验证通过")
    return True 