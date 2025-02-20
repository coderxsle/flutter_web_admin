"""
统一命令行入口
"""
import sys
import argparse

from utils.log_utils import log_error

def main() -> None:
    """主函数"""
    parser = argparse.ArgumentParser(description="部署工具集")
    parser.add_argument('command', choices=[
        'build', 'deploy', 'backup', 'rollback', 
        'validate', 'clear', 'package', 'clearssh'
    ])
    parser.add_argument('env', help="环境名称 (prod/test/staging)")
    parser.add_argument('version', nargs='?', help="版本号")
    parser.add_argument('--keep', type=int, help="保留版本数量")
    
    args = parser.parse_args()
    
    # 根据命令导入相应模块
    try:
        module = __import__(args.command)
        if hasattr(module, 'main'):
            sys.argv = [sys.argv[0]] + sys.argv[2:]  # 重置参数
            module.main()
        else:
            log_error(f"模块 {args.command} 没有 main 函数")
    except ImportError:
        log_error(f"未找到模块: {args.command}")
        sys.exit(1)

if __name__ == "__main__":
    main() 