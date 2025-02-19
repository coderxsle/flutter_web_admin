"""
日志工具模块
"""
from typing import Optional
from . import config

def set_log_level(level: str) -> None:
    """设置日志级别"""
    level_map = {
        "DEBUG": config.LOG_LEVEL_DEBUG,
        "INFO": config.LOG_LEVEL_INFO,
        "WARN": config.LOG_LEVEL_WARN,
        "ERROR": config.LOG_LEVEL_ERROR
    }
    config.CURRENT_LOG_LEVEL = level_map.get(level, config.LOG_LEVEL_INFO)

def log_debug(message: str) -> None:
    """输出调试日志"""
    if config.CURRENT_LOG_LEVEL <= config.LOG_LEVEL_DEBUG:
        print(f"\033[36m[DEBUG] {message}\033[0m")

def log_info(message: str) -> None:
    """输出信息日志"""
    if config.CURRENT_LOG_LEVEL <= config.LOG_LEVEL_INFO:
        print(f"\033[32m[INFO] {message}\033[0m")

def log_warn(message: str) -> None:
    """输出警告日志"""
    if config.CURRENT_LOG_LEVEL <= config.LOG_LEVEL_WARN:
        print(f"\033[33m[WARN] {message}\033[0m")

def log_error(message: str) -> None:
    """输出错误日志"""
    if config.CURRENT_LOG_LEVEL <= config.LOG_LEVEL_ERROR:
        print(f"\033[31m[ERROR] {message}\033[0m") 