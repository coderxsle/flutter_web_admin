#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from pathlib import Path
from typing import Optional
from dotenv import load_dotenv

from .log_utils import log_info, log_error

def load_env(env: str) -> bool:
    """
    加载环境变量
    
    Args:
        env: 环境名称
        
    Returns:
        bool: 是否加载成功
    """
    env_file = Path(f".env.{env}")
    
    if not env_file.exists():
        log_error(f"环境配置文件不存在: {env_file}")
        return False
        
    # 加载环境变量
    load_dotenv(env_file)
    
    # 验证必要的环境变量
    required_vars = [
        'DEPLOY_ENV',
        'DEPLOY_VERSION',
        'SERVER_USER',
        'SERVER_IP',
        'DEPLOY_PATH'
    ]
    
    for var in required_vars:
        if not os.getenv(var):
            log_error(f"缺少必要的环境变量: {var}")
            return False
            
    log_info(f"已加载 {env} 环境配置")
    return True

def get_env(key: str, default: Optional[str] = None) -> Optional[str]:
    """
    获取环境变量
    
    Args:
        key: 环境变量名
        default: 默认值
        
    Returns:
        str: 环境变量值
    """
    return os.getenv(key, default) 