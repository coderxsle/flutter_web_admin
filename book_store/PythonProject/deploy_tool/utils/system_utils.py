"""
系统工具模块，用于系统相关的操作和检查
"""

import sys
import platform
from typing import Tuple, Optional
from .log_utils import log_info, log_error, log_warn
from .ssh_client import SSHClient

sh = SSHClient()

class SystemUtils:

    def check_required_tools(self) -> bool:
        """检查必需的工具是否已安装"""
        required_tools = ["docker", "curl", "ssh"]
        
        for tool in required_tools:
            try:
                result = self.sh.run(f"which {tool}")
                if result.return_code != 0:
                    log_error(f"命令 '{tool}' 未找到，请先安装")
                    return False
            except Exception as e:
                log_error(f"检查工具 '{tool}' 时发生错误: {e}")
                return False
        
        # 检查 Docker 版本
        try:
            docker_version = self.sh.run("docker version --format '{{.Server.Version}}'").stdout.strip()  # 使用封装好的 run 方法
            if docker_version >= "19.03":
                log_info(f"Docker 版本 ({docker_version}) 支持多架构构建")
            else:
                log_warn(f"Docker 版本 ({docker_version}) 可能不支持多架构构建，建议升级到 19.03 或更高版本")
        except Exception as e:
            log_error("无法获取 Docker 版本信息")
            return False
            
        return True

    def get_system_arch(self) -> str:
        """获取系统架构"""
        arch = platform.machine()
        arch_map = {
            "x86_64": "amd64",
            "aarch64": "arm64"
        }
        return arch_map.get(arch, arch)

    def check_architecture(self) -> Tuple[bool, Optional[str]]:
        """检查系统架构并设置构建平台"""
        log_info("检查系统架构...")
        if not self.check_required_tools():
            return False, None
            
        local_arch = self.get_system_arch()
        
        log_info("获取远程服务器架构...")
        try:
            output = self.sh.run("uname -m").stdout.strip()
            if not output:
                log_error("无法获取远程服务器架构")
                return False, None
                
            remote_arch = output
            if remote_arch == "x86_64":
                remote_arch = "amd64"
            elif remote_arch == "aarch64":
                remote_arch = "arm64"
            else:
                log_error(f"不支持的架构: {remote_arch}")
                return False, None
                
            log_info(f"本地架构: {local_arch}")
            log_info(f"远程架构: {remote_arch}")
            
            build_platform = f"linux/{remote_arch}"
            if local_arch != remote_arch:
                log_warn(f"本地架构与远程服务器架构不同，将使用 {build_platform} 进行构建")
                
            return True, build_platform
            
        except Exception as e:
            log_error(f"检查架构时发生错误: {str(e)}")
            return False, None

    def verify_docker_service(self) -> bool:
        """验证 Docker 服务状态"""
        log_info("验证 Docker 服务状态...")
        
        for i in range(30):
            try:
                result = self.sh.run("docker info")
                if result.return_code == 0:
                    log_info("Docker 服务正常!")
                    return True
            except Exception:
                pass
                
            if i == 29:
                log_error("Docker 服务异常!")
                return False
                
            print(f"\r正在等待 Docker 服务就绪...（{i+1}/30）", end="", flush=True)
            self.sh.run("sleep 2")
            
        return False

    def verify_docker_hub_connection(self) -> bool:
        """验证与 Docker Hub 的连接"""
        log_info("验证镜像仓库连接...")
        
        for i in range(30):
            try:
                result = self.sh.run("docker pull hello-world")
                if result.return_code == 0:
                    log_info("镜像仓库连接正常！")
                    return True
            except Exception:
                pass
                
            if i == 29:
                log_error("Docker 镜像仓库连接超时!")
                return False
                
            print(f"\r正在等待 Docker 镜像仓库连接...（{i+1}/30）", end="", flush=True)
            self.sh.run("sleep 2")
            
        return False



def main() -> None:
    """主函数"""
    system_utils = SystemUtils()  # 创建 SystemUtils 实例
    if not system_utils.verify_docker_service():  # 通过实例调用
        sys.exit(1)

if __name__ == "__main__":
    main()