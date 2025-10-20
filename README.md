<p align="center">
  <a href="https://community.vaunt.dev/board/coderxsle/achievements">
    <img src="https://api.vaunt.dev/v1/github/entities/coderxsle/achievements/9fc50df5-1830-4e10-afcf-db4006ae5210?format=svg&style=raw" width="300"/>
  </a>
</p>

<h1 align="center">📚 Flutter Web Admin 后台管理系统</h1>

<p align="center">
  基于 Serverpod + Flutter + PostgreSQL + Redis 构建的全栈后台管理系统
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Serverpod-Latest-blue" alt="Serverpod">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/PostgreSQL-15+-green" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Redis-7+-red" alt="Redis">
  <img src="https://img.shields.io/badge/Dart-3.x-blue" alt="Dart">
</p>

---

## 📖 项目简介

这是一个现代化的全栈后台管理系统，采用 Serverpod 作为后端框架，Flutter Web 作为前端，PostgreSQL 作为主数据库，Redis 作为缓存层。项目使用 Monorepo 架构进行管理，通过 Melos 工具实现多包协同开发。

### ✨ 核心特性

- 🚀 **高性能后端**：基于 Serverpod 框架，提供 RESTful API 和实时通信能力
- 💎 **现代化前端**：使用 Flutter Web 构建响应式管理界面
- 🗄️ **强大的数据层**：PostgreSQL 关系型数据库 + Redis 缓存
- 📦 **Monorepo 架构**：使用 Melos 管理多个相关包
- 🔄 **类型安全**：前后端共享数据模型，自动生成客户端代码
- 🐳 **容器化部署**：支持 Docker 和 Docker Compose 一键部署
- 🔐 **安全可靠**：完善的身份认证和权限管理系统

---

## 🏗️ 技术架构

### 技术栈

| 层级 | 技术 | 说明 |
|------|------|------|
| **后端框架** | Serverpod | Dart 全栈框架，提供 ORM、API、WebSocket 等功能 |
| **前端框架** | Flutter Web | 跨平台 UI 框架，支持 Web、移动端 |
| **数据库** | PostgreSQL 15+ | 主数据库，存储业务数据 |
| **缓存** | Redis 7+ | 缓存层，提升系统性能 |
| **包管理** | Melos | Monorepo 工具，管理多包依赖 |
| **容器化** | Docker | 应用容器化和部署 |

### 项目结构

```
book_store/
├── book_store_server/          # Serverpod 后端服务
│   ├── bin/                    # 服务启动入口
│   ├── lib/                    # 业务逻辑代码
│   ├── config/                 # 配置文件
│   ├── migrations/             # 数据库迁移文件
│   ├── docker/                 # Docker 配置
│   └── docs/                   # 后端文档
├── book_store_admin/           # Flutter Web 后台管理界面
│   ├── lib/                    # 前端代码
│   ├── assets/                 # 静态资源
│   └── web/                    # Web 配置
├── book_store_client/          # Serverpod 自动生成的客户端库
│   └── lib/                    # 客户端 API
├── book_store_shared/          # 前后端共享代码
│   └── lib/                    # 共享模型和工具
├── book_store_flutter/         # Flutter 移动端应用（可选）
├── docker/                     # 全局 Docker 配置
├── melos.yaml                  # Melos 配置文件
└── README.md                   # 项目文档
```

---

## 🚀 快速开始

### 环境要求

- **Dart SDK**: >= 3.0.0
- **Flutter SDK**: >= 3.0.0
- **PostgreSQL**: >= 15.0
- **Redis**: >= 7.0
- **Docker & Docker Compose** (可选，用于容器化部署)

### 安装依赖

1. **克隆项目**

```bash
git clone <repository-url>
cd book_store
```

2. **安装 Melos**

```bash
dart pub global activate melos
```

3. **初始化项目**

```bash
# 安装所有包的依赖
melos bootstrap
```

### 数据库配置

1. **创建 PostgreSQL 数据库**

```bash
createdb book_store
```

2. **配置数据库连接**

在 `book_store_server/config/` 目录下配置数据库连接信息：

```yaml
# development.yaml
database:
  host: localhost
  port: 5432
  name: book_store
  user: postgres
  password: your_password
```

3. **运行数据库迁移**

```bash
cd book_store_server
dart bin/main.dart --apply-migrations
```

### 启动项目

#### 方式一：本地开发

1. **启动后端服务**

```bash
cd book_store_server
dart bin/main.dart
```

后端服务将运行在 `http://localhost:8080`

2. **启动前端应用**

```bash
cd book_store_admin
flutter run -d chrome
```

前端应用将在浏览器中打开

#### 方式二：Docker 部署

```bash
# 使用 Docker Compose 一键启动
docker-compose -f docker/docker-compose.yaml up -d
```

---

## 📚 开发指南

### Melos 命令

```bash
# 为所有包获取依赖
melos get

# 清理所有包
melos clean

# 代码分析
melos analyze

# 代码格式化
melos format
```

### 数据库模型

本项目使用 Serverpod 的 ORM 系统进行数据库建模：

- [数据库模型文档](https://docs.serverpod.dev/concepts/database/models)
- [数据库关系文档](https://docs.serverpod.dev/concepts/database/relations/one-to-one)

### 生成客户端代码

当修改了服务端模型后，需要重新生成客户端代码：

```bash
cd book_store_server
serverpod generate
```

---

## 🐳 部署说明

### Docker 部署

项目提供了多种 Docker 配置：

- `docker-compose.prod.yaml` - 生产环境配置
- `docker-compose-simple.yaml` - 简化配置
- `docker/` - 各环境的详细配置

生产环境部署：

```bash
docker-compose -f docker-compose.prod.yaml up -d
```

### 自动化部署

参考 `book_store_server/automated-deployment.md` 文档

---

## 📝 文档

- [Serverpod 官方文档](https://docs.serverpod.dev/)
- [Flutter 官方文档](https://docs.flutter.dev/)
- [项目开发进度](book_store_admin/docs/PROJECT_PROGRESS.md)
- [系统管理实现说明](book_store_admin/docs/SYSTEM_MANAGEMENT_IMPLEMENTATION.md)
- [Serverpod 版本管理](SERVERPOD_VERSION_MANAGEMENT.md)

---

## 🤝 参与贡献

欢迎贡献代码、报告问题或提出建议！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

---

## 📄 许可证

请查看 [LICENSE](LICENSE) 文件了解详情

---

## 📧 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交 Issue
- 发送邮件

---

<p align="center">
  Made with ❤️ by coderxslee
</p>
