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



# Book Store 部署指南
### 1. 前置准备
1. 确保服务器已安装必需工具：
```
# 检查必需工具
docker --version
curl --version
jq --version
```
2. 配置华为云镜像仓库凭证：
```
# 编辑生产环境配置文件
vim env/.env.production

# 设置以下变量
HUAWEI_REGISTRY_NAMESPACE=book-store
HUAWEI_REGISTRY_USERNAME=cn-east-3@book-store
HUAWEI_REGISTRY_PASSWORD=your-actual-registry-password
```
3. 配置 Portainer 凭证：
```
# 在同一个配置文件中设置
PORTAINER_USERNAME=admin
PORTAINER_PASSWORD=your-actual-portainer-password
```

### 2. 部署脚本使用
基本用法
1. 部署到生产环境，指定版本号
```
./deploy/deploy_to_server.sh prod 1.0.0
```

2. 部署到测试环境，指定版本号
```
./deploy/deploy_to_server.sh test 1.0.0
```

3. 强制重新部署（跳过某些检查）：
```
# 只有在使用 --force 参数时才会禁用缓存
# 避免不必要的基础镜像拉取
./deploy/deploy_to_server.sh prod 1.0.0 --force
```

查看帮助信息
```
./deploy/deploy_to_server.sh --help
```

### 3. 部署过程说明
部署脚本会自动执行以下步骤：
1. 环境检查和初始化
2. 数据库备份（可配置）
3. 构建并推送 Docker 镜像
4. 更新 Portainer 堆栈
5. 健康检查和验证
6. 部署状态通知

### 4. 配置说明
部署配置 (deploy.config)
```
# 编辑部署配置
vim deploy/deploy.config

# 主要配置项：
DEPLOY_TIMEOUT=300       # 部署超时时间（秒）
KEEP_BACKUP_DAYS=7       # 保留备份天数
KEEP_IMAGES=3            # 保留最新的镜像数量
DB_BACKUP_ENABLED=true   # 是否启用数据库备份
```

环境变量配置
```
# 生产环境
vim env/.env.production

# 测试环境
vim env/.env.test
```
### 5. 监控和维护
```
# 查看部署历史
cat deploy/deploy_history.log

# 查看详细日志
cat logs/deploy.log
```

查看容器状态
```
# 查看所有相关容器
docker ps --filter "name=book-store"

# 查看容器日志
docker logs book-store-prod-server-1
```

数据库备份管理
```
# 查看备份文件
ls -l backups/prod/

# 手动触发备份
docker exec prod-postgres-1 pg_dump -U postgres flutter_web_admin > backup.sql
```

### 6. 故障处理
如果部署失败：
1. 检查日志文件：
```
cat logs/deploy.log
```
2. 手动回滚（如果自动回滚失败）：
```
# 使用上一个版本重新部署
./deploy/deploy_to_server.sh prod 1.0.0 --force
```
3. 检查服务健康状态：
```
curl http://localhost:8080/health
```

### 7. 最佳实践
1. 总是在测试环境先验证：
```
# 先部署到测试环境
./deploy/deploy_to_server.sh test 1.0.0

# 验证无误后再部署到生产环境
./deploy/deploy_to_server.sh prod 1.0.0
```

2. 定期检查和维护：
```
# 清理旧镜像
docker image prune

# 清理旧备份
find backups/ -mtime +7 -delete
```



