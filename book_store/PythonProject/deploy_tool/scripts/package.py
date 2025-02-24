#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker镜像打包服务
负责将构建好的Docker镜像打包并保存为文件。
"""

import os
from pathlib import Path
from rich.progress import Progress
import docker

from deploy_tool.utils import (
    log_info,
    log_error,
    EnvUtils,
)

class PackageService:
    client = None  # 将 client 设为静态变量
    build_context = Path.cwd()  # 将 build_context 设为静态变量

    @staticmethod
    def _init_docker_client():
        """初始化Docker客户端"""
        if PackageService.client is None:
            try:
                PackageService.client = docker.from_env()
                log_info("Docker客户端连接成功")
            except Exception as e:
                log_error(f"Docker客户端连接失败: {str(e)}")
                return False
        return True
        
    @staticmethod
    async def package_image() -> bool:
        """打包Docker镜像"""
        try:
            # 初始化Docker客户端
            if not PackageService._init_docker_client():
                return False

            version = EnvUtils.get_env("VERSION")
            image_name = EnvUtils.get_env("IMAGE_NAME")
            log_info(f"镜像名称: {image_name}")
            
            with Progress() as progress:
                # 创建多架构清单
                task = progress.add_task("[cyan]创建多架构清单...", total=100)
                
                # 获取所有架构的镜像
                images = []
                for arch in ["amd64", "arm64"]:
                    image_tag = f"{image_name}:{version}"
                    try:
                        image = PackageService.client.images.get(image_tag)
                        images.append(image)
                        progress.update(task, advance=50)
                    except docker.errors.ImageNotFound:
                        log_error(f"未找到镜像 {image_tag}")
                        return False
                        
                if not images:
                    log_error("没有可用的镜像")
                    return False
                    
                # 创建统一的标签
                final_tag = f"{image_name}:{version}"
                manifest_cmd = f"docker manifest create {final_tag}"
                for arch in ["amd64", "arm64"]:
                    manifest_cmd += f" {final_tag}-{arch}"
                    
                # 执行manifest命令
                os.system(manifest_cmd)
                progress.update(task, completed=100)
                
                # 保存镜像
                task = progress.add_task("[cyan]保存镜像...", total=100)
                
                save_path = PackageService.build_context / f"{image_name}-{version}.tar"
                with open(save_path, "wb") as f:
                    for chunk in PackageService.client.images.get(final_tag).save():
                        f.write(chunk)
                        progress.update(task, advance=1)
                        
                log_info(f"镜像已保存到: {save_path}")
                return True
                
        except Exception as e:
            log_error(f"打包失败: {str(e)}")
            return False
            
    @staticmethod
    async def _validate_image(image_tag: str) -> bool:
        """验证镜像是否存在且可用"""
        try:
            PackageService.client.images.get(image_tag)
            return True
        except docker.errors.ImageNotFound:
            log_error(f"镜像 {image_tag} 不存在")
            return False
        except Exception as e:
            log_error(f"验证镜像失败: {str(e)}")
            return False 