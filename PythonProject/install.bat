@echo off
echo 开始安装部署工具...

:: 检查Python版本
python --version
if %ERRORLEVEL% NEQ 0 (
    echo Python未安装，请先安装Python 3.8或更高版本
    exit /b 1
)

:: 创建虚拟环境
echo 创建虚拟环境...
python -m venv .venv
call .venv\Scripts\activate.bat

:: 安装依赖（使用setup.py）
echo 安装依赖...
pip install -e .

:: 安装PyInstaller
echo 安装PyInstaller...
pip install pyinstaller

:: 构建可执行文件
echo 构建可执行文件...
python build_executable.py

echo 安装完成!
echo 可执行文件位于: %CD%\dist\deploy_tool.exe
echo 您可以将可执行文件复制到系统路径中，或直接运行它

pause 