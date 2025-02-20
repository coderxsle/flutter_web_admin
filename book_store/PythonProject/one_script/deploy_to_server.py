"""
部署入口脚本，整合所有部署功能
"""
import os
import sys
import warnings
from pathlib import Path
from typing import Optional

# 过滤 urllib3 的 SSL 警告
warnings.filterwarnings('ignore', category=Warning)

from utils.log_utils import log_info, log_error
from utils.env_utils import load_env
from utils.lock import deploy_lock
from utils.config_manager import config_manager

def show_menu() -> Optional[str]:
    """显示菜单并获取用户选择"""
    log_info("请选择要执行的步骤:")
    print("1) 构建镜像")
    print("2) 打包镜像")
    print("3) 部署镜像")
    print("4) 执行所有步骤")
    print("q) 退出")
    
    choice = input("请输入选项 [1-4/q]: ").strip()
    print()
    return choice if choice in ['1', '2', '3', '4', 'q', 'Q'] else None

def execute_step(step: str, env: str, version: str) -> bool:
    """
    执行指定的部署步骤
    
    Args:
        step: 步骤名称
        env: 环境名称
        version: 版本号
    
    Returns:
        bool: 执行是否成功
    """
    step_map = {
        '1': ('build', '构建'),
        '2': ('package', '打包'),
        '3': ('deploy', '部署'),
    }
    
    if step in step_map:
        module_name, step_name = step_map[step]
        log_info(f"开始{step_name}...")
        try:
            module = __import__(module_name)
            return module.main([env, version]) == 0
        except ImportError:
            log_error(f"未找到模块: {module_name}")
            return False
        except Exception as e:
            log_error(f"{step_name}过程中发生错误: {e}")
            return False
    
    return False

def execute_all_steps(env: str, version: str) -> bool:
    """
    执行所有部署步骤
    
    Args:
        env: 环境名称
        version: 版本号
    
    Returns:
        bool: 执行是否成功
    """
    steps = [
        ('1', '构建'),
        ('2', '打包'),
        ('3', '部署')
    ]
    
    for step, step_name in steps:
        log_info(f"{len(steps)}. 开始{step_name}...")
        if not execute_step(step, env, version):
            log_error(f"{step_name}失败")
            return False
    
    return True

def main() -> int:
    """主函数"""
    # 检查命令行参数
    if len(sys.argv) < 3:
        log_error("使用方法: python deploy_to_server.py <环境> <版本>")
        log_info("示例: python deploy_to_server.py prod 1.0.0")
        return 1
    
    env = sys.argv[1]
    version = sys.argv[2]
    
    # 加载环境变量
    if not load_env(env):
        return 1
    
    # 使用部署锁
    with deploy_lock(env) as lock_acquired:
        if not lock_acquired:
            log_error("无法获取部署锁，可能有其他部署正在进行")
            return 1
        
        while True:
            choice = show_menu()
            if not choice:
                log_error("无效的选项")
                continue
            
            if choice.lower() == 'q':
                log_info("退出脚本")
                break
            
            success = False
            if choice == '4':
                success = execute_all_steps(env, version)
            else:
                success = execute_step(choice, env, version)
            
            if not success:
                return 1
            
            # 询问是否继续
            continue_choice = input("是否继续? [y/N]: ").strip().lower()
            if continue_choice != 'y':
                break
    
    log_info("部署完成!")
    return 0

if __name__ == "__main__":
    # 设置工作目录
    os.chdir(str(Path(__file__).parent.parent))
    
    # 确保所有 Python 文件有执行权限
    for script in Path('scripts').glob('**/*.py'):
        script.chmod(0o755)
    
    sys.exit(main()) 