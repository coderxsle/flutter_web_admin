# Docker 部署工具

这是一个用于 Docker 镜像构建、打包和部署的自动化工具。

## 功能特点

- 支持多架构镜像构建（amd64/arm64）
- 自动化的部署流程
- 美化的终端输出界面
- 完整的错误处理和日志记录
- 支持远程服务器操作

## 安装

1. 创建虚拟环境：
```bash
python -m venv .venv
source .venv/bin/activate  # Linux/Mac
# 或
.venv\Scripts\activate  # Windows
```

2. 安装依赖：
```bash
pip install -r requirements.txt
```

3. 安装开发模式：
```bash
pip install -e .
```

## 配置

1. 创建环境配置文件 `.env.prod`：
```bash
DEPLOY_ENV=prod
DEPLOY_VERSION=1.0.0
SERVER_USER=your-username
SERVER_IP=your-server-ip
DEPLOY_PATH=/opt/book_store
```

2. 创建部署配置文件 `config.yaml`：
```yaml
env: prod
version: 1.0.0
host: your-server-host
port: 22
username: your-username
deploy_path: /opt/book_store
```

## 使用方法

运行部署工具：
```bash
# 方式1：直接运行入口脚本
python run.py

# 方式2：作为Python模块运行
python -m deploy_tool.scripts.main
```

选择要执行的操作：
1. 构建镜像
2. 打包镜像
3. 部署镜像
4. 执行所有步骤
5. 退出

## 目录结构

```

deploy_tool/
├── scripts/           # 核心功能模块
│   ├── __init__.py
│   ├── main.py       # 主程序入口
│   ├── build.py      # 构建服务
│   ├── package.py    # 打包服务
│   ├── deploy.py     # 部署服务
│   └── validate.py   # 验证服务
├── utils/            # 工具类
│   ├── __init__.py
│   ├── log_utils.py  # 日志工具
│   ├── env_utils.py  # 环境变量工具
│   └── ssh_utils.py  # SSH工具
├── config/           # 配置文件
│   ├── config.yaml.template  # 配置文件模板
│   └── .env.template        # 环境变量模板
├── run.py            # 运行入口
├── setup.py          # 安装配置
└── README.md         # 项目文档

```

## 注意事项

1. 确保已安装 Docker 并启动服务
2. 确保有访问远程服务器的 SSH 密钥
3. 确保远程服务器已安装 Docker 和 Docker Compose
4. 确保有足够的磁盘空间用于构建和存储镜像 