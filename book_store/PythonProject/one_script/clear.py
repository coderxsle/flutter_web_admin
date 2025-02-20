"""
清理模块，用于清理旧的 Docker 镜像和相关资源
"""
import os
import sys
from typing import Optional

from utils.log_utils import log_info, log_error
from utils.env_utils import load_env
from utils.ssh_utils import ssh_execute

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python clear.py <环境> [保留版本数]")
    log_info("示例: python clear.py prod 3")
    sys.exit(1)

def cleanup_old_images(keep_versions: int = 3) -> bool:
    """
    清理旧的 Docker 镜像
    
    Args:
        keep_versions: 保留的版本数量，默认为3
        
    Returns:
        bool: 清理是否成功
    """
    log_info("清理旧镜像...")
    
    registry = os.getenv('REGISTRY', '')
    namespace = os.getenv('NAMESPACE', '')
    image_name = os.getenv('IMAGE_NAME', '')
    
    if not all([image_name]):  # registry 和 namespace 可选
        log_error("缺少必要的镜像配置信息")
        return False
    
    # 构建镜像名称模式
    image_pattern = f"{registry}/{namespace}/{image_name}*" if registry and namespace else f"{image_name}*"
    
    # 获取所有相关镜像，按创建时间排序
    cmd = f"""
    images=$(docker images '{image_pattern}' --format "{{{{.Repository}}}}:{{{{.Tag}}}}" | sort -r)
    count=$(echo "$images" | wc -l)
    if [ $count -gt {keep_versions} ]; then
        echo "$images" | tail -n $(($count - {keep_versions})) | xargs -r docker rmi
    fi
    """
    
    try:
        if not ssh_execute(cmd):
            log_error("清理镜像失败")
            return False
            
        log_info(f"成功清理旧镜像，保留最新的 {keep_versions} 个版本")
        return True
    except Exception as e:
        log_error(f"清理过程中发生错误: {e}")
        return False

def main() -> None:
    """主函数"""
    if len(sys.argv) < 2:
        show_usage()
    
    env = sys.argv[1]
    keep_versions = int(sys.argv[2]) if len(sys.argv) > 2 else 3
    
    if keep_versions < 1:
        log_error("保留版本数必须大于0")
        sys.exit(1)
    
    # 加载环境变量
    if not load_env(env):
        sys.exit(1)
    
    # 执行清理
    if not cleanup_old_images(keep_versions):
        sys.exit(1)
    
    log_info("清理完成")

if __name__ == "__main__":
    main() 