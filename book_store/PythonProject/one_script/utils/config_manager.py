"""
配置管理模块，用于处理 YAML 配置文件
"""
import os
import yaml
from pathlib import Path
from typing import Any, Dict, Optional

from .log_utils import log_error, log_info

class ConfigManager:
    """配置管理器"""
    _instance: Optional['ConfigManager'] = None
    _config: Dict[str, Any] = {}
    
    def __new__(cls) -> 'ConfigManager':
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance
    
    def __init__(self) -> None:
        self.load_config()
    
    def load_config(self, config_file: Optional[str] = None) -> bool:
        """
        加载配置文件
        
        Args:
            config_file: 配置文件路径，默认为 config.yaml
            
        Returns:
            bool: 是否加载成功
        """
        if not config_file:
            config_file = os.path.join(os.path.dirname(__file__), '../../config.yaml')
        
        try:
            with open(config_file, 'r') as f:
                self._config = yaml.safe_load(f)
            log_info(f"已加载配置文件: {config_file}")
            return True
        except Exception as e:
            log_error(f"加载配置文件失败: {e}")
            return False
    
    def get(self, key: str, default: Any = None) -> Any:
        """获取配置项"""
        return self._config.get(key, default)
    
    def set(self, key: str, value: Any) -> None:
        """设置配置项"""
        self._config[key] = value
    
    def save(self, config_file: Optional[str] = None) -> bool:
        """保存配置到文件"""
        if not config_file:
            config_file = os.path.join(os.path.dirname(__file__), '../../config.yaml')
        
        try:
            with open(config_file, 'w') as f:
                yaml.safe_dump(self._config, f)
            return True
        except Exception as e:
            log_error(f"保存配置文件失败: {e}")
            return False

# 全局配置实例
config_manager = ConfigManager() 