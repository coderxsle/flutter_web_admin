# # 基础依赖
# PyYAML>=6.0.1        # YAML 配置文件支持
# requests>=2.31.0     # HTTP 请求支持
# urllib3<2.0.0       # 兼容 LibreSSL
# paramiko>=3.3.1      # SSH 连接支持
# scp>=0.14.5         # SCP 文件传输支持
# tqdm>=4.66.1        # 进度条支持
# rich>=13.6.0        # 终端美化支持
# halo>=0.0.31        # 终端加载动画
# alive-progress>=3.1.5  # 动画进度条
# yaspin>=2.5.0       # 终端旋转器

# # ***************************************************
# rich>=13.9.4         # 终端美化支持
# fabric>=3.2.2       # 远程部署工具
# typer>=0.15.1         # CLI工具
# pydantic>=2.6.1     # 数据验证
# python-dotenv>=1.0.0 # 环境变量管理
# # ???
# docker>=7.0.0        # Docker SDK
# # ***************************************************
# # 开发依赖
# black>=23.9.1        # 代码格式化
# mypy>=1.5.1          # 类型检查
# pytest>=7.4.2        # 单元测试 

from setuptools import setup, find_packages

setup(
    name="deploy_tool",
    version="1.0.0",
    description="Docker镜像构建、打包和部署的自动化工具",
    packages=find_packages(),
    package_data={
        'deploy_tool': [
            'config/*.yaml.template',
            'config/.env.template',
        ],
    },
    install_requires=[
        "PyYAML>=6.0.1",        # YAML 配置文件支持
        "requests>=2.31.0",      # HTTP 请求支持
        "urllib3<2.0.0",         # 兼容 LibreSSL
        "paramiko>=3.3.1",       # SSH 连接支持
        "scp>=0.14.5",          # SCP 文件传输支持
        "fabric>=3.2.2",         # 远程部署工具
        "typer>=0.9.0",         # CLI工具
        "rich>=13.9.4",         # 终端美化支持
        "docker>=7.0.0",        # Docker SDK
        "pydantic>=2.6.1",      # 数据验证
        "python-dotenv>=1.0.0",  # 环境变量管理
    ],
    entry_points={
        "console_scripts": [
            "deploy-tool=deploy_tool.scripts.main:app",
        ],
    },
    python_requires=">=3.8",
    author="Your Name",
    author_email="your.email@example.com",
    url="https://github.com/yourusername/deploy_tool",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Developers",
        "Topic :: Software Development :: Build Tools",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
) 
