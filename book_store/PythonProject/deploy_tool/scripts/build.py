"""
Docker 镜像构建模块
"""

import sys
import time
import hashlib
import shutil
from pathlib import Path
from typing import Optional
import asyncio  # 确保导入 asyncio
import platform

from utils import log_info, log_error, SSHClient, EnvUtils
from utils.system_utils import SystemUtils
from utils.progress import Progress

class BuildService:
    sh = SSHClient()

    @staticmethod
    async def build() -> bool:
        """公开的构建方法"""
        
        env = EnvUtils.get_env('BUILD_ENV')  # 示例环境变量
        version = EnvUtils.get_env('VERSION')  # 示例版本变量
        
        # 检查架构
        arch_result, build_platform = SystemUtils.check_architecture()
        log_info(f"架构检查成功，构建平台: {build_platform}")
        if not arch_result or not build_platform:
            log_error("架构检查失败")
            sys.exit(1)
        
        # 记录开始时间
        start_time = time.time()
        
        # 设置缓存目录
        cache_dir = BuildService.get_cache_dir(build_platform)
        current_cache_hash = BuildService.get_cache_hash(cache_dir)
        
        image_name = EnvUtils.get_env('IMAGE_NAME', '')
        if not image_name:
            log_error("未设置 IMAGE_NAME 环境变量")
            sys.exit(1)
        
        log_info(f"开始构建镜像: {image_name}:{version} (平台: {build_platform})")
            
        # 设置构建环境
        if not await BuildService._setup_buildx(build_platform):
            log_error("构建失败")
            sys.exit(1)
        
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
            f"-f ./Dockerfile",  # Dockerfile 路径
            "../",  # 构建上下文路径改为上级目录
        ]
        
        # 执行构建
        result = BuildService.sh.local_run(" ".join(build_cmd))
        if not result:
            log_error("镜像构建失败")
            sys.exit(1)
        
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
    async def _setup_buildx(build_platform: str) -> bool:
        """设置 buildx 构建器"""
        try:

            log_info("检查并安装 QEMU 和 binfmt 支持...")
            # 选择正确的 QEMU 运行环境
            log_info(f"使用 Docker 平台架构: {build_platform}")


            # 需求	
            # Docker 构建多架构镜像 (buildx build --platform)
            #       需要安装的组件：✅tonistiigi/binfmt
            # 运行 ARM64（或其他架构）的 Docker 容器 (docker run --platform=linux/arm64)	
            #       需要安装的组件：✅ multiarch/qemu-user-static
            # 在主机环境（非 Docker）运行 ARM64 ELF 二进制
            #       需要安装的组件：✅ multiarch/qemu-user-static

            # 1. 安装 QEMU 支持
            # log_info("检查 QEMU 支持...")
            # qemu_check = BuildService.sh.local_run("docker images -q multiarch/qemu-user-static 2>/dev/null")
            # if not qemu_check:
            #     log_info("拉取 tonistiigi/binfmt 镜像...")
            #     pull_qemu = BuildService.sh.local_run("docker pull multiarch/qemu-user-static:latest")
            #     if not pull_qemu:
            #         log_error("拉取 multiarch/qemu-user-static 失败")
            #         return False
            
            # # 2. 启动 QEMU 支持
            # log_info("安装 QEMU 支持...")
            # run_result = BuildService.sh.local_run("docker run --rm --privileged multiarch/qemu-user-static --reset -p yes")
            # if not run_result:
            #     log_error("无法安装 QEMU")
            #     return False
            

            # 3. 安装 binfmt 支持
            log_info("检查 binfmt 支持...")
            binfmt_result = BuildService.sh.local_run("docker images -q tonistiigi/binfmt:latest 2>/dev/null")
            if not binfmt_result:
                log_info("拉取 tonistiigi/binfmt 镜像...")
                pull_result = BuildService.sh.local_run("docker pull tonistiigi/binfmt:latest")
                if not pull_result:
                    log_error("拉取 tonistiigi/binfmt 失败")
                    return False
                        

            # 4. 启动 binfmt 支持
            log_info("安装 binfmt 支持...")
            run_result = BuildService.sh.local_run("docker run --rm --privileged tonistiigi/binfmt:latest --install all")
            if not run_result:
                log_error("无法安装 binfmt")
                return False


            # 5. 验证 binfmt 安装
            verify_result = BuildService.sh.local_run("docker run --rm --platform=linux/arm64 alpine uname -m")

            if not verify_result:
                log_error("跨平台支持验证失败")
                return False


            log_info("QEMU 和 binfmt 安装成功！跨平台支持设置成功!")

            log_info("删除旧的 buildx 构建器...")
            BuildService.sh.local_run("docker buildx rm multiarch-builder 2>/dev/null")
            log_info("创建新的 buildx 构建器...")
            result = BuildService.sh.local_run("docker buildx create --name multiarch-builder --use")
            if not result:
                log_error("创建构建器失败")
                return False
            
            log_info("buildx 构建器创建成功")

            return True
        except Exception as e:
            log_error(f"设置跨平台支持失败: {e}")
            return False




def main() -> None:
    """主函数"""

    # 执行构建
    if not BuildService.build():
        log_error("构建失败，程序终止")
        sys.exit(1)

if __name__ == "__main__":
    main() 



