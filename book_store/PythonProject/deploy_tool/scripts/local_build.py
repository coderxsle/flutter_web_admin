#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker镜像构建服务
提供多架构Docker镜像的构建功能，支持amd64和arm64架构。
"""

import os
import asyncio
from pathlib import Path
from typing import Optional, Dict, Any, Tuple
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.live import Live
import docker

from deploy_tool.utils import (
    log_info,
    log_error,
    log_warn,
    load_env,
)

class LocalBuildService:
    def __init__(self):
        self.client = None
        self.build_context = Path.cwd()
        
    def _init_docker_client(self):
        """初始化Docker客户端"""
        if self.client is None:
            try:
                self.client = docker.from_env()
                log_info("Docker客户端连接成功")
            except Exception as e:
                log_error(f"Docker客户端连接失败: {str(e)}")
                return False
        return True
        
    async def build_image(self) -> bool:
        """构建Docker镜像"""
        try:
            # 初始化Docker客户端
            if not self._init_docker_client():
                return False

            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                transient=True
            ) as progress:
                progress.add_task(description="[cyan]准备构建环境...", total=None)
                
                # 验证Dockerfile
                if not await self._validate_dockerfile():
                    return False
                    
                # 准备构建参数
                build_args = self._prepare_build_args()
                
                # 构建多架构镜像
                log_info("开始多架构构建...")
                
                with Live() as live:
                    for arch in ["amd64", "arm64"]:
                        live.update(f"[yellow]构建 {arch} 架构...[/yellow]")
                        
                        try:
                            image, logs = await self._build_for_arch(arch, build_args)
                            for log in logs:
                                if 'stream' in log:
                                    live.update(log['stream'].strip())
                                    
                            log_info(f"{arch} 架构构建完成")
                        except Exception as e:
                            log_error(f"构建 {arch} 架构失败: {str(e)}")
                            return False
                            
                log_info("所有架构构建完成！")
                return True
                
        except Exception as e:
            log_error(f"构建过程出错: {str(e)}")
            return False
            
    async def _validate_dockerfile(self) -> bool:
        """验证Dockerfile是否存在且有效"""
        dockerfile_path = self.build_context / "Dockerfile"
        
        if not dockerfile_path.exists():
            log_error("错误: Dockerfile不存在")
            return False
            
        # 这里可以添加更多的Dockerfile验证逻辑
        return True
        
    def _prepare_build_args(self) -> dict:
        """准备构建参数"""
        return {
            "VERSION": os.getenv("DEPLOY_VERSION", "latest"),
            "BUILD_ENV": os.getenv("DEPLOY_ENV", "prod")
        }
        
    async def _build_for_arch(self, arch: str, build_args: dict):
        """为特定架构构建镜像"""
        platform = f"linux/{arch}"
        
        # 设置构建选项
        build_options = {
            "path": str(self.build_context),
            "dockerfile": "Dockerfile",
            "platform": platform,
            "buildargs": build_args,
            "tag": f"book_store:{arch}-{build_args['VERSION']}",
            "pull": True,
            "rm": True
        }
        
        # 使用docker SDK构建镜像
        image = await asyncio.to_thread(
            self.client.images.build,
            **build_options
        )
        
        return image
        
    async def save_image(self, image_name: str, version: str) -> bool:
        """保存镜像到文件"""
        try:
            save_path = self.build_context / f"{image_name}-{version}.tar"
            
            with Progress() as progress:
                task = progress.add_task("[cyan]保存镜像...", total=100)
                
                # 获取镜像
                image = self.client.images.get(f"{image_name}:{version}")
                
                # 保存镜像
                with open(save_path, "wb") as f:
                    for chunk in image.save():
                        f.write(chunk)
                        progress.update(task, advance=1)
                        
            log_info(f"镜像已保存到: {save_path}")
            return True
            
        except Exception as e:
            log_error(f"保存镜像失败: {str(e)}")
            return False 