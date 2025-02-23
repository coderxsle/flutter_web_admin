"""
Docker 镜像构建模块
"""

import sys
import time
import hashlib
import shutil
import os
from pathlib import Path
from typing import Optional

from utils import log_info, log_error, SSHClient, EnvUtils
from utils.system_utils import SystemUtils
from utils.progress import Progress

class BuildService:
    sh = SSHClient()

    @staticmethod
    async def build() -> bool:
        """公开的构建方法"""
        
        env = EnvUtils.get_env('BUILD_ENV')  # 示例环境变量
        version = EnvUtils.get_env('BUILD_VERSION')  # 示例版本变量
        
        # 检查架构
        arch_result, build_platform = SystemUtils.check_architecture()
        if not arch_result or not build_platform:
            log_error("架构检查失败")
            return False
        
        # 记录开始时间
        start_time = time.time()
        
        # 设置缓存目录
        cache_dir = BuildService.get_cache_dir(build_platform)
        current_cache_hash = BuildService.get_cache_hash(cache_dir)
        
        image_name = os.getenv('IMAGE_NAME', '')
        if not image_name:
            log_error("未设置 IMAGE_NAME 环境变量")
            return False
        
        log_info(f"开始构建镜像: {image_name}:{version} (平台: {build_platform})")
            
        # 设置构建环境
        if not await all([
            BuildService._setup_buildx(),
            BuildService._setup_qemu(),
            BuildService._setup_binfmt()
        ]):
            return False
        
        # 构建缓存选项
        cache_options = []
        if (cache_dir / 'index.json').exists():
            log_info(f"使用已存在的构建缓存 ({build_platform})...")
            cache_options.extend([
                f"--cache-from=type=local,src={cache_dir},mode=max",
                f"--cache-to=type=local,dest={cache_dir}-new,mode=max"
            ])
        
        # 构建命令
        build_cmd = [
            "docker buildx build",
            f"--platform {build_platform}",
            "--output type=docker",
            " ".join(cache_options),
            "--build-arg BUILDKIT_INLINE_CACHE=1",
            "--pull=false",
            "--network=host",
            f"-t {image_name}:{version}",
            f"--build-arg ENV={env}",
            f"-f {os.getenv('PROJECT_ROOT')}/Dockerfile",
            f"{os.getenv('PROJECT_ROOT')}/.."
        ]
        
        # 执行构建
        if BuildService.sh.run(" ".join(build_cmd)).return_code != 0:
            log_error("镜像构建失败")
            return False
        
        # 更新缓存
        new_cache_dir = Path(str(cache_dir) + '-new')
        if new_cache_dir.exists():
            new_cache_hash = BuildService.get_cache_hash(new_cache_dir)
            if new_cache_hash != current_cache_hash:
                log_info(f"检测到缓存内容变化，更新缓存 ({build_platform})...")
                shutil.rmtree(cache_dir, ignore_errors=True)
                new_cache_dir.rename(cache_dir)
            else:
                log_info("缓存内容未变化，跳过更新")
                shutil.rmtree(new_cache_dir, ignore_errors=True)
        
        # 计算耗时
        end_time = time.time()
        duration = int(end_time - start_time)
        minutes, seconds = divmod(duration, 60)
        
        log_info("镜像构建成功")
        log_info(f"总耗时: {minutes}分{seconds}秒")
        
        return True

    @staticmethod
    def get_cache_dir(platform: str) -> Path:
        """获取缓存目录"""
        # 将 linux/amd64 转换为 linux-amd64
        platform_suffix = platform.replace('/', '-')
        cache_dir = Path.home() / '.docker' / 'cache' / platform_suffix
        cache_dir.mkdir(parents=True, exist_ok=True)
        return cache_dir

    @staticmethod
    def get_cache_hash(cache_dir: Path) -> Optional[str]:
        """获取缓存哈希值"""
        index_file = cache_dir / 'index.json'
        if not index_file.exists():
            return None
        
        with open(index_file, 'rb') as f:
            return hashlib.sha256(f.read()).hexdigest()

    @staticmethod
    async def _setup_buildx() -> bool:
        """设置 buildx 构建器"""
        try:
            await BuildService.sh.run("docker buildx rm multiarch-builder 2>/dev/null || true")
            result = await BuildService.sh.run("docker buildx create --name multiarch-builder --use")
            if result.return_code != 0:
                log_error("创建构建器失败")
                return False
            return True
        except Exception as e:
            log_error(f"设置 buildx 失败: {e}")
            return False

    @staticmethod
    async def _setup_qemu() -> bool:
        """设置 QEMU 支持"""
        try:
            result = await BuildService.sh.run("docker images -q multiarch/qemu-user-static:latest 2>/dev/null")
            if result.return_code != 0:
                log_info("拉取 multiarch/qemu-user-static 镜像...")
                if await BuildService.sh.run("docker pull multiarch/qemu-user-static:latest").return_code != 0:
                    log_error("拉取 multiarch/qemu-user-static 失败")
                    return False
            
            if await BuildService.sh.run("docker run --rm --privileged multiarch/qemu-user-static --reset -p yes").return_code != 0:
                log_error("无法启动 multiarch/qemu-user-static")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 QEMU 失败: {e}")
            return False

    @staticmethod
    async def _setup_binfmt() -> bool:
        """设置 binfmt 支持"""
        try:
            result = await BuildService.sh.run("docker images -q tonistiigi/binfmt:latest 2>/dev/null")
            if result.return_code != 0:
                log_info("拉取 tonistiigi/binfmt 镜像...")
                if await BuildService.sh.run("docker pull tonistiigi/binfmt:latest").return_code != 0:
                    log_error("拉取 tonistiigi/binfmt 失败")
                    return False
            
            if await BuildService.sh.run("docker run --rm --privileged tonistiigi/binfmt --install all").return_code != 0:
                log_error("无法安装 binfmt")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 binfmt 失败: {e}")
            return False

    @staticmethod
    async def build_image() -> bool:
        """在远程服务器上构建Docker镜像"""
        try:
            # 获取环境变量
            deploy_path = EnvUtils.get_env('DEPLOY_PATH')
            version = EnvUtils.get_env('VERSION')
            image_name = EnvUtils.get_env('IMAGE_NAME')

            if not all([deploy_path, version, image_name]):
                log_error("缺少必要的环境变量")
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
                if not await BuildService._upload_build_files():
                    return False
                progress.update(task, completed=True)
                
                # 设置构建环境
                task = progress.add_task("正在设置构建环境...", total=None)
                if not all([
                    await BuildService.setup_remote_buildx(),
                    await BuildService.setup_remote_qemu(),
                    await BuildService.setup_remote_binfmt()
                ]):
                    return False
                progress.update(task, completed=True)
                
                # 构建镜像
                task = progress.add_task("正在构建镜像...", total=None)
                if not await BuildService._build_image_on_remote():
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
            BuildService.sh.disconnect()


def main() -> None:
    """主函数"""
    if not BuildService.build():
        sys.exit(1)

if __name__ == "__main__":
    main() 



