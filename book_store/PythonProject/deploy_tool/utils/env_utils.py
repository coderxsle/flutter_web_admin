#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
from pathlib import Path
from typing import Optional
from dotenv import load_dotenv

from .log_utils import log_info, log_error

class EnvUtils:

    @staticmethod
    def load_env(env: str) -> bool:
        """
        加载环境变量
        
        Args:
            env: 环境名称
            
        Returns:
            bool: 是否加载成功
        """
        try:
            # 获取当前工作目录
            current_dir = Path.cwd()
            # 构建环境文件的路径（向上一级后进入 env 目录）
            env_file = current_dir.parent / "env" / f".env.{env}"
            
            if not env_file.exists():
                log_error(f"环境配置文件不存在: {env_file}")
                return False
                
            log_info(f"正在加载环境配置: {env_file}")
            
            # 加载环境变量
            load_dotenv(env_file)
            
            # 验证必要的环境变量
            required_vars = ['SERVER_IP', 'SERVER_USER', 'DEPLOY_PATH', 'VERSION']
            
            missing_vars = []
            for var in required_vars:
                if not os.getenv(var):
                    missing_vars.append(var)
            
            if missing_vars:
                log_error(f"以下环境变量未设置: {', '.join(missing_vars)}")
                return False
                
            # 输出已加载的环境信息
            log_info(f"部署路径: {os.getenv('SERVER_IP')}/{os.getenv('DEPLOY_PATH')}")
            log_info(f"环境: {env}")
            log_info(f"版本: {os.getenv('VERSION')}")
            return True
            
        except Exception as e:
            log_error(f"加载环境变量时出错: {str(e)}")
            return False

    @staticmethod
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