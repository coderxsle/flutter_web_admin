
### 项目结构

```
book_store/
├── book_store_admin/    # 前端后台项目  
├── book_store_client/   # 通信客户端项目  
├── book_store_server/   # 后端服务器项目
├── book_store_shared/   # 共享代码和资源
├── book_store_flutter/  # Flutter App 项目
```

#### book_store_server
在 Serverpod 中，`server` 主要是 后端服务器，它提供 `API` 端点（`Endpoints`）、数据库操作、身份认证、`WebSocket` 通信 等功能，是整个 `Serverpod` 框架的核心。

1. 作用
* 处理客户端请求：提供 API 端点，供 client 调用（类似 REST API）。
* 管理数据库：内置 PostgreSQL，支持自动生成数据库模型、查询、事务处理等。
* 身份验证：支持 JWT Token，管理用户登录状态。
* WebSocket 支持：可以进行 实时数据推送（如聊天系统）。
* 后台任务：支持 定时任务、队列任务，用于执行异步任务。  

2. 总结  
✅ 提供后端 API 服务，（定义 endpoints，生成 `API` 供 `client` 调用）  
✅ 提供数据库管理，（内置 `PostgreSQL` 数据库，支持自动生成 PostgreSQL 表，支持查询、事务等）  
✅ 支持身份验证，使用 `session.auth` 进行 `JWT` 身份验证登录  
✅ 提供 `WebSocket` 支持，（适用于 聊天室、实时数据推送）  
✅ 支持 后台任务（定时任务、异步任务）  

#### book_store_client  
在 Serverpod 中，`client` 主要用于 前端（`Flutter`、`Dart` 等）与后端 `Serverpod` 服务器进行通信。它是一个 自动生成 的客户端库，使得前端应用可以方便地调用后端的 `API`（如 `endpoints`）并处理返回的数据。

1. 作用
* 负责与后端服务器进行网络请求（基于 HTTP/WebSocket）。
* 提供 类型安全的 `API` 调用，避免手写 `REST API` 请求，提高开发效率。
* 通过 自动生成的代码 直接调用 `serverpod` 后端的 `endpoints`，使调用后端 `API` 像调用本地函数一样简单。

2. 总结：  
✅ 自动生成代码，提供 `类型安全` 的 `API` 调用  
✅ 让 `Flutter` 的前端 与 `Dart` 后端的 `Serverpod` 服务器进行通信  
✅ 支持 `WebSocket`、`身份验证`、`序列化` 等功能  
✅ 避免手写 `REST API` 接口，极大成都的提升了开发效率  

#### book_store_shared 
是共享资源文件和服务，用于共享资源文件和服务。  

#### book_store_admin
前端项目，用于管理后台数据。

#### book_store_flutter 
是 Flutter App 项目，用于提供移动客户端服务。  

#### deploy/ 
是部署相关文件，用于部署 `Serverpod` 项目。  

#### scripts/ 
是部署脚本，用于部署 `Serverpod` 项目。  



1. `book_store_server/docker-compose.yaml` 用于：

* 本地开发环境
* 快速启动数据库和 Redis 服务
* 开发时的即时调试

```
# 在开发时使用
cd book_store_server
docker compose up -d
```


2. deploy/ 目录下的配置用于：
不同环境的部署（开发、测试、生产）
完整应用栈的部署
自动化部署流程
```
# 部署到不同环境
cd scripts
./deploy-all.sh dev    # 开发环境
./deploy-all.sh test   # 测试环境
./deploy-all.sh prod   # 生产环境
```

建议的工作流程：
1. 本地开发环境，日常开发时：
```
cd book_store_server
docker compose up -d     # 启动数据库等服务
dart run bin/main.dart   # 运行服务器
```

2. 部署测试环境时：
```
cd scripts
./deploy-all.sh test
```

3. 部署生产环境时：
```
cd scripts
./deploy-all.sh prod
```

4. 部署管理后台：
```
cd book_store_admin
docker build -t book_store_admin:latest .
docker run -d --name book_store_admin -p 80:80 book_store_admin:latest
```

5. 部署服务端：
```
cd book_store_server
docker build -t book_store_server:latest .
docker run -d --name book_store_server -p 8080:8080 book_store_server:latest
```

6. 部署所有服务：
```
cd scripts
./deploy-all.sh dev    # 或 test/prod
```









// 用户和角色挂钩，角色与资源挂钩，设计成 5 张表。
//
// 用户表 sys_user
// 角色表 sys_role
// 资源表 sys_resource
// 用户角色表 sys_user_role
// 角色资源表 sys_role_resource