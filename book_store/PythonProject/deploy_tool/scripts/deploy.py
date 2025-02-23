#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker服务部署服务
负责将Docker镜像部署到远程服务器，包括配置文件上传、容器管理等功能。
"""

import time
from pathlib import Path
import yaml

from deploy_tool.utils import (
    log_info,
    log_error,
    SSHClient,
    Progress,  # 导入封装好的进度条类
)

class DeployService:
        
    @staticmethod
    def _load_config() -> bool:
        """加载配置文件"""
        try:
            config_path = Path("config.yaml")
            if not config_path.exists():
                log_error("配置文件 config.yaml 不存在")
                return False
                
            with open(config_path) as f:
                DeployService.config = yaml.safe_load(f)
            return True
        except Exception as e:
            log_error(f"加载配置文件失败: {str(e)}")
            return False
            
    @staticmethod
    async def deploy() -> bool:
        """执行部署流程"""
        try:
            # 加载配置文件
            if not DeployService._load_config():
                return False
            
            progress = Progress()  # 创建进度条实例
            
            with progress.console.status("[cyan]正在进行部署...[/cyan]"):
                # 上传配置文件
                task = progress.show_progress(total_size=None, description="[cyan]上传配置文件...[/cyan]")
                if not await DeployService._upload_config_files():
                    return False
                    
                # 上传Docker配置
                task = progress.show_progress(total_size=None, description="[cyan]上传Docker配置...[/cyan]")
                if not await DeployService._upload_docker_config():
                    return False
                    
                # 上传镜像
                task = progress.show_progress(total_size=None, description="[cyan]上传镜像文件...[/cyan]")
                if not await DeployService._upload_image():
                    return False
                    
                # 加载镜像
                task = progress.show_progress(total_size=None, description="[cyan]加载镜像...[/cyan]")
                if not await DeployService._load_image():
                    return False
                    
                # 停止旧容器
                task = progress.show_progress(total_size=None, description="[cyan]停止旧容器...[/cyan]")
                if not await DeployService._stop_container():
                    return False
                    
                # 启动新容器
                task = progress.show_progress(total_size=None, description="[cyan]启动新容器...[/cyan]")
                if not await DeployService._start_container():
                    return False
                    
                # 验证部署
                task = progress.show_progress(total_size=None, description="[cyan]验证部署...[/cyan]")
                if not await DeployService._validate_deployment():
                    return False
                    
            log_info("部署完成！")
            return True
            
        except Exception as e:
            log_error(f"部署失败: {str(e)}")
            return False
        finally:
            if SSHClient().disconnect():
                log_info("SSH连接已关闭")

    @staticmethod
    async def _upload_config_files() -> bool:
        """上传配置文件"""
        try:
            files = {
                "deploy/prod/docker-compose.yaml": "/opt/book_store/docker-compose.yaml",
                "deploy/prod/nginx.conf": "/opt/book_store/nginx.conf"
            }
            
            for local, remote in files.items():
                result = SSHClient().put(local, remote)
                if not result.ok:
                    log_error(f"上传 {local} 失败")
                    return False
                    
            return True
        except Exception as e:
            log_error(f"上传配置文件失败: {str(e)}")
            return False
            
    @staticmethod
    async def _upload_docker_config() -> bool:
        """上传Docker配置文件"""
        try:
            result = SSHClient().put(
                "deploy/prod/daemon.json",
                "/etc/docker/daemon.json"
            )
            return result.ok
        except Exception as e:
            log_error(f"上传Docker配置失败: {str(e)}")
            return False
            
    @staticmethod
    async def _upload_image() -> bool:
        """上传Docker镜像"""
        try:
            image_file = f"book_store-{DeployService.config['version']}.tar"
            result = SSHClient().put(
                image_file,
                f"/opt/book_store/{image_file}"
            )
            return result.ok
        except Exception as e:
            log_error(f"上传镜像失败: {str(e)}")
            return False
            
    @staticmethod
    async def _load_image() -> bool:
        """加载Docker镜像"""
        try:
            image_file = f"book_store-{DeployService.config['version']}.tar"
            result = SSHClient().run(
                f"docker load -i /opt/book_store/{image_file}",
                hide=True
            )
            return result.ok
        except Exception as e:
            log_error(f"加载镜像失败: {str(e)}")
            return False
            
    @staticmethod
    async def _stop_container() -> bool:
        """停止旧容器"""
        try:
            # 检查容器是否存在
            result = SSHClient().run(
                "docker ps -q -f name=book_store",
                hide=True
            )
            
            if result.stdout.strip():
                # 停止容器
                stop_result = SSHClient().run(
                    "docker stop book_store",
                    hide=True
                )
                if not stop_result.ok:
                    return False
                    
                # 等待容器停止
                time.sleep(5)
                
            return True
        except Exception as e:
            log_error(f"停止容器失败: {str(e)}")
            return False
            
    @staticmethod
    async def _start_container() -> bool:
        """启动新容器"""
        try:
            result = SSHClient().run(
                "cd /opt/book_store && docker-compose up -d",
                hide=True
            )
            return result.ok
        except Exception as e:
            log_error(f"启动容器失败: {str(e)}")
            return False
            
    @staticmethod
    async def _validate_deployment() -> bool:
        """验证部署是否成功"""
        try:
            # 等待服务启动
            time.sleep(10)
            
            # 检查容器状态
            result = SSHClient().run(
                "docker ps -f name=book_store --format '{{.Status}}'",
                hide=True
            )
            
            if "Up" not in result.stdout:
                log_error("容器未正常运行")
                return False
                
            # 检查服务健康状态
            health_check = SSHClient().run(
                "curl -s -o /dev/null -w '%{http_code}' http://localhost:80/health",
                hide=True
            )
            
            if health_check.stdout.strip() != "200":
                log_error("服务健康检查失败")
                return False
                
            return True
        except Exception as e:
            log_error(f"验证部署失败: {str(e)}")
            return False 