"""
回滚模块，用于在部署出现问题时回滚到之前的稳定版本
"""
import os
import sys
import time
from pathlib import Path
from typing import Optional, Tuple

from utils.log_utils import log_info, log_error, log_warn
from utils.env_utils import load_env
from utils.ssh_utils import ssh_execute
from validate import validate_deployment

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python rollback.py <环境> <版本>")
    log_info("示例: python rollback.py prod 1.0.0")
    sys.exit(1)

def backup_current_config() -> bool:
    """
    备份当前配置文件
    
    Returns:
        bool: 备份是否成功
    """
    deploy_path = os.getenv('DEPLOY_PATH')
    if not deploy_path:
        log_error("未设置 DEPLOY_PATH 环境变量")
        return False
    
    log_info("备份当前配置文件...")
    
    files_to_backup = [
        "docker-compose.yaml",
        "nginx.conf",
        ".env.*"
    ]
    
    for file_pattern in files_to_backup:
        cmd = f"cd {deploy_path} && cp -f {file_pattern} {file_pattern}.bak 2>/dev/null || true"
        if not ssh_execute(cmd):
            log_warn(f"备份 {file_pattern} 失败，可能文件不存在")
    
    return True

def get_previous_version() -> Optional[str]:
    """
    获取上一个版本号
    
    Returns:
        Optional[str]: 上一个版本号，如果没有则返回 None
    """
    image_name = os.getenv('IMAGE_NAME', '')
    if not image_name:
        log_error("未设置 IMAGE_NAME 环境变量")
        return None
    
    cmd = f"""
    docker images '{image_name}' --format "{{{{.Tag}}}}" | sort -V | grep -v latest | tail -n 2 | head -n 1
    """
    
    version = ssh_execute(cmd)
    if not version:
        log_error("未找到可回滚的版本")
        return None
    
    return version.strip()

def stop_current_services() -> bool:
    """
    停止当前运行的服务
    
    Returns:
        bool: 停止操作是否成功
    """
    log_info("停止当前运行的服务...")
    deploy_path = os.getenv('DEPLOY_PATH')
    
    if not deploy_path:
        log_error("未设置 DEPLOY_PATH 环境变量")
        return False
    
    cmd = f"cd {deploy_path} && docker compose down"
    if not ssh_execute(cmd):
        log_error("停止服务失败")
        return False
    
    # 等待服务完全停止
    time.sleep(5)
    return True

def restore_backup_config() -> bool:
    """
    恢复备份的配置文件
    
    Returns:
        bool: 恢复操作是否成功
    """
    deploy_path = os.getenv('DEPLOY_PATH')
    if not deploy_path:
        log_error("未设置 DEPLOY_PATH 环境变量")
        return False
    
    log_info("恢复备份的配置文件...")
    
    files_to_restore = [
        "docker-compose.yaml",
        "nginx.conf",
        ".env.*"
    ]
    
    for file_pattern in files_to_restore:
        cmd = f"cd {deploy_path} && mv -f {file_pattern}.bak {file_pattern} 2>/dev/null || true"
        if not ssh_execute(cmd):
            log_warn(f"恢复 {file_pattern} 失败，可能备份文件不存在")
    
    return True

def start_previous_version(version: str) -> bool:
    """
    启动指定版本的服务
    
    Args:
        version: 要启动的版本号
        
    Returns:
        bool: 启动操作是否成功
    """
    deploy_path = os.getenv('DEPLOY_PATH')
    image_name = os.getenv('IMAGE_NAME')
    
    if not all([deploy_path, image_name]):
        log_error("缺少必要的环境变量")
        return False
    
    log_info(f"启动版本 {version} 的服务...")
    
    cmd = f"""
    cd {deploy_path} && \
    export IMAGE_NAME={image_name}:{version} VERSION={version} && \
    docker compose up -d
    """
    
    if not ssh_execute(cmd):
        log_error("启动服务失败")
        return False
    
    return True

def rollback_deployment(env: str, target_version: Optional[str] = None) -> bool:
    """
    执行回滚操作
    
    Args:
        env: 环境名称
        target_version: 目标版本号，如果不指定则回滚到上一个版本
        
    Returns:
        bool: 回滚是否成功
    """
    log_info(f"开始回滚 {env} 环境的部署...")
    
    # 备份当前配置
    if not backup_current_config():
        log_error("备份配置失败")
        return False
    
    # 确定回滚版本
    version = target_version or get_previous_version()
    if not version:
        log_error("无法确定回滚版本")
        return False
    
    log_info(f"准备回滚到版本: {version}")
    
    # 停止当前服务
    if not stop_current_services():
        log_error("停止当前服务失败")
        return False
    
    # 启动旧版本
    if not start_previous_version(version):
        log_error("启动旧版本失败")
        # 尝试恢复当前配置
        restore_backup_config()
        return False
    
    # 验证回滚后的部署
    if not validate_deployment(env, version):
        log_error("回滚后的部署验证失败")
        # 尝试恢复当前配置
        restore_backup_config()
        return False
    
    log_info(f"成功回滚到版本 {version}")
    return True

def main() -> None:
    """主函数"""
    if len(sys.argv) < 2:
        show_usage()
    
    env = sys.argv[1]
    target_version = sys.argv[2] if len(sys.argv) > 2 else None
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行回滚
    if not rollback_deployment(env, target_version):
        sys.exit(1)
    
    log_info("回滚完成")

if __name__ == "__main__":
    main() 