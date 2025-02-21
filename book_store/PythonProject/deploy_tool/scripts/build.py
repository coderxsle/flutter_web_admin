"""
Docker 镜像构建模块
"""

import os
import sys
import time
import hashlib
import shutil
from pathlib import Path
from typing import Optional

from utils import log_info, log_error, SSHClient
from utils.env_utils import load_env
from utils.system_utils import SystemUtils
from fabric import Connection


class BuildService:
    def __init__(self):
        self.sh = SSHClient()
        self.system_utils = SystemUtils()

    @classmethod
    def build(cls, env: str, version: str) -> bool:
        """公开的构建方法"""
        # 创建 BuildService 实例
        instance = cls()
        
        # 检查架构
        arch_result, build_platform = instance.system_utils.check_architecture()
        if not arch_result or not build_platform:
            log_error("架构检查失败")
            return False
        
        # 记录开始时间
        start_time = time.time()
        
        # 设置缓存目录
        cache_dir = instance.get_cache_dir(build_platform)
        current_cache_hash = instance.get_cache_hash(cache_dir)
        
        image_name = os.getenv('IMAGE_NAME', '')
        if not image_name:
            log_error("未设置 IMAGE_NAME 环境变量")
            return False
        
        log_info(f"开始构建镜像: {image_name}:{version} (平台: {build_platform})")
            
        # 设置构建环境
        if not all([instance._setup_buildx(), instance._setup_qemu(), instance._setup_binfmt()]):
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
        if instance.sh.run(" ".join(build_cmd)).return_code != 0:
            log_error("镜像构建失败")
            return False
        
        # 更新缓存
        new_cache_dir = Path(str(cache_dir) + '-new')
        if new_cache_dir.exists():
            new_cache_hash = instance.get_cache_hash(new_cache_dir)
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

    def _setup_buildx(self) -> bool:
        """设置 buildx 构建器"""
        try:
            self.sh.run("docker buildx rm multiarch-builder 2>/dev/null || true")
            result = self.sh.run("docker buildx create --name multiarch-builder --use")
            if result.return_code != 0:
                log_error("创建构建器失败")
                return False
            return True
        except Exception as e:
            log_error(f"设置 buildx 失败: {e}")
            return False

    def _setup_qemu(self) -> bool:
        """设置 QEMU 支持"""
        try:
            result = self.sh.run("docker images -q multiarch/qemu-user-static:latest 2>/dev/null")
            if result.return_code != 0:
                log_info("拉取 multiarch/qemu-user-static 镜像...")
                if self.sh.run("docker pull multiarch/qemu-user-static:latest").return_code != 0:
                    log_error("拉取 multiarch/qemu-user-static 失败")
                    return False
            
            if self.sh.run("docker run --rm --privileged multiarch/qemu-user-static --reset -p yes").return_code != 0:
                log_error("无法启动 multiarch/qemu-user-static")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 QEMU 失败: {e}")
            return False

    def _setup_binfmt(self) -> bool:
        """设置 binfmt 支持"""
        try:
            result = self.sh.run("docker images -q tonistiigi/binfmt:latest 2>/dev/null")
            if result.return_code != 0:
                log_info("拉取 tonistiigi/binfmt 镜像...")
                if self.sh.run("docker pull tonistiigi/binfmt:latest").return_code != 0:
                    log_error("拉取 tonistiigi/binfmt 失败")
                    return False
            
            if self.sh.run("docker run --rm --privileged tonistiigi/binfmt --install all").return_code != 0:
                log_error("无法安装 binfmt")
                return False
                
            return True
        except Exception as e:
            log_error(f"设置 binfmt 失败: {e}")
            return False


def main() -> None:
    """主函数"""
    conn = Connection('localhost')  # 或者连接到远程服务器
    builder = BuildService()
    
    env = os.getenv('BUILD_ENV', 'production')  # 示例环境变量
    version = os.getenv('BUILD_VERSION', 'latest')  # 示例版本变量
    
    if not builder.build(env, version):
        sys.exit(1)

if __name__ == "__main__":
    main() 



