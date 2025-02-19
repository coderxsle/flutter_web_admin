"""
服务部署模块
"""
import os
import sys
import time
from pathlib import Path
from typing import List, Optional

from utils.log_utils import log_info, log_error, log_warn
from utils.env_utils import load_env
from utils.ssh_utils import ssh_execute, scp_transfer
from utils.system_utils import verify_docker_service, verify_docker_hub_connection
from utils.config import PROJECT_ROOT

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python deploy.py <环境> <版本>")
    log_info("示例: python deploy.py prod 1.0.0")
    sys.exit(1)

def handle_image_upload_option() -> bool:
    """处理镜像上传选项"""
    log_info("是否需要上传镜像到服务器？(y/n，10秒后默认上传)")
    try:
        answer = input()
        if answer.lower() == 'n':
            log_info("已选择不上传镜像")
            return False
    except TimeoutError:
        log_info("未收到输入，将执行默认操作：上传镜像")
    return True

def create_deploy_dir() -> bool:
    """创建部署目录"""
    deploy_path = os.getenv('DEPLOY_PATH')
    server_user = os.getenv('SERVER_USER')
    
    if not all([deploy_path, server_user]):
        log_error("缺少必要的部署配置")
        return False
    
    log_info("确保部署目录存在...")
    cmd = f"sudo mkdir -p {deploy_path} && sudo chown -R {server_user}:{server_user} {deploy_path}"
    
    if not ssh_execute(cmd):
        log_error("创建部署目录失败")
        return False
        
    log_info(f"部署目录已就绪: {deploy_path}")
    return True

def upload_config_files(env: str) -> bool:
    """上传配置文件"""
    if not create_deploy_dir():
        return False
    
    project_root = os.getenv('PROJECT_ROOT', '')
    deploy_path = os.getenv('DEPLOY_PATH', '')
    server_user = os.getenv('SERVER_USER', '')
    server_ip = os.getenv('SERVER_IP', '')
    
    if not all([project_root, deploy_path, server_user, server_ip]):
        log_error("缺少必要的配置信息")
        return False
    
    log_info("上传配置文件到云端服务器...")
    
    # 上传配置文件
    config_files = ["docker-compose.yaml", "nginx.conf"]
    for config_file in config_files:
        src_path = Path(project_root) / "deploy" / env / config_file
        dest_path = f"{server_user}@{server_ip}:{deploy_path}/"
        
        log_info(f"上传配置文件 {config_file}...")
        if not scp_transfer(str(src_path), dest_path):
            log_error(f"配置文件 {config_file} 上传失败")
            return False
    
    # 上传环境变量文件
    env_file = f".env.{env}"
    src_path = Path(project_root) / "env" / env_file
    dest_path = f"{server_user}@{server_ip}:{deploy_path}/{env_file}"
    
    log_info("上传环境变量文件...")
    if not scp_transfer(str(src_path), dest_path):
        log_error("环境变量文件上传失败")
        return False
    
    return True

def handle_docker_image(env: str, version: str, image_name: str) -> bool:
    """处理 Docker 镜像上传"""
    deploy_path = os.getenv('DEPLOY_PATH', '')
    server_user = os.getenv('SERVER_USER', '')
    server_ip = os.getenv('SERVER_IP', '')
    
    if not all([deploy_path, server_user, server_ip]):
        log_error("缺少必要的配置信息")
        return False
    
    image_tar = f"{image_name}-{env}-{version}.tar"
    log_info("上传 Docker 镜像到云端服务器...")
    
    dest_path = f"{server_user}@{server_ip}:{deploy_path}/"
    if not scp_transfer(image_tar, dest_path):
        log_error("镜像文件上传失败")
        return False
    
    # 处理镜像文件清理
    log_info("是否需要删除镜像文件？(y/n，10秒后默认保留)")
    try:
        answer = input()
        if answer.lower() == 'y':
            log_info("删除服务器上的镜像文件...")
            if not ssh_execute(f"rm -f {deploy_path}/{image_tar}"):
                log_warn("删除镜像文件失败，但不影响部署过程")
        else:
            log_info(f"保留镜像文件: {deploy_path}/{image_tar}")
    except TimeoutError:
        log_info(f"等待超时，默认保留镜像文件: {deploy_path}/{image_tar}")
    
    return True

def stop_and_cleanup_containers() -> bool:
    """停止并清理容器"""
    log_info("停止并删除旧容器...")
    
    # 停止相关容器
    cmd = """
    cd ${DEPLOY_PATH} && \
    containers=$(docker ps -q --filter 'name=book_store') && \
    if [ ! -z "$containers" ]; then \
        docker stop --time 10 $containers || docker kill $containers; \
    fi
    """
    
    if not ssh_execute(cmd):
        log_warn("停止容器过程中出现警告，但将继续执行...")
    
    # 等待容器完全停止
    for i in range(10):
        if not ssh_execute("docker ps -q --filter 'name=book_store_server'"):
            log_info("所有相关容器已停止!")
            break
        if i == 9:
            log_warn("等待容器停止超时，将强制继续...")
        time.sleep(1)
    
    # 清理停止的容器和未使用的镜像
    ssh_execute("docker container prune -f")
    ssh_execute("docker images 'book_store*' -q | xargs -r docker rmi -f")
    
    return True

def start_containers(env: str, version: str, image_name: str) -> bool:
    """启动容器"""
    log_info("启动新容器...")
    
    cmd = f"""
    cd ${{DEPLOY_PATH}} && \
    export IMAGE_NAME={image_name}:{version} VERSION={version} && \
    docker compose up -d
    """
    
    if not ssh_execute(cmd):
        log_error("服务部署失败")
        return False
    
    return verify_deployment(env)

def verify_deployment(env: str) -> bool:
    """验证部署结果"""
    log_info("验证部署结果...")
    
    # 等待容器启动
    time.sleep(5)
    
    # 检查容器状态
    services = ["apiServer", "postgres", "redis", "nginx"]
    for service in services:
        log_info(f"检查 {service} 服务状态...")
        cmd = f"docker compose ps {service} | grep -q 'running'"
        if not ssh_execute(cmd):
            log_error(f"{service} 服务未正常运行")
            # 获取服务日志
            ssh_execute(f"docker compose logs {service}")
            return False
    
    log_info("部署验证成功！")
    return True

def deploy_to_server(env: str, version: str) -> bool:
    """部署到服务器"""
    image_name = os.getenv('IMAGE_NAME', '')
    if not image_name:
        log_error("未设置 IMAGE_NAME 环境变量")
        return False
    
    # 处理镜像上传选项
    should_upload = handle_image_upload_option()
    
    # 上传配置文件
    if not upload_config_files(env):
        return False
    
    # 处理镜像上传
    if should_upload:
        if not handle_docker_image(env, version, image_name):
            return False
    
    # 停止并清理旧容器
    if not stop_and_cleanup_containers():
        return False
    
    # 启动新容器
    if not start_containers(env, version, image_name):
        return False
    
    log_info("服务部署成功")
    return True

def setup_docker_daemon() -> bool:
    """配置 Docker 守护进程"""
    log_info("配置 Docker 守护进程...")
    
    # 创建配置目录
    if not ssh_execute("sudo mkdir -p /etc/docker"):
        return False
        
    # 上传配置文件
    if not scp_transfer(
        f"{PROJECT_ROOT}/daemon.json",
        "/etc/docker/daemon.json"
    ):
        return False
        
    # 重启 Docker 服务
    return restart_docker_service()

def restart_docker_service() -> bool:
    """重启 Docker 服务"""
    return all([
        ssh_execute("sudo systemctl daemon-reload"),
        ssh_execute("sudo systemctl restart docker")
    ])

def main() -> None:
    """主函数"""
    if len(sys.argv) < 3:
        show_usage()
    
    env = sys.argv[1]
    version = sys.argv[2]
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行部署
    if not deploy_to_server(env, version):
        sys.exit(1)

if __name__ == "__main__":
    main() 