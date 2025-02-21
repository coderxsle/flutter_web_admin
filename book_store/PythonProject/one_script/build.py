"""
Docker 镜像构建模块
"""
import os
import sys
import time
import hashlib
import shutil
from pathlib import Path
from typing import Optional, Tuple

from utils.log_utils import log_info, log_error, log_warn
from utils.env_utils import load_env
from utils.system_utils import check_architecture, verify_docker_service, verify_docker_hub_connection

def show_usage() -> None:
    """显示使用方法"""
    log_warn("使用方法: python build.py <环境> <版本>")
    log_info("示例: python build.py prod 1.0.0")
    sys.exit(1)

def get_cache_dir(platform: str) -> Path:
    """获取缓存目录"""
    # 将 linux/amd64 转换为 linux-amd64
    platform_suffix = platform.replace('/', '-')
    cache_dir = Path.home() / '.docker' / 'cache' / platform_suffix
    cache_dir.mkdir(parents=True, exist_ok=True)
    return cache_dir

def get_cache_hash(cache_dir: Path) -> Optional[str]:
    """获取缓存哈希值"""
    index_file = cache_dir / 'index.json'
    if not index_file.exists():
        return None
    
    with open(index_file, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()

def setup_buildx() -> bool:
    """设置 buildx 构建器"""
    try:
        # 清理并重新创建 buildx 构建器
        os.system("docker buildx rm multiarch-builder 2>/dev/null || true")
        result = os.system("docker buildx create --name multiarch-builder --use")
        if result != 0:
            log_error("创建构建器失败")
            return False
        return True
    except Exception as e:
        log_error(f"设置 buildx 失败: {e}")
        return False

def setup_qemu() -> bool:
    """设置 QEMU 支持"""
    try:
        # 检查 QEMU 镜像
        result = os.system("docker images -q multiarch/qemu-user-static:latest 2>/dev/null")
        if result != 0:
            log_info("拉取 multiarch/qemu-user-static 镜像...")
            if os.system("docker pull multiarch/qemu-user-static:latest") != 0:
                log_error("拉取 multiarch/qemu-user-static 失败")
                return False
        
        # 运行 QEMU
        if os.system("docker run --rm --privileged multiarch/qemu-user-static --reset -p yes") != 0:
            log_error("无法启动 multiarch/qemu-user-static")
            return False
            
        return True
    except Exception as e:
        log_error(f"设置 QEMU 失败: {e}")
        return False

def setup_binfmt() -> bool:
    """设置 binfmt 支持"""
    try:
        # 检查 binfmt 镜像
        result = os.system("docker images -q tonistiigi/binfmt:latest 2>/dev/null")
        if result != 0:
            log_info("拉取 tonistiigi/binfmt 镜像...")
            if os.system("docker pull tonistiigi/binfmt:latest") != 0:
                log_error("拉取 tonistiigi/binfmt 失败")
                return False
        
        # 运行 binfmt
        if os.system("docker run --rm --privileged tonistiigi/binfmt --install all") != 0:
            log_error("无法安装 binfmt")
            return False
            
        return True
    except Exception as e:
        log_error(f"设置 binfmt 失败: {e}")
        return False

def build(env: str, version: str) -> bool:
    """
    构建 Docker 镜像
    
    Args:
        env: 环境名称
        version: 版本号
    
    Returns:
        bool: 构建是否成功
    """
    log_info(f"构建环境: {env} 构建版本: {version}")
    
    # 检查架构
    arch_result, build_platform = check_architecture()
    if not arch_result or not build_platform:
        log_error("架构检查失败")
        return False
    
    # 记录开始时间
    start_time = time.time()
    
    # 设置缓存目录
    cache_dir = get_cache_dir(build_platform)
    current_cache_hash = get_cache_hash(cache_dir)
    
    image_name = os.getenv('IMAGE_NAME', '')
    if not image_name:
        log_error("未设置 IMAGE_NAME 环境变量")
        return False
    
    log_info(f"开始构建镜像: {image_name}:{version} (平台: {build_platform})")
    
    # 设置构建环境
    if not all([setup_buildx(), setup_qemu(), setup_binfmt()]):
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
    if os.system(" ".join(build_cmd)) != 0:
        log_error("镜像构建失败")
        return False
    
    # 更新缓存
    new_cache_dir = Path(str(cache_dir) + '-new')
    if new_cache_dir.exists():
        new_cache_hash = get_cache_hash(new_cache_dir)
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

def main() -> None:
    """主函数"""
    if len(sys.argv) < 3:
        show_usage()
    
    env = sys.argv[1]
    version = sys.argv[2]
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行构建
    if not build(env, version):
        sys.exit(1)

if __name__ == "__main__":
    main() 