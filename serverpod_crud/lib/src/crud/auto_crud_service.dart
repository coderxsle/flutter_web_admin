import 'package:serverpod/serverpod.dart';

import '../audit/audit_service.dart';
import '../runtime/crud_runtime.dart';
import 'base_service.dart';
import 'crud_entity_meta.dart';

/// 基于 [CrudEntityMeta] 的自动 CRUD Service 基类。
///
/// 主要用于通用的数据库实体（Entity）自动 CRUD 操作，极大简化业务 Service 层代码编写。
/// 使用方式：业务 Service 只需 `extends AutoCrudService<T, TTable>`，并在构造调用`super(meta)`，无需手动实现各 CRUD 方法。
/// 默认从 [meta] 读取 [EntityDescriptor]（表结构描述）与 [CrudRuntime]（运行时依赖），实现高度抽象与复用。
///
/// 泛型：
///   [T]      - 目标数据模型类型，需继承自 TableRow。
///   [TTable] - 对应的数据库表类型，需继承自 Table。
abstract class AutoCrudService<T extends TableRow, TTable extends Table> extends BaseEntityService<T, TTable> {
  /// 构造函数
  ///
  /// [meta]         - 实体元数据，负责解码、实体描述、运行时依赖等（由 EntityMeta/Binder 生成）。
  /// [runtime]      - 可选，额外传入的 CRUD 运行时（默认从 meta.runtime 获取）。
  /// [auditService] - 可选，审计日志相关服务（如需记录操作痕迹时传入）。
  AutoCrudService(this.meta, { CrudRuntime? runtime,  AuditService<T>? auditService}) : super(
    meta.descriptor,
    runtime: runtime ?? meta.runtime,
    auditService: auditService,
  );

  /// 实体元数据
  ///
  /// 提供解码、表结构、运行时依赖等通用功能。
  final CrudEntityMeta<T, TTable> meta;

  /// 数据解码器
  ///
  /// 用于将外部数据（如 Map/Json）解码为具体的数据模型对象。
  /// 通常用于 API 层/服务层，将前端/请求体转换为实体。
  T decodeModel(dynamic data) => meta.decodeModel(data);
}