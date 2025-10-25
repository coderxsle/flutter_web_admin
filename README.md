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
  <img src="https://img.shields.io/badge/Serverpod-2.9.1-blue" alt="Serverpod">
  <img src="https://img.shields.io/badge/Flutter-3.35.6-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/PostgreSQL-15+-green" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Redis-8+-red" alt="Redis">
  <img src="https://img.shields.io/badge/Dart-3.9.0-blue" alt="Dart">
</p>

---

## 🌐 在线演示

<p align="center">
  <a href="http://103.215.82.63:18000/" target="_blank">
    <img src="https://img.shields.io/badge/🚀_在线演示-立即体验-blue?style=for-the-badge&logo=flutter" alt="在线演示"/>
  </a>
</p>

<p align="center">
  <b>演示地址：</b> <a href="http://103.215.82.63:18000/" target="_blank">http://103.215.82.63:18000/</a>
</p>

---

## 📸 系统截图

<table>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.08.44.png" width="400" alt="加载页面"/>
      <br/>
      <b>加载页面</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.09.05.png" width="400" alt="首页展开侧边栏"/>
      <br/>
      <b>首页 - 展开侧边栏</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.09.06.png" width="400" alt="首页收起侧边栏"/>
      <br/>
      <b>首页 - 收起侧边栏</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.09.39.png" width="400" alt="API测试与主题配置"/>
      <br/>
      <b>API 测试 & 主题配置</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.24.png" width="400" alt="按钮组件展示"/>
      <br/>
      <b>按钮组件展示</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.26.png" width="400" alt="消息通知组件"/>
      <br/>
      <b>消息通知组件</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.31.png" width="400" alt="标签组件"/>
      <br/>
      <b>GiTag 标签组件</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.38.png" width="400" alt="间距组件"/>
      <br/>
      <b>GiSpace 间距组件</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.42.png" width="400" alt="图标盒子组件"/>
      <br/>
      <b>GiIconBox 图标盒子</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.10.48.png" width="400" alt="圆点组件"/>
      <br/>
      <b>GiDot 圆点组件</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.11.14.png" width="400" alt="图标选择器"/>
      <br/>
      <b>GiIconSelector 图标选择器</b>
    </td>
    <td align="center">
      <img src="docs/images/iShot_2025-10-24_10.12.24.png" width="400" alt="数据表格"/>
      <br/>
      <b>GiTable 数据表格</b>
    </td>
  </tr>
</table>

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

## 🚀 快速开始

### 1. 安装 Flutter 版本管理工具

```bash
fvm install
```

### 2. 安装项目依赖

```bash
melos bootstrap
```

### 3. 配置环境变量

进入 `flutter_web_server` 目录，在 `env` 目录下创建以下环境配置文件：

```bash
cd flutter_web_server
```

#### 创建 `.env.development` 文件

```bash
# 数据库配置
POSTGRES_DB=flutter_web_admin
POSTGRES_USER=postgres
POSTGRES_PASSWORD=zofw6sPp0LEIOdXhztHQUmci8v9WgILN

# Redis配置
REDIS_PASSWORD=sK2WZqakWyrbjsQHBLlkqXMjCh1mXHa8 

# 服务密钥
SERVICE_SECRET=IYynD5iR2VZTRTeKXysY7wNPVftFrhRg
```

#### 创建 `.env.test` 文件

```bash
# 数据库配置
POSTGRES_DB=flutter_web_admin_test
POSTGRES_USER=postgres
POSTGRES_PASSWORD=YCRfegJqtCpeNEaxJJCobIB9R-3ZkdCX

# Redis配置
REDIS_PASSWORD=o2rE1Sg0O4kPx62nedGmnrvb5tyZmLE8
```

#### 创建 `.env.production` 文件

```bash
# 项目根目录
PROJECT_ROOT="~/workspace/flutter_web_admin/flutter_web_server"

# 应用配置
PORT="8080"
DOMAIN="api.admin.com"
VERSION="1.0.0"
CPU_LIMIT="0.50"
MEMORY_LIMIT="512M"
CPU_RESERVATION="0.25"
MEMORY_RESERVATION="256M"

# 健康检查配置
HEALTH_CHECK_URL="http://localhost:8080/health"
HEALTH_CHECK_RETRIES="30"
HEALTH_CHECK_INTERVAL="10"

# 数据库配置
POSTGRES_DB=flutter_web_admin
POSTGRES_USER=postgres
POSTGRES_PASSWORD=1MbAoaiEuZDntm_SFmVtqCDKERXsw3g_

# Redis配置
REDIS_PASSWORD=sK2WZqakWyrbjsQHBLlkqXMjCh1mXHa8

# 服务密钥
SERVICE_SECRET=i-3veRkAnJxBiTGfYvllMJJ6MJa8y2k9
```

### 4. 启动服务

在 `flutter_web_server` 目录下执行启动脚本：

```bash
./start.sh
```
<p align="center">
  <img src="docs/images/iShot_2025-10-25_11.01.05.png" alt="脚本启动">
</p>

后端服务将运行在 `http://localhost:8080`

### 5. 启动前端应用（可选）

```bash
cd flutter_web_admin
flutter run -d chrome
```

前端应用将在浏览器中打开

### 数据库模型

本项目使用 Serverpod 的 ORM 系统进行数据库建模：

- [数据库模型文档](https://docs.serverpod.dev/concepts/database/models)
- [数据库关系文档](https://docs.serverpod.dev/concepts/database/relations/one-to-one)

### 生成客户端代码

当修改了服务端模型后，需要重新生成客户端代码：

```bash
cd flutter_web_server
serverpod generate
```
---

## 📝 文档

- [Serverpod 官方文档](https://docs.serverpod.dev/)
- [Flutter 官方文档](https://docs.flutter.dev/)
- [项目开发进度](flutter_web_admin_admin/docs/PROJECT_PROGRESS.md)
- [系统管理实现说明](flutter_web_admin_admin/docs/SYSTEM_MANAGEMENT_IMPLEMENTATION.md)
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

- 📮 提交 Issue
- 💬 **添加微信**：扫描下方二维码，直接与作者一对一沟通

<p align="center">
  <img src="docs/images/wechat-qrcode.jpg" width="300" alt="微信二维码">
</p>

<p align="center">
  <i>扫一扫上面的二维码图案，加我为朋友</i>
</p>

---

<p align="center">
  Made with ❤️ by coderxslee
</p>
