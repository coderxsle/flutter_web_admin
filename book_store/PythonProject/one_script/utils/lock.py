"""
部署锁模块，用于防止并发部署
"""
import os
import time
import fcntl
from pathlib import Path
from typing import Optional
from contextlib import contextmanager

from .log_utils import log_error, log_info, log_warn
from .config_manager import config_manager

class DeployLock:
    """部署锁"""
    def __init__(self, env: str) -> None:
        self.env = env
        self.lock_file = Path("/tmp") / f"deploy_{env}.lock"
        self.lock_fd: Optional[int] = None
        
    def acquire(self, timeout: int = 600) -> bool:
        """
        获取锁
        
        Args:
            timeout: 超时时间（秒）
            
        Returns:
            bool: 是否获取成功
        """
        start_time = time.time()
        
        while True:
            try:
                self.lock_fd = os.open(self.lock_file, os.O_RDWR | os.O_CREAT)
                fcntl.flock(self.lock_fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
                log_info(f"获取部署锁: {self.env}")
                return True
            except (IOError, OSError):
                if time.time() - start_time > timeout:
                    log_error(f"获取部署锁超时: {self.env}")
                    return False
                log_warn(f"部署锁被占用，等待中: {self.env}")
                time.sleep(5)
    
    def release(self) -> None:
        """释放锁"""
        if self.lock_fd is not None:
            fcntl.flock(self.lock_fd, fcntl.LOCK_UN)
            os.close(self.lock_fd)
            self.lock_fd = None
            try:
                os.unlink(self.lock_file)
            except OSError:
                pass
            log_info(f"释放部署锁: {self.env}")

@contextmanager
def deploy_lock(env: str) -> bool:
    """
    部署锁上下文管理器
    
    Args:
        env: 环境名称
        
    Returns:
        bool: 是否获取成功
    """
    if not config_manager.get('deploy.enable_lock', True):
        yield True
        return
        
    lock = DeployLock(env)
    timeout = config_manager.get('deploy.lock_timeout', 600)
    
    try:
        if lock.acquire(timeout):
            yield True
        else:
            yield False
    finally:
        lock.release() 