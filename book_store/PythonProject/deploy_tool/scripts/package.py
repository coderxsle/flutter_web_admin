#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker镜像打包服务
负责将构建好的Docker镜像打包并保存为文件。
"""

import os
from pathlib import Path
from rich.console import Console
from rich.panel import Panel
from deploy_tool.utils import (
    log_info,
    log_error,
    log_warn,
    EnvUtils,
    SSHClient
)

class PackageService:
    build_context = Path.cwd()  # 构建上下文路径
    sh = SSHClient()  # 使用 SSHClient 执行命令

    @staticmethod
    async def package_image() -> bool:
        """打包Docker镜像"""
        try:
            console = Console()
            console.print(Panel.fit("开始打包镜像", style="bold magenta")) 

            # 检查 Docker 是否可用
            if not PackageService.sh.local_run("docker --version"):
                log_error("Docker 不可用，请检查 Docker 安装")
                return False

            registry = EnvUtils.get_env("REGISTRY")
            namespace = EnvUtils.get_env("NAMESPACE")
            version = EnvUtils.get_env("VERSION")
            image_name = EnvUtils.get_env("IMAGE_NAME")
            full_image_tag = f"{image_name}:{version}"
            log_info(f"镜像名称: {image_name}")

            log_info("检查镜像是否存在...")
            if not PackageService.sh.local_run(f"docker image inspect {full_image_tag} >/dev/null 2>&1"):
                log_error(f"镜像 {full_image_tag} 不存在，请先构建镜像")
                log_info("当前系统中的相关镜像：")

                PackageService.sh.local_run(f"docker images | grep -E \"{registry}/{namespace}/{image_name}|{full_image_tag}\" || true")
                log_warn("提示：请先运行 build.sh 构建镜像")
                log_warn("示例：./deploy/scripts/build.sh ${env} ${version}")
                return False

            # 保存镜像
            log_info("开始保存镜像...")
            save_path = PackageService.build_context / f"{image_name}-{version}.tar"
            if not PackageService.sh.local_run(f"docker save {full_image_tag} -o {save_path}"):
                log_error("保存镜像失败")
                return False
                    
            log_info(f"镜像已保存到: {save_path}")
            return True
                
        except Exception as e:
            log_error(f"打包失败: {str(e)}")
            return False
            
    @staticmethod
    async def _validate_image(image_tag: str) -> bool:
        """验证镜像是否存在且可用"""
        try:
            result = PackageService.sh.local_run(f"docker inspect {image_tag} > /dev/null 2>&1")
            return result
        except Exception as e:
            log_error(f"验证镜像失败: {str(e)}")
            return False 