"""
打包模块，用于将 Docker 镜像打包成文件
"""
import os
import sys
from pathlib import Path

from utils.log_utils import log_info, log_error
from utils.env_utils import load_env

def show_usage() -> None:
    """显示使用方法"""
    log_error("使用方法: python package.py <环境> <版本>")
    log_info("示例: python package.py prod 1.0.0")
    sys.exit(1)

def package_image(env: str, version: str) -> bool:
    """
    打包 Docker 镜像
    
    Args:
        env: 环境名称
        version: 版本号
    
    Returns:
        bool: 打包是否成功
    """
    image_name = os.getenv('IMAGE_NAME', '')
    if not image_name:
        log_error("未设置 IMAGE_NAME 环境变量")
        return False
    
    # 检查镜像是否存在
    cmd = f"docker image inspect {image_name}:{version}"
    if os.system(f"{cmd} >/dev/null 2>&1") != 0:
        log_error(f"镜像 {image_name}:{version} 不存在")
        log_info("请先运行 build.sh 构建镜像")
        return False
    
    # 设置输出文件名
    output_file = f"{image_name}-{env}-{version}.tar"
    
    log_info(f"开始保存镜像: {image_name}:{version}")
    if os.system(f"docker save -o {output_file} {image_name}:{version}") != 0:
        log_error("保存镜像失败")
        return False
    
    log_info(f"镜像已保存成功: {output_file}")
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
    
    # 执行打包
    if not package_image(env, version):
        sys.exit(1)

if __name__ == "__main__":
    main() 