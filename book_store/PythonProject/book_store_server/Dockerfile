FROM python:3.11-slim as build

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . book_store_server/
COPY ../book_store_shared book_store_shared/

# 安装依赖
RUN pip install --no-cache-dir -r book_store_server/requirements.txt

# 设置环境变量
ENV PYTHONPATH=/app

# 启动命令
CMD ["python", "book_store_server/main.py"] 