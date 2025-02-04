# 生产环境部署说明

1. 首次部署时：
   ```bash
   # 复制环境变量模板
   cp .env.example .env.production
   
   # 编辑 .env 文件，设置实际的生产环境密码
   vim .env.production
   
   # 启动服务
   docker compose up -d
   ```

2. 更新部署时：
   ```bash
   # 拉取最新代码
   git pull
   
   # 重新构建并启动（保持现有的 .env 文件）
   docker compose up --build -d
   ```

注意：
- 确保 .env 文件包含了所有必需的环境变量
- 不要将 .env 文件提交到代码仓库
- 妥善保管生产环境的密码