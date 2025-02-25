#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker服务部署服务
负责将Docker镜像部署到远程服务器，包括配置文件上传、容器管理等功能。
"""

import os
import sys
import time
import datetime
import json
import select
import subprocess
from pathlib import Path
from typing import List, Optional, Tuple, Dict, Any, Union, Callable

# 导入必要的工具模块
from deploy_tool.utils import (
    log_info,
    log_warn,
    log_error,
)
from deploy_tool.utils.ssh_client import SSHClient, EnvUtils

# 设置脚本所在目录
SCRIPT_DIR = Path(__file__).parent.absolute()


class DeployService:
    """Docker服务部署类"""
    
    @staticmethod
    def deploy() -> bool:
        """
        部署Docker服务到远程服务器
        
        Args:
            env: 环境名称
            version: 版本号，如果为None则从环境变量获取
            image_name: 镜像名称，如果为None则从环境变量获取
            
        Returns:
            bool: 部署是否成功
        """



        # 如果未提供版本和镜像名，则使用环境变量中的值
        version = EnvUtils.get_env('VERSION')
        image_name = EnvUtils.get_env('IMAGE_NAME')
        env = EnvUtils.get_env('ENV', "prod")

        
        ssh_client = SSHClient()
        deploy_service = DeployService(ssh_client)
        
        should_upload_image = deploy_service._handle_image_upload_option()
        
        if not deploy_service._upload_config_files(env):
            return False
        
        if should_upload_image == 0:
            if not deploy_service._handle_docker_image(env, version, image_name):
                return False
        else:
            log_info("跳过镜像上传步骤")
        
        if not deploy_service._setup_docker_environment():
            return False
        
        if not deploy_service._deploy_service(env, version, image_name):
            return False
        
        log_info("服务部署成功")
        return True
    
    def __init__(self, ssh_client: SSHClient):
        """初始化部署服务"""
        self.ssh_client = ssh_client
    


    def _handle_image_upload_option(self) -> int:
        """处理镜像上传选项"""
        log_info("是否需要上传镜像到服务器？(y/n，10秒后默认上传)")
        
        # 实现带超时的输入
        i, o, e = select.select([sys.stdin], [], [], 10)
        if not i:
            log_info("未收到输入，将执行默认操作：上传镜像")
            return 0
        
        answer = sys.stdin.readline().strip().lower()
        if answer in ['n', 'no']:
            log_info("已选择不上传镜像")
            return 1
        else:
            log_info("已选择上传镜像")
            return 0
    


    def _create_deploy_dir(self) -> bool:
        """创建部署目录"""
        log_info("确保部署目录存在...")
        
        # 从环境变量获取部署路径和服务器用户
        deploy_path = os.environ.get('DEPLOY_PATH')
        server_user = os.environ.get('SERVER_USER')
        
        if not self.ssh_client.run(f"sudo mkdir -p {deploy_path} && sudo chown -R {server_user}:{server_user} {deploy_path}"):
            log_error("创建部署目录失败")
            return False
        
        log_info(f"部署目录已就绪: {deploy_path}")
        return True
    
    def _upload_config_files(self, env: str) -> bool:
        """上传配置文件"""
        # 先确保部署目录存在
        if not self._create_deploy_dir():
            return False
        
        # 从环境变量获取项目根目录、部署路径和服务器信息
        project_root = os.environ.get('PROJECT_ROOT')
        deploy_path = os.environ.get('DEPLOY_PATH')
        
        log_info("上传配置文件到云端服务器...")
        for config_file in ["docker-compose.yaml", "nginx.conf"]:
            log_info(f"上传配置文件 {config_file}...")
            local_path = f"{project_root}/deploy/{env}/{config_file}"
            remote_path = f"{deploy_path}/"
            
            if not self.ssh_client.put(local_path, remote_path):
                log_error(f"配置文件 {config_file} 上传失败")
                return False
        
        # 上传环境变量文件
        log_info("上传环境变量文件到云端服务器...")
        env_file_name = EnvUtils.get_env_file_name(env)
        if not env_file_name:
            return False
        
        if not self.ssh_client.put(
            f"{project_root}/env/{env_file_name}",
            f"{deploy_path}/{env_file_name}"
        ):
            log_error("环境变量文件上传失败")
            return False
        
        return True
    
    def _handle_image_cleanup(self, image_path: str) -> None:
        """处理镜像文件清理"""
        log_info("是否需要删除镜像文件？(y/n，10秒后默认保留)")
        
        # 实现带超时的输入
        i, o, e = select.select([sys.stdin], [], [], 10)
        if not i:
            log_info(f"等待超时，默认保留镜像文件: {image_path}")
            return
        
        delete_tar = sys.stdin.readline().strip().lower()
        if delete_tar in ['y', 'yes']:
            log_info("删除服务器上的镜像文件...")
            if not self.ssh_client.run(f"rm -f {image_path}"):
                log_warn("删除镜像文件失败，但不影响部署过程")
        else:
            log_info(f"保留镜像文件: {image_path}")
    
    def _handle_docker_image(self, env: str, version: str, image_name: str) -> bool:
        """上传并处理Docker镜像"""
        # 从环境变量获取部署路径和服务器信息
        deploy_path = EnvUtils.get_env('DEPLOY_PATH')
        server_user = EnvUtils.get_env('SERVER_USER')
        server_ip = EnvUtils.get_env('SERVER_IP')
        
        image_tar = f"{image_name}-{env}-{version}.tar"
        log_info("上传 Docker 镜像到云端服务器...")
        log_info(f"本地镜像文件路径: {os.getcwd()}/{image_tar}")
        log_info(f"目标服务器路径: {server_user}@{server_ip}:{deploy_path}/")
        
        if not self.ssh_client.put(image_tar, f"{deploy_path}/"):
            log_error("镜像文件上传失败")
            return False
        
        self._handle_image_cleanup(f"{deploy_path}/{image_tar}")
        return True
    
    def _setup_docker_environment(self) -> bool:
        """配置Docker环境"""
        log_info("检查 Docker 配置文件...")    
        if not self.ssh_client.run("test -f /etc/docker/daemon.json", hide=True):
            return self._configure_docker_daemon()
        
        return self._verify_docker_service() and self._verify_docker_hub_connection()
    
    def _configure_docker_daemon(self) -> bool:
        """配置Docker守护进程"""
        # 从环境变量获取服务器信息
        server_user = os.environ.get('SERVER_USER')
        server_ip = os.environ.get('SERVER_IP')
        
        log_info("Docker 配置文件不存在，准备上传配置文件...")
        if not self.ssh_client.run(f"sudo mkdir -p /etc/docker && sudo chown {server_user}: /etc/docker"):
            log_error("创建Docker配置目录或设置权限失败")
            return False
        
        if not self.ssh_client.put(f"{SCRIPT_DIR}/../daemon.json", "/etc/docker/daemon.json"):
            log_error("Docker配置文件上传失败")
            return False
        
        return self._restart_docker_service()
    
    def _restart_docker_service(self) -> bool:
        """重启Docker服务"""
        if not self.ssh_client.run("sudo systemctl daemon-reload && sudo systemctl restart docker"):
            log_error("重启Docker服务失败")
            return False
        
        return self._verify_docker_service() and self._verify_docker_hub_connection()
    
    def _verify_docker_service(self) -> bool:
        """验证Docker服务状态"""
        log_info("验证 Docker 服务状态...")
        for i in range(1, 31):
            if self.ssh_client.run("docker info > /dev/null 2>&1", hide=True):
                log_info("Docker 服务正常!")
                return True
            
            if i == 30:
                log_error("Docker 服务异常!")
                return False
            
            # 清除当前行并显示等待信息
            sys.stdout.write(f"\r\033[K[INFO] 等待 Docker 服务就绪...（{i}/30）")
            sys.stdout.flush()
            time.sleep(2)
        
        return False
    
    def _verify_docker_hub_connection(self) -> bool:
        """等待Docker服务就绪"""
        log_info("验证镜像仓库连接...")
        for i in range(1, 31):
            if self.ssh_client.run("docker pull hello-world > /dev/null 2>&1", hide=True):
                print()  # 换行
                log_info("镜像仓库连接正常！")
                return True
            
            if i == 30:
                print()  # 换行
                log_error("Docker 镜像仓库连接超时!")
                return False
            
            # 清除当前行并显示等待信息
            sys.stdout.write(f"\r\033[K[INFO] 等待 Docker 镜像仓库连接...（{i}/30）")
            sys.stdout.flush()
            time.sleep(2)
        
        return False
    
    def _deploy_service(self, env: str, version: str, image_name: str) -> bool:
        """部署服务"""
        if not self._stop_and_cleanup_containers():
            return False
        
        return self._load_and_start_containers(env, version, image_name)
    
    def _stop_and_cleanup_containers(self) -> bool:
        """停止并清理容器"""
        log_info("停止并删除旧容器...")
        # 只停止与当前项目相关的容器
        deploy_path = os.environ.get('DEPLOY_PATH')
        
        cmd = f"""cd {deploy_path} && \
            containers=$(docker ps -q --filter 'name=book_store') && \
            if [ ! -z "$containers" ]; then \
                docker stop --time 10 $containers || docker kill $containers; \
            fi"""
        
        if not self.ssh_client.run(cmd):
            log_warn("停止容器过程中出现警告，但将继续执行...")
        
        self._wait_for_containers_stop()
        
        # 清理停止的容器和未使用的镜像
        self.ssh_client.run("docker container prune -f")  # 清理所有停止的容器
        self.ssh_client.run("docker images 'book_store*' -q | xargs -r docker rmi -f")  # 清理相关镜像
        
        return True
    
    def _load_and_start_containers(self, env: str, version: str, image_name: str) -> bool:
        """加载并启动容器"""
        deploy_path = os.environ.get('DEPLOY_PATH')
        local_image_name = f"{image_name}-{env}-{version}.tar"
        
        log_info("在云端服务器上加载 Docker 镜像...")
        if not self.ssh_client.run(f"docker load -i {deploy_path}/{local_image_name}"):
            log_error("镜像加载失败!")
            return False
        
        return self._start_containers(env, version, image_name)
    
    def _show_deployment_done_info(self, image_name: str, env: str, version: str) -> None:
        """显示部署完成信息"""
        log_info("部署完成！")
        log_info("--------------------------------------------------")
        self._show_deployment_info(image_name, env, version)
        log_info("--------------------------------------------------")
        
        # 获取容器运行状态
        log_info("容器状态:")
        result = self.ssh_client.run(
            f"docker ps --filter \"name=book-store-{env}\" --format \"table {{.Names}}\t{{.Status}}\t{{.Ports}}\"",
        )
        print(result)
    
    def _show_deployment_info(self, image_name: str, env: str, version: str) -> None:
        """显示部署信息"""
        deploy_path = os.environ.get('DEPLOY_PATH')
        server_user = os.environ.get('SERVER_USER')
        server_ip = os.environ.get('SERVER_IP')
        
        log_info("部署信息:")
        log_info(f"  镜像: {image_name}")
        log_info(f"  环境: {env}")
        log_info(f"  版本: {version}")
        log_info(f"  部署路径: {deploy_path}")
        log_info(f"  服务器: {server_user}@{server_ip}")
    
    def _log_deployment_history(self, env: str, version: str, status: str) -> None:
        """记录部署历史"""
        base_dir = os.environ.get('BASE_DIR')
        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        with open(f"{base_dir}/deploy/deploy_history.log", "a") as f:
            f.write(f"{timestamp} {env} {version} {status}\n")
    
    def _send_deployment_notification(self, env: str, version: str, status: str) -> None:
        """发送部署通知"""
        notification_url = os.environ.get('NOTIFICATION_URL')
        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        message = f"环境: {env}\n版本: {version}\n状态: {status}\n时间: {timestamp}"
        
        # 如果配置了通知 URL，发送通知
        if notification_url:
            import requests
            requests.post(
                notification_url,
                headers={"Content-Type": "application/json"},
                data=json.dumps({"text": message})
            )
    
    def _wait_for_containers_stop(self) -> None:
        """等待容器停止"""
        log_info("等待容器完全停止...")
        wait_count = 0
        max_wait = 10  # 最多等待10秒
        
        while True:
            if not self.ssh_client.run("docker ps -q --filter 'name=book_store_server' | grep -q .", hide=True):
                break
            
            wait_count += 1
            sys.stdout.write(f"\r\033[K[INFO] 等待容器停止中... ({wait_count}/{max_wait}秒)")
            sys.stdout.flush()
            
            if wait_count >= max_wait:
                print()  # 换行
                log_warn("等待容器停止超时，将强制继续...")
                return
            
            time.sleep(1)
        
        print()  # 换行
        log_info("所有相关容器已停止!")
    
    def _start_containers(self, env: str, version: str, image_name: str) -> bool:
        """启动容器"""
        deploy_path = os.environ.get('DEPLOY_PATH')
        env_file_name = EnvUtils.get_env(env)
        
        if not env_file_name:
            return False
        
        log_info("启动新容器...")
        
        cmd = f"""cd {deploy_path} && \
            set -a && source {env_file_name} && set +a && \
            export IMAGE_NAME={image_name}:{version} \
                   VERSION={version} && \
            docker compose up -d"""
        
        if not self.ssh_client.run(cmd):
            log_error("服务部署失败")
            return False
        
        return self._verify_deployment()
    
    def _verify_deployment(self) -> bool:
        """验证部署结果"""
        log_info("验证部署结果...")
        
        # 等待容器启动
        log_info("等待容器启动...")
        time.sleep(5)  # 给容器一些启动时间
        
        # 检查容器状态
        log_info("检查容器状态...")
        deploy_path = os.environ.get('DEPLOY_PATH')
        env_file_name = os.environ.get('env_file_name')  # 这里可能需要从上下文获取
        image_name = os.environ.get('IMAGE_NAME')
        version = os.environ.get('VERSION')
        
        cmd = f"""cd {deploy_path} && \
            set -a && source {env_file_name} && set +a && \
            export IMAGE_NAME={image_name}:{version} \
                   VERSION={version} && \
            docker compose ps"""
        
        if not self.ssh_client.run(cmd):
            log_error("无法获取容器状态")
            return False
        
        # 检查每个服务的状态
        log_info("检查各服务状态...")
        services = ["apiServer", "postgres", "redis", "nginx"]
        
        for service in services:
            log_info(f"检查 {service} 服务状态...")
            cmd = f"""cd {deploy_path} && \
                set -a && source {env_file_name} && set +a && \
                export IMAGE_NAME={image_name}:{version} \
                       VERSION={version} && \
                docker compose ps {service} | grep -q 'running'"""
            
            if not self.ssh_client.run(cmd, hide=True):
                log_error(f"{service} 服务未正常运行")
                log_info(f"获取 {service} 服务日志...")
                
                log_cmd = f"""cd {deploy_path} && \
                    set -a && source {env_file_name} && set +a && \
                    export IMAGE_NAME={image_name}:{version} \
                           VERSION={version} && \
                    docker compose logs {service}"""
                
                self.ssh_client.run(log_cmd, hide=True)
                return False
        
        # 显示所有容器的最新日志
        log_info("部署成功！显示各服务最新日志...")
        
        for service in services:
            log_info(f"=== {service} 服务最新日志 ===")
            
            log_cmd = f"""cd {deploy_path} && \
                set -a && source {env_file_name} && set +a && \
                export IMAGE_NAME={image_name}:{version} \
                       VERSION={version} && \
                docker compose logs --tail 20 {service}"""
            
            self.ssh_client.run(log_cmd, hide=True)
            print("----------------------------------------")
        
        return True


if __name__ == "__main__":
    
    if not DeployService.deploy():
        sys.exit(1)
    sys.exit(0)

