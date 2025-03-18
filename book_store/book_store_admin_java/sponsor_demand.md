# 赞助商功能需求文档

## 1. 需求概述

### 1.1 功能说明
添加赞助商展示功能，支持不同类型赞助商（白金、金牌、银牌等）的管理和展示。

### 1.2 接口需求
- 公开接口：GET /sponsor/platinum，返回所有白金赞助商信息
- 返回数据格式：
```json
[{
  "name": "石家庄智合未来家文化传播有限公司",
  "img": "/img/sponsor/ad/jssy-20250218.jpg",
  "url": "https://www.aiziran.top/"
}, {
  "name": "ContiNew Admin V3.5.0",
  "img": "/img/sponsor/cn/cn-20250305.png",
  "url": "https://www.aiziran.top/"
}]
```

## 2. 模块与数据设计

### 2.1 模块选择
- 将赞助商功能放在`continew-module-system`模块下，作为系统管理的一部分
- 在`continew-webapi`模块下创建对应的Controller

### 2.2 数据库设计
- ✅ MySQL数据库脚本：continew-webapi/src/main/resources/db/changelog/mysql/sponsor.sql
- ✅ PostgreSQL数据库脚本：continew-webapi/src/main/resources/db/changelog/postgresql/sponsor.sql

```sql
CREATE TABLE `sys_sponsor` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '赞助商名称',
  `img` varchar(512) NOT NULL COMMENT '图片URL',
  `url` varchar(512) NOT NULL COMMENT '跳转链接',
  `type` varchar(30) NOT NULL COMMENT '类型（platinum: 白金赞助商; gold: 金牌赞助商; silver: 银牌赞助商）',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `sort` int NOT NULL DEFAULT 999 COMMENT '排序',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态（1：启用；2：禁用）',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  INDEX `idx_type`(`type`),
  INDEX `idx_create_user`(`create_user`),
  INDEX `idx_update_user`(`update_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='赞助商表';
```

## 3. 代码结构设计

### 3.1 实体类
- ✅ SponsorDO：赞助商实体类
- ✅ SponsorResp：赞助商响应类
- ✅ SponsorSimpleResp：赞助商简化响应类（用于公开API）
- ✅ SponsorReq：赞助商请求类
- ✅ SponsorQuery：赞助商查询条件类

### 3.2 枚举类
- ✅ SponsorTypeEnum：赞助商类型枚举（白金、金牌、银牌）

### 3.3 服务类
- ✅ SponsorService：赞助商服务接口
- ✅ SponsorServiceImpl：赞助商服务实现类

### 3.4 控制器
- ✅ SponsorController：赞助商管理API（系统管理接口，需权限）
- ✅ CommonSponsorController：赞助商展示API（公开接口，无需权限）

### 3.5 数据访问层
- ✅ SponsorMapper：赞助商数据访问接口

## 4. 接口设计

### 4.1 管理接口（需要权限）
- GET /system/sponsor：分页查询赞助商列表
- GET /system/sponsor/{id}：查询赞助商详情
- POST /system/sponsor：新增赞助商
- PUT /system/sponsor/{id}：修改赞助商
- DELETE /system/sponsor/{id}：删除赞助商

### 4.2 公开接口（无需权限）
- GET /sponsor/platinum：获取白金赞助商列表
- GET /sponsor/gold：获取金牌赞助商列表（可扩展）
- GET /sponsor/silver：获取银牌赞助商列表（可扩展）

## 5. 实施步骤

1. ✅ 创建数据库表结构
2. ✅ 创建实体类和相关配置
3. ✅ 实现Service层逻辑
4. ✅ 实现Controller层接口
5. 编写单元测试
6. 更新API文档

## 6. 注意事项

1. 确保图片存储符合系统的文件管理规范
2. 接口遵循RESTful设计风格
3. 实现时考虑性能优化，如缓存策略
4. 按照项目现有编码规范进行开发
5. 管理接口需要添加权限控制 