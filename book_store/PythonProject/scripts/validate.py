"""
部署验证模块，用于验证服务部署的状态和健康状况
"""
import os
import sys
import time
import requests
from typing import List, Optional
from urllib.parse import urlparse

from utils.log_utils import log_info, log_error, log_warn
from utils.env_utils import load_env
from utils.ssh_utils import ssh_execute

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python validate.py <环境> <版本>")
    log_info("示例: python validate.py prod 1.0.0")
    sys.exit(1)

def check_container_status(env: str) -> bool:
    """
    检查容器运行状态
    
    Args:
        env: 环境名称
        
    Returns:
        bool: 容器是否正常运行
    """
    log_info("检查容器运行状态...")
    
    cmd = "docker ps --format '{{.Names}} {{.Status}}' | grep book-store"
    result = ssh_execute(cmd)
    
    if not result:
        log_error("未找到运行中的服务容器")
        return False
    
    # 检查每个容器的状态
    containers = result.strip().split('\n')
    for container in containers:
        name, status = container.split(None, 1)
        if not status.startswith('Up'):
            log_error(f"容器 {name} 状态异常: {status}")
            return False
        log_info(f"容器 {name} 状态正常: {status}")
    
    return True

def check_service_health(service: str, timeout: int = 300) -> bool:
    """添加总体超时控制"""
    start_time = time.time()
    while time.time() - start_time < timeout:
        if _check_single_service(service):
            return True
        time.sleep(5)
    return False

def check_database_connection() -> bool:
    """
    检查数据库连接
    
    Returns:
        bool: 数据库是否可连接
    """
    log_info("检查数据库连接...")
    
    cmd = """
    docker exec book-store-postgres-1 \
    psql -U "${POSTGRES_USER}" -d "${POSTGRES_DB}" \
    -c "SELECT 1" > /dev/null 2>&1
    """
    
    if not ssh_execute(cmd):
        log_error("数据库连接失败")
        return False
    
    log_info("数据库连接正常")
    return True

def check_redis_connection() -> bool:
    """
    检查 Redis 连接
    
    Returns:
        bool: Redis 是否可连接
    """
    log_info("检查 Redis 连接...")
    
    cmd = """
    docker exec book-store-redis-1 \
    redis-cli -a "${REDIS_PASSWORD}" PING
    """
    
    result = ssh_execute(cmd)
    if not result or 'PONG' not in result:
        log_error("Redis 连接失败")
        return False
    
    log_info("Redis 连接正常")
    return True

def check_logs_for_errors(env: str) -> bool:
    """
    检查服务日志中的错误
    
    Args:
        env: 环境名称
        
    Returns:
        bool: 日志是否正常
    """
    log_info("检查服务日志...")
    
    services = ["apiServer", "nginx"]
    for service in services:
        cmd = f"docker compose logs --tail 100 {service} | grep -i 'error'"
        result = ssh_execute(cmd)
        
        if result:
            log_error(f"在 {service} 的日志中发现错误:")
            for line in result.split('\n'):
                log_error(f"  {line.strip()}")
            return False
    
    log_info("服务日志检查正常")
    return True

def _check_single_service(service: str) -> bool:
    """
    检查单个服务的健康状态
    
    Args:
        service: 服务名称
        
    Returns:
        bool: 服务是否健康
    """
    domain = os.getenv('DOMAIN', 'localhost')
    port = os.getenv('PORT', '80')
    health_endpoint = f"http://{domain}:{port}/health"
    
    try:
        response = requests.get(health_endpoint, timeout=5)
        if response.status_code == 200 and response.json().get('status') == 'ok':
            log_info(f"服务 {service} 健康检查通过")
            return True
    except requests.RequestException as e:
        log_warn(f"服务 {service} 健康检查失败: {e}")
    
    return False

def validate_deployment(env: str, version: str) -> bool:
    """
    验证部署状态
    
    Args:
        env: 环境名称
        version: 版本号
        
    Returns:
        bool: 验证是否通过
    """
    log_info(f"开始验证 {env} 环境的部署状态...")
    
    # 检查容器状态
    if not check_container_status(env):
        return False
    
    # 检查服务健康状态
    if not check_service_health("apiServer"):
        return False
    
    # 检查数据库连接
    if not check_database_connection():
        return False
    
    # 检查 Redis 连接
    if not check_redis_connection():
        return False
    
    # 检查日志
    if not check_logs_for_errors(env):
        log_warn("日志中发现错误，但不阻止验证通过")
    
    log_info(f"{env} 环境验证通过")
    return True

def main() -> None:
    """主函数"""
    if len(sys.argv) < 3:
        show_usage()
    
    env = sys.argv[1]
    version = sys.argv[2]
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行验证
    if not validate_deployment(env, version):
        sys.exit(1)
    
    log_info("验证完成")

if __name__ == "__main__":
    main() 