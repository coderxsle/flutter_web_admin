"""
数据库备份模块
"""
import os
import sys
from datetime import datetime
from pathlib import Path
from typing import Optional

from utils.log_utils import log_info, log_error
from utils.env_utils import load_env
from utils.ssh_utils import ssh_execute

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python backup.py <环境>")
    log_info("示例: python backup.py prod")
    sys.exit(1)

def backup_database(env: str) -> bool:
    """
    备份数据库
    
    Args:
        env: 环境名称（prod/test/staging）
    
    Returns:
        bool: 备份是否成功
    """
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_dir = os.getenv('BACKUP_DIR')
    
    if not backup_dir:
        log_error("未设置 BACKUP_DIR 环境变量")
        return False
    
    # 确保备份目录存在
    backup_path = Path(backup_dir) / env
    try:
        backup_path.mkdir(parents=True, exist_ok=True)
    except Exception as e:
        log_error(f"创建备份目录失败: {e}")
        return False
    
    backup_file = backup_path / f"db_{timestamp}.sql"
    
    # 获取数据库连接信息
    postgres_user = os.getenv('POSTGRES_USER')
    postgres_db = os.getenv('POSTGRES_DB')
    
    if not all([postgres_user, postgres_db]):
        log_error("缺少数据库连接信息")
        return False
    
    log_info("备份数据库...")
    
    # 执行数据库备份
    cmd = (f"docker exec {env}-postgres-1 pg_dump -U {postgres_user} "
           f"{postgres_db} > {backup_file}")
    
    if not ssh_execute(cmd):
        log_error("数据库备份失败")
        return False
    
    # 检查是否需要压缩
    if os.getenv('DB_BACKUP_COMPRESS', '').lower() == 'true':
        compress_cmd = f"gzip {backup_file}"
        if not ssh_execute(compress_cmd):
            log_error("压缩备份文件失败")
            return False
        log_info(f"数据库备份已压缩: {backup_file}.gz")
    else:
        log_info(f"数据库备份成功: {backup_file}")
    
    return True

def main() -> None:
    """主函数"""
    if len(sys.argv) < 2:
        show_usage()
    
    env = sys.argv[1]
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行备份
    if not backup_database(env):
        sys.exit(1)
    
    log_info("备份完成")

if __name__ == "__main__":
    main() 