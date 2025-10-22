# Serverpod 默认表结构文档

## 概述

本文档详细描述了 Serverpod 框架自动创建的默认表结构，包括每个表的作用和字段含义。这些表是 Serverpod 框架内置功能的核心组成部分，用于支持日志记录、会话管理、云存储、任务调度等功能。

## 表结构详解

### 1. serverpod_cloud_storage 表 - 云存储表

**作用**：存储上传到云存储的文件数据和元信息

**主要字段**：
- `id`: 存储记录编号，主键，自增长整数
- `storageId`: 存储标识符，标识不同的存储空间或配置
- `path`: 文件在存储中的路径，用于文件定位
- `addedTime`: 文件添加时间，记录文件上传的时间戳
- `expiration`: 过期时间，可选字段，用于自动清理过期文件
- `byteData`: 文件的二进制数据，实际存储的文件内容
- `verified`: 验证状态，标记文件是否已通过验证

**索引**：
- `serverpod_cloud_storage_path_idx`: 基于 `storageId` 和 `path` 的唯一索引
- `serverpod_cloud_storage_expiration`: 基于 `expiration` 的索引，用于过期文件清理

### 2. serverpod_cloud_storage_direct_upload 表 - 云存储直传表

**作用**：管理云存储的直接上传授权和临时访问

**主要字段**：
- `id`: 直传记录编号，主键
- `storageId`: 存储标识符，关联到特定的存储配置
- `path`: 上传文件路径，指定文件在存储中的位置
- `expiration`: 授权过期时间，限制直传链接的有效期
- `authKey`: 授权密钥，用于验证直传请求的合法性

**索引**：
- `serverpod_cloud_storage_direct_upload_storage_path`: 基于 `storageId` 和 `path` 的唯一索引

### 3. serverpod_future_call 表 - 未来调用表

**作用**：存储延迟执行或定时执行的任务调用

**主要字段**：
- `id`: 调用记录编号，主键
- `name`: 调用名称，标识要执行的任务类型
- `time`: 执行时间，指定任务的执行时间点
- `serializedObject`: 序列化对象，存储任务执行所需的参数数据
- `serverId`: 服务器标识符，标识处理该任务的服务器
- `identifier`: 任务标识符，可选，用于任务的唯一标识或分组

**索引**：
- `serverpod_future_call_time_idx`: 基于执行时间的索引，用于快速查找到期任务
- `serverpod_future_call_serverId_idx`: 基于服务器ID的索引
- `serverpod_future_call_identifier_idx`: 基于任务标识符的索引

### 4. serverpod_health_connection_info 表 - 健康检查连接信息表

**作用**：记录服务器数据库连接池的健康状态信息

**主要字段**：
- `id`: 记录编号，主键
- `serverId`: 服务器标识符，标识监控的服务器
- `timestamp`: 记录时间戳，数据收集的时间点
- `active`: 活跃连接数，当前正在使用的数据库连接数
- `closing`: 正在关闭的连接数，处于关闭状态的连接数
- `idle`: 空闲连接数，连接池中可用的空闲连接数
- `granularity`: 数据粒度，记录数据的时间间隔粒度

**索引**：
- `serverpod_health_connection_info_timestamp_idx`: 基于时间戳、服务器ID和粒度的唯一索引

### 5. serverpod_health_metric 表 - 健康检查指标表

**作用**：记录服务器各种健康检查指标和性能数据

**主要字段**：
- `id`: 指标记录编号，主键
- `name`: 指标名称，标识监控的具体指标类型
- `serverId`: 服务器标识符，标识被监控的服务器
- `timestamp`: 记录时间戳，指标数据收集的时间
- `isHealthy`: 健康状态，布尔值表示该指标是否健康
- `value`: 指标数值，具体的指标测量值
- `granularity`: 数据粒度，指标收集的时间间隔

**索引**：
- `serverpod_health_metric_timestamp_idx`: 基于时间戳、服务器ID、指标名称和粒度的唯一索引

### 6. serverpod_log 表 - 系统日志表

**作用**：记录系统运行过程中的各种日志信息

**主要字段**：
- `id`: 日志记录编号，主键
- `sessionLogId`: 会话日志ID，关联到具体的会话记录
- `messageId`: 消息ID，可选，关联到特定的消息处理
- `reference`: 引用信息，可选，用于关联相关的业务对象
- `serverId`: 服务器标识符，标识产生日志的服务器
- `time`: 日志时间，记录日志产生的时间戳
- `logLevel`: 日志级别，数字表示日志的重要程度（如DEBUG、INFO、ERROR等）
- `message`: 日志消息，具体的日志内容描述
- `error`: 错误信息，可选，记录具体的错误详情
- `stackTrace`: 堆栈跟踪，可选，记录错误发生时的调用堆栈
- `order`: 排序序号，用于同一会话内日志的排序

**索引**：
- `serverpod_log_sessionLogId_idx`: 基于会话日志ID的索引

**外键关系**：
- `sessionLogId` 关联到 `serverpod_session_log.id`，级联删除

### 7. serverpod_message_log 表 - 消息日志表

**作用**：记录API调用和消息处理的详细日志

**主要字段**：
- `id`: 消息日志编号，主键
- `sessionLogId`: 会话日志ID，关联到对应的会话
- `serverId`: 服务器标识符，标识处理消息的服务器
- `messageId`: 消息ID，唯一标识处理的消息
- `endpoint`: 端点名称，API调用的端点标识
- `messageName`: 消息名称，具体的方法或消息类型
- `duration`: 执行时长，消息处理所用的时间（秒）
- `error`: 错误信息，可选，记录处理过程中的错误
- `stackTrace`: 堆栈跟踪，可选，错误发生时的调用堆栈
- `slow`: 慢查询标记，标识该消息处理是否超过预设阈值
- `order`: 排序序号，用于同一会话内消息的排序

**外键关系**：
- `sessionLogId` 关联到 `serverpod_session_log.id`，级联删除

### 8. serverpod_method 表 - 方法信息表

**作用**：存储系统中可用的API端点和方法信息

**主要字段**：
- `id`: 方法记录编号，主键
- `endpoint`: 端点名称，API的端点标识
- `method`: 方法名称，具体的方法或函数名

**索引**：
- `serverpod_method_endpoint_method_idx`: 基于端点和方法的唯一索引

### 9. serverpod_migrations 表 - 数据库迁移版本表

**作用**：跟踪数据库迁移的版本信息，确保数据库结构的正确更新

**主要字段**：
- `id`: 迁移记录编号，主键
- `module`: 模块名称，标识迁移所属的模块
- `version`: 版本号，当前模块的迁移版本
- `timestamp`: 迁移时间戳，可选，记录迁移执行的时间

**索引**：
- `serverpod_migrations_ids`: 基于模块名称的唯一索引

### 10. serverpod_query_log 表 - 数据库查询日志表

**作用**：记录数据库查询的执行情况和性能信息

**主要字段**：
- `id`: 查询日志编号，主键
- `serverId`: 服务器标识符，执行查询的服务器
- `sessionLogId`: 会话日志ID，关联到对应的会话
- `messageId`: 消息ID，可选，关联到触发查询的消息
- `query`: SQL查询语句，实际执行的数据库查询
- `duration`: 执行时长，查询执行所用的时间（秒）
- `numRows`: 影响行数，可选，查询返回或影响的行数
- `error`: 错误信息，可选，查询执行过程中的错误
- `stackTrace`: 堆栈跟踪，可选，错误发生时的调用堆栈
- `slow`: 慢查询标记，标识该查询是否超过预设的执行时间阈值
- `order`: 排序序号，用于同一会话内查询的排序

**索引**：
- `serverpod_query_log_sessionLogId_idx`: 基于会话日志ID的索引

**外键关系**：
- `sessionLogId` 关联到 `serverpod_session_log.id`，级联删除

### 11. serverpod_readwrite_test 表 - 读写测试表

**作用**：用于测试数据库的读写功能，确保数据库连接正常

**主要字段**：
- `id`: 测试记录编号，主键
- `number`: 测试数值，用于读写测试的数据

### 12. serverpod_runtime_settings 表 - 运行时设置表

**作用**：存储系统运行时的配置参数和设置

**主要字段**：
- `id`: 设置记录编号，主键
- `logSettings`: 日志设置，JSON格式存储日志相关的配置参数
- `logSettingsOverrides`: 日志设置覆盖，JSON格式存储覆盖默认日志设置的参数
- `logServiceCalls`: 服务调用日志开关，控制是否记录服务调用日志
- `logMalformedCalls`: 异常调用日志开关，控制是否记录格式错误的调用

### 13. serverpod_session_log 表 - 会话日志表

**作用**：记录用户会话和API调用的整体信息，是日志系统的核心表

**主要字段**：
- `id`: 会话日志编号，主键
- `serverId`: 服务器标识符，处理会话的服务器
- `time`: 会话开始时间，记录会话创建的时间戳
- `module`: 模块名称，可选，标识会话所属的功能模块
- `endpoint`: 端点名称，可选，API调用的端点
- `method`: 方法名称，可选，调用的具体方法
- `duration`: 会话时长，可选，整个会话的持续时间（秒）
- `numQueries`: 查询次数，可选，会话中执行的数据库查询次数
- `slow`: 慢会话标记，可选，标识会话是否超过预设的执行时间
- `error`: 错误信息，可选，会话过程中发生的错误
- `stackTrace`: 堆栈跟踪，可选，错误发生时的调用堆栈
- `authenticatedUserId`: 认证用户ID，可选，标识会话关联的用户
- `isOpen`: 会话状态，可选，标识会话是否仍在进行中
- `touched`: 最后活动时间，记录会话的最后活动时间戳

**索引**：
- `serverpod_session_log_serverid_idx`: 基于服务器ID的索引
- `serverpod_session_log_touched_idx`: 基于最后活动时间的索引
- `serverpod_session_log_isopen_idx`: 基于会话状态的索引

## 表关系图

```
serverpod_session_log (主表)
├── serverpod_log (一对多)
├── serverpod_message_log (一对多)
└── serverpod_query_log (一对多)

serverpod_cloud_storage (独立)
serverpod_cloud_storage_direct_upload (独立)
serverpod_future_call (独立)
serverpod_health_connection_info (独立)
serverpod_health_metric (独立)
serverpod_method (独立)
serverpod_migrations (独立)
serverpod_readwrite_test (独立)
serverpod_runtime_settings (独立)
```

## 功能分类

### 1. 日志系统
- `serverpod_session_log`: 会话级别的日志记录
- `serverpod_log`: 详细的系统日志
- `serverpod_message_log`: API调用日志
- `serverpod_query_log`: 数据库查询日志

### 2. 云存储系统
- `serverpod_cloud_storage`: 文件存储和管理
- `serverpod_cloud_storage_direct_upload`: 直传授权管理

### 3. 任务调度系统
- `serverpod_future_call`: 延迟任务和定时任务

### 4. 健康监控系统
- `serverpod_health_connection_info`: 数据库连接监控
- `serverpod_health_metric`: 系统性能指标监控

### 5. 系统管理
- `serverpod_method`: API方法注册
- `serverpod_migrations`: 数据库版本管理
- `serverpod_runtime_settings`: 运行时配置
- `serverpod_readwrite_test`: 数据库连接测试

## 数据清理和维护

### 自动清理机制
1. **日志数据**: 根据配置的保留期限自动清理过期的日志记录
2. **云存储**: 基于 `expiration` 字段自动清理过期的文件
3. **未来调用**: 执行完成的任务会被自动清理

### 性能优化建议
1. **定期清理**: 建议定期清理过期的日志数据以保持性能
2. **索引维护**: 关注索引的使用情况，确保查询性能
3. **监控告警**: 利用健康检查表建立监控告警机制

## 总结

Serverpod 的默认表结构设计完整且功能丰富，涵盖了现代Web应用所需的核心功能：

1. **完整的日志系统**: 提供多层次的日志记录，便于问题排查和性能分析
2. **云存储支持**: 内置文件存储和管理功能，支持直传优化
3. **任务调度**: 支持延迟执行和定时任务，满足异步处理需求
4. **健康监控**: 实时监控系统状态，保障服务稳定性
5. **系统管理**: 提供完整的配置管理和数据库迁移支持

这些表的设计体现了企业级应用的完整性和可维护性要求，为开发者提供了强大的基础设施支持。
