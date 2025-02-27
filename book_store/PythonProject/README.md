# 部署工具

这是一个用于Docker镜像构建、打包和部署的自动化工具。

## 功能特点

- 构建Docker镜像
- 打包Docker镜像
- 远程部署Docker镜像
- 支持多环境配置（生产、测试、开发）

## 系统要求

- Python 3.8 或更高版本
- 操作系统：Windows、macOS 或 Linux

## 安装方法

### 方法一：使用安装脚本（推荐）

#### Linux/macOS:

```bash
# 克隆仓库
git clone https://your-repository-url/deploy_tool.git
cd deploy_tool

# 运行安装脚本
chmod +x install.sh
./install.sh
```

#### Windows:

```bash
# 克隆仓库
git clone https://your-repository-url/deploy_tool.git
cd deploy_tool

# 运行安装脚本
install.bat
```

### 方法二：手动安装

```bash
# 克隆仓库
git clone https://your-repository-url/deploy_tool.git
cd deploy_tool

# 创建虚拟环境
python -m venv .venv
source .venv/bin/activate  # Linux/macOS
# 或
.venv\Scripts\activate.bat  # Windows

# 安装依赖
pip install -e .  # 使用setup.py安装

# 安装PyInstaller
pip install pyinstaller

# 构建可执行文件
python build_executable.py
```

## 使用方法

### 方法一：使用可执行文件

安装完成后，可以直接运行生成的可执行文件：

```bash
# Linux/macOS
./dist/deploy_tool

# Windows
.\dist\deploy_tool.exe
```

### 方法二：使用Python脚本

```bash
# 确保已激活虚拟环境
python deploy_tool/run.py
```

## 配置说明

部署工具使用YAML配置文件和环境变量来管理不同环境的配置。配置文件位于`deploy_tool/config/`目录下。

### 环境配置

- `production`：生产环境
- `test`：测试环境
- `development`：开发环境

## 常见问题

1. **问题**：安装过程中出现依赖错误
   **解决方案**：确保您的Python版本为3.8或更高，并尝试手动安装依赖：`pip install -e .`

2. **问题**：执行可执行文件时出现权限错误
   **解决方案**：为文件添加执行权限：`chmod +x dist/deploy_tool`

## 贡献指南

欢迎提交问题和拉取请求！

## 许可证

[MIT](LICENSE) 