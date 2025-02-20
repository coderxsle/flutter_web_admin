#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Docker镜像构建服务
提供在远程服务器上构建Docker镜像的功能。
"""

import os
import time
import hashlib
import shutil
from pathlib import Path
from typing import Optional, Dict, Any, Tuple
from fabric import Connection
from rich.progress import Progress, SpinnerColumn, TextColumn

from deploy_tool.utils import (
    log_info,
    log_error,
    log_warn,
    get_env,
    ssh_execute,
    scp_transfer,
)

class BuildService:
    def __init__(self):
        self.conn: Optional[Connection] = None
        self.build_context = Path.cwd()
        
    async def connect(self) -> bool:
        """建立远程连接"""
        try:
            if self.conn is not None:
                # 如果已经有连接，先检查是否还活着
                try:
                    await ssh_execute(self.conn, "echo 'Connection test'")
                    log_info("使用现有连接")
                    return True
                except Exception:
                    # 连接已断开，关闭它
                    self.conn.close()
                    self.conn = None

            # 获取连接信息
            server_ip = get_env('SERVER_IP')
            server_user = get_env('SERVER_USER')
            ssh_password = get_env('SSH_PASSWORD')

            if not all([server_ip, server_user, ssh_password]):
                log_error("缺少必要的连接信息")
                return False

            # 建立新连接
            self.conn = Connection(
                host=server_ip,
                user=server_user,
                connect_kwargs={
                    "password": ssh_password,
                    "banner_timeout": 60,  # 增加超时时间
                    "timeout": 30,         # 设置命令执行超时
                }
            )

            # 测试连接
            if not await ssh_execute(self.conn, "echo 'Connection test'"):
                log_error("连接测试失败")
                self.conn.close()
                self.conn = None
                return False

            log_info("远程连接建立成功")
            return True

        except Exception as e:
            log_error(f"建立连接失败: {str(e)}")
            if self.conn:
                self.conn.close()
                self.conn = None
            return False

    def disconnect(self):
        """关闭远程连接"""
        if self.conn:
            try:
                self.conn.close()
                log_info("远程连接已关闭")
            except Exception as e:
                log_error(f"关闭连接时出错: {str(e)}")
            finally:
                self.conn = None

    def get_cache_dir(self, platform: str) -> Path:
        """获取缓存目录"""
        # 将 linux/amd64 转换为 linux-amd64
        platform_suffix = platform.replace('/', '-')
        cache_dir = Path.home() / '.docker' / 'cache' / platform_suffix
        cache_dir.mkdir(parents=True, exist_ok=True)
        return cache_dir

    def get_cache_hash(self, cache_dir: Path) -> Optional[str]:
        """获取缓存哈希值"""
        index_file = cache_dir / 'index.json'
        if not index_file.exists():
            return None
        
        with open(index_file, 'rb') as f:
            return hashlib.sha256(f.read()).hexdigest()

    async def setup_remote_buildx(self) -> bool:
        """在远程服务器上设置 buildx 构建器"""
        try:
            # 清理并重新创建 buildx 构建器
            await ssh_execute(self.conn, "docker buildx rm multiarch-builder 2>/dev/null || true")
            result = await ssh_execute(self.conn, "docker buildx create --name multiarch-builder --use")
            if not result:
                log_error("创建构建器失败")
                return False
            return True
        except Exception as e:
            log_error(f"设置 buildx 失败: {e}")
            return False

    async def setup_remote_qemu(self) -> bool:
        """在远程服务器上设置 QEMU 支持"""
        try:
            # 检查 QEMU 镜像
            result = await ssh_execute(self.conn, "docker images -q multiarch/qemu-user-static:latest")
            if not result:
                log_info("拉取 multiarch/qemu-user-static 镜像...")
                if not await ssh_execute(self.conn, "docker pull multiarch/qemu-user-static:latest"):
                    log_error("拉取 multiarch/qemu-user-static 失败")
                    return False
            
            # 运行 QEMU
            if not await ssh_execute(self.conn, "docker run --rm --privileged multiarch/qemu-user-static --reset -p yes"):
                log_error("无法启动 multiarch/qemu-user-static")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 QEMU 失败: {e}")
            return False

    async def setup_remote_binfmt(self) -> bool:
        """在远程服务器上设置 binfmt 支持"""
        try:
            # 检查 binfmt 镜像
            result = await ssh_execute(self.conn, "docker images -q tonistiigi/binfmt:latest")
            if not result:
                log_info("拉取 tonistiigi/binfmt 镜像...")
                if not await ssh_execute(self.conn, "docker pull tonistiigi/binfmt:latest"):
                    log_error("拉取 tonistiigi/binfmt 失败")
                    return False
            
            # 运行 binfmt
            if not await ssh_execute(self.conn, "docker run --rm --privileged tonistiigi/binfmt --install all"):
                log_error("无法安装 binfmt")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 binfmt 失败: {e}")
            return False

    async def build_image(self) -> bool:
        """在远程服务器上构建Docker镜像"""
        try:
            # 获取环境变量
            deploy_path = get_env('DEPLOY_PATH')
            version = get_env('VERSION')
            image_name = get_env('IMAGE_NAME')

            if not all([deploy_path, version, image_name]):
                log_error("缺少必要的环境变量")
                return False

            # 建立连接
            if not await self.connect():
                return False

            # 记录开始时间
            start_time = time.time()
                
            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                transient=False,
            ) as progress:
                # 上传构建文件
                task = progress.add_task("正在上传构建文件...", total=None)
                if not await self._upload_build_files():
                    return False
                progress.update(task, completed=True)
                
                # 设置构建环境
                task = progress.add_task("正在设置构建环境...", total=None)
                if not all([
                    await self.setup_remote_buildx(),
                    await self.setup_remote_qemu(),
                    await self.setup_remote_binfmt()
                ]):
                    return False
                progress.update(task, completed=True)
                
                # 构建镜像
                task = progress.add_task("正在构建镜像...", total=None)
                if not await self._build_image_on_remote():
                    return False
                progress.update(task, completed=True)

            # 计算耗时
            end_time = time.time()
            duration = int(end_time - start_time)
            minutes, seconds = divmod(duration, 60)
            
            log_info("镜像构建完成")
            log_info(f"总耗时: {minutes}分{seconds}秒")
            return True
            
        except Exception as e:
            log_error(f"构建过程出错: {str(e)}")
            return False
        finally:
            self.disconnect()

    async def _upload_build_files(self) -> bool:
        """上传构建所需的文件"""
        try:
            # 获取部署路径
            deploy_path = get_env('DEPLOY_PATH')
            
            # 创建远程目录
            await ssh_execute(self.conn, f"mkdir -p {deploy_path}")
            
            # 上传 Dockerfile
            dockerfile = self.build_context / "Dockerfile"
            if not dockerfile.exists():
                log_error("Dockerfile不存在")
                return False
                
            if not await scp_transfer(self.conn, str(dockerfile), f"{deploy_path}/Dockerfile"):
                log_error("上传Dockerfile失败")
                return False
                
            # 上传其他必要文件
            files = [
                "docker-compose.yml",
                "requirements.txt",
                ".dockerignore"
            ]
            
            for file in files:
                file_path = self.build_context / file
                if file_path.exists():
                    if not await scp_transfer(self.conn, str(file_path), f"{deploy_path}/{file}"):
                        log_error(f"上传 {file} 失败")
                        return False
                        
            return True
            
        except Exception as e:
            log_error(f"上传文件失败: {str(e)}")
            return False
            
    async def _build_image_on_remote(self) -> bool:
        """在远程服务器上构建镜像"""
        try:
            # 获取环境变量
            deploy_path = get_env('DEPLOY_PATH')
            version = get_env('VERSION')
            image_name = get_env('IMAGE_NAME')
            
            # 构建命令
            build_cmd = (
                f"cd {deploy_path} && "
                f"docker buildx build "
                f"--platform linux/amd64 "
                f"--output type=docker "
                f"--build-arg BUILDKIT_INLINE_CACHE=1 "
                f"--pull=false "
                f"--network=host "
                f"-t {image_name}:{version} "
                f"."
            )
            
            # 执行构建
            if not await ssh_execute(self.conn, build_cmd):
                log_error("构建失败")
                return False
                
            return True
            
        except Exception as e:
            log_error(f"构建失败: {str(e)}")
            return False