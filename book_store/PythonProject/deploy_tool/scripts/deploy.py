#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker服务部署服务
负责将Docker镜像部署到远程服务器，包括配置文件上传、容器管理等功能。
"""

import os
import time
from pathlib import Path
from typing import Optional, Dict, Any
from fabric import Connection
from rich.progress import Progress, SpinnerColumn, TextColumn
import yaml

from deploy_tool.utils import (
    log_info,
    log_error,
    log_warn,
    load_env,
    ssh_execute,
    scp_transfer,
)

class DeployService:
    def __init__(self):
        self.config: Dict[str, Any] = {}
        self.conn: Optional[Connection] = None
        
    def _load_config(self) -> bool:
        """加载配置文件"""
        try:
            config_path = Path("config.yaml")
            if not config_path.exists():
                log_error("配置文件 config.yaml 不存在")
                return False
                
            with open(config_path) as f:
                self.config = yaml.safe_load(f)
            return True
        except Exception as e:
            log_error(f"加载配置文件失败: {str(e)}")
            return False
            
    async def deploy(self) -> bool:
        """执行部署流程"""
        try:
            # 加载配置文件
            if not self._load_config():
                return False

            # 连接远程服务器
            self.conn = Connection(
                host=self.config["host"],
                user=self.config["username"],
                port=self.config["port"]
            )
            
            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                transient=True
            ) as progress:
                # 上传配置文件
                task = progress.add_task("[cyan]上传配置文件...", total=None)
                if not await self._upload_config_files():
                    return False
                    
                # 上传Docker配置
                task = progress.add_task("[cyan]上传Docker配置...", total=None)
                if not await self._upload_docker_config():
                    return False
                    
                # 上传镜像
                task = progress.add_task("[cyan]上传镜像文件...", total=None)
                if not await self._upload_image():
                    return False
                    
                # 加载镜像
                task = progress.add_task("[cyan]加载镜像...", total=None)
                if not await self._load_image():
                    return False
                    
                # 停止旧容器
                task = progress.add_task("[cyan]停止旧容器...", total=None)
                if not await self._stop_container():
                    return False
                    
                # 启动新容器
                task = progress.add_task("[cyan]启动新容器...", total=None)
                if not await self._start_container():
                    return False
                    
                # 验证部署
                task = progress.add_task("[cyan]验证部署...", total=None)
                if not await self._validate_deployment():
                    return False
                    
            log_info("部署完成！")
            return True
            
        except Exception as e:
            log_error(f"部署失败: {str(e)}")
            return False
        finally:
            if self.conn:
                self.conn.close()
                
    async def _upload_config_files(self) -> bool:
        """上传配置文件"""
        try:
            files = {
                "deploy/prod/docker-compose.yaml": "/opt/book_store/docker-compose.yaml",
                "deploy/prod/nginx.conf": "/opt/book_store/nginx.conf"
            }
            
            for local, remote in files.items():
                result = self.conn.put(local, remote)
                if not result.ok:
                    log_error(f"上传 {local} 失败")
                    return False
                    
            return True
        except Exception as e:
            log_error(f"上传配置文件失败: {str(e)}")
            return False
            
    async def _upload_docker_config(self) -> bool:
        """上传Docker配置文件"""
        try:
            result = self.conn.put(
                "deploy/prod/daemon.json",
                "/etc/docker/daemon.json"
            )
            return result.ok
        except Exception as e:
            console.print(f"[red]上传Docker配置失败: {str(e)}[/red]")
            return False
            
    async def _upload_image(self) -> bool:
        """上传Docker镜像"""
        try:
            image_file = f"book_store-{self.config['version']}.tar"
            result = self.conn.put(
                image_file,
                f"/opt/book_store/{image_file}"
            )
            return result.ok
        except Exception as e:
            console.print(f"[red]上传镜像失败: {str(e)}[/red]")
            return False
            
    async def _load_image(self) -> bool:
        """加载Docker镜像"""
        try:
            image_file = f"book_store-{self.config['version']}.tar"
            result = self.conn.run(
                f"docker load -i /opt/book_store/{image_file}",
                hide=True
            )
            return result.ok
        except Exception as e:
            console.print(f"[red]加载镜像失败: {str(e)}[/red]")
            return False
            
    async def _stop_container(self) -> bool:
        """停止旧容器"""
        try:
            # 检查容器是否存在
            result = self.conn.run(
                "docker ps -q -f name=book_store",
                hide=True
            )
            
            if result.stdout.strip():
                # 停止容器
                stop_result = self.conn.run(
                    "docker stop book_store",
                    hide=True
                )
                if not stop_result.ok:
                    return False
                    
                # 等待容器停止
                time.sleep(5)
                
            return True
        except Exception as e:
            console.print(f"[red]停止容器失败: {str(e)}[/red]")
            return False
            
    async def _start_container(self) -> bool:
        """启动新容器"""
        try:
            result = self.conn.run(
                "cd /opt/book_store && docker-compose up -d",
                hide=True
            )
            return result.ok
        except Exception as e:
            console.print(f"[red]启动容器失败: {str(e)}[/red]")
            return False
            
    async def _validate_deployment(self) -> bool:
        """验证部署是否成功"""
        try:
            # 等待服务启动
            time.sleep(10)
            
            # 检查容器状态
            result = self.conn.run(
                "docker ps -f name=book_store --format '{{.Status}}'",
                hide=True
            )
            
            if "Up" not in result.stdout:
                console.print("[red]容器未正常运行[/red]")
                return False
                
            # 检查服务健康状态
            health_check = self.conn.run(
                "curl -s -o /dev/null -w '%{http_code}' http://localhost:80/health",
                hide=True
            )
            
            if health_check.stdout.strip() != "200":
                console.print("[red]服务健康检查失败[/red]")
                return False
                
            return True
        except Exception as e:
            console.print(f"[red]验证部署失败: {str(e)}[/red]")
            return False 