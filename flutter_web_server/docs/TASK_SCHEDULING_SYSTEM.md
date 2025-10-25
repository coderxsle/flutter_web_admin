# 定时任务系统设计文档

## 概述

本文档描述了在 Serverpod 项目中实现企业级定时任务管理系统的设计方案，包括任务配置管理、执行监控和日志记录功能。

## 表结构设计

### 1. infra_job 表 - 定时任务表

**作用**：管理定时任务的配置信息

**主要字段**：
- `id`: 任务编号，主键
- `name`: 任务名称
- `status`: 任务状态
- `handlerName`: 处理器的名字
- `handlerParam`: 处理器的参数
- `cronExpression`: CRON 表达式
- `retryCount`: 重试次数
- `retryInterval`: 重试间隔
- `monitorTimeout`: 监控超时时间

### 2. infra_job_log 表 - 定时任务日志表

**作用**：记录定时任务的执行日志

**主要字段**：
- `id`: 日志编号，主键
- `jobId`: 任务编号
- `handlerName`: 处理器的名字
- `handlerParam`: 处理器的参数
- `executeIndex`: 第几次执行
- `beginTime`: 开始执行时间
- `endTime`: 结束执行时间
- `duration`: 执行时长
- `status`: 任务状态
- `result`: 结果数据

## Serverpod 内置功能分析

### Serverpod 内置任务调度功能

**Serverpod 确实有内置的任务调度功能**，主要包括：

1. **基础任务调度**：可以在指定延迟后调用方法
2. **持久化任务**：即使服务器重启，任务也会持续存在
3. **简单调度**：支持基本的延迟执行和重复执行

### 功能对比

| 功能 | Serverpod 内置 | 企业级定时任务系统 |
|------|---------------|------------------|
| **CRON表达式** | 基础支持 | 完整支持 |
| **任务配置管理** | 简单 | 完整的配置管理 |
| **重试机制** | 基础 | 可配置的重试策略 |
| **监控超时** | 无 | 支持监控超时 |
| **执行日志** | 基础 | 详细的执行日志 |
| **任务状态管理** | 简单 | 完整的状态管理 |
| **异常处理** | 基础 | 详细的异常记录 |

## 为什么需要创建自定义定时任务表

### 1. 企业级需求
- 复杂的CRON表达式调度
- 可配置的重试策略
- 详细的执行监控和日志

### 2. 运维管理
- 任务执行状态监控
- 异常情况分析和处理
- 性能优化和调优

### 3. 业务需求
- 数据备份任务
- 报表生成任务
- 数据同步任务
- 清理任务

## 实现方案

### 1. 与 Serverpod 内置功能结合
- **Serverpod 内置调度**：用于简单的延迟任务
- **自定义定时任务系统**：用于复杂的定时任务管理

### 2. 核心服务实现

```dart
// 定时任务服务
class JobService {
  // 创建定时任务
  Future<void> createJob(InfraJob job) async {
    // 保存任务配置到数据库
    await _saveJob(job);
    
    // 使用 Serverpod 内置调度或外部调度器
    await _scheduleJob(job);
  }
  
  // 执行任务
  Future<void> executeJob(int jobId) async {
    final job = await _getJob(jobId);
    final log = await _createJobLog(job);
    
    try {
      // 执行任务逻辑
      final result = await _executeHandler(job);
      
      // 更新日志
      await _updateJobLog(log.id, status: 1, result: result);
    } catch (e) {
      // 记录异常
      await _updateJobLog(log.id, status: 0, result: e.toString());
    }
  }
}
```

### 3. 任务处理器示例

```dart
// 数据备份任务处理器
class DataBackupHandler {
  Future<String> execute(Map<String, dynamic> params) async {
    // 执行数据备份逻辑
    final backupPath = await _performBackup();
    return 'Backup completed: $backupPath';
  }
}

// 报表生成任务处理器
class ReportGeneratorHandler {
  Future<String> execute(Map<String, dynamic> params) async {
    // 生成报表逻辑
    final reportPath = await _generateReport();
    return 'Report generated: $reportPath';
  }
}
```

## 应用场景

### 1. 系统维护
- **数据备份**：每日凌晨备份数据库
- **日志清理**：定期清理过期日志文件
- **缓存刷新**：定时刷新系统缓存

### 2. 业务处理
- **订单处理**：处理超时未支付的订单
- **报表生成**：每月生成财务报表
- **数据同步**：与外部系统同步数据

### 3. 监控告警
- **系统健康检查**：定期检查系统状态
- **性能监控**：收集和分析性能指标
- **异常告警**：监控异常情况并发送告警

### 4. 营销活动
- **邮件发送**：定时发送营销邮件
- **推送通知**：发送用户通知
- **活动管理**：管理营销活动生命周期

## 任务配置示例

### CRON 表达式示例
```yaml
# 每日凌晨2点执行数据备份
- name: "数据备份"
  cronExpression: "0 2 * * *"
  handlerName: "DataBackupHandler"

# 每周一上午9点生成周报
- name: "周报生成"
  cronExpression: "0 9 * * 1"
  handlerName: "WeeklyReportHandler"

# 每小时检查系统状态
- name: "系统健康检查"
  cronExpression: "0 * * * *"
  handlerName: "HealthCheckHandler"
```

### 重试策略配置
```yaml
# 失败后重试3次，每次间隔5分钟
retryCount: 3
retryInterval: 300  # 5分钟

# 监控超时30分钟
monitorTimeout: 1800  # 30分钟
```

## 监控和运维

### 1. 任务状态监控
- 实时监控任务执行状态
- 异常任务告警
- 性能指标统计

### 2. 日志分析
- 执行成功率统计
- 平均执行时间分析
- 异常原因分析

### 3. 运维管理
- 任务启停控制
- 参数动态调整
- 执行历史查询

## 总结

### 为什么需要创建这两个表

1. **Serverpod 内置功能**相对简单，无法满足企业级需求
2. **企业级定时任务系统**需要完整的配置管理、监控和日志功能
3. **两者可以结合使用**，各自服务于不同的场景
4. **建议异步执行**，避免影响系统性能

### 系统优势

1. **完整的任务管理**：从配置到执行到监控的完整生命周期管理
2. **灵活的调度策略**：支持复杂的CRON表达式和重试机制
3. **详细的执行日志**：便于问题排查和性能优化
4. **企业级特性**：满足企业应用的复杂需求

这个定时任务系统将为您提供完整的任务管理能力，满足企业级应用的复杂调度需求。
