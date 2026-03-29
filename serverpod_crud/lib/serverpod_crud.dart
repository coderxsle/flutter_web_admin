/// Serverpod CRUD Framework
///
/// 企业级 Serverpod CRUD 框架，提供：
/// - 多租户隔离
/// - 软删除
/// - 通用 CRUD Service 与 Endpoint
/// - 灵活的查询引擎
/// - 生命周期钩子（beforeCreate/afterCreate 等）
/// - 审计字段策略
library;

export 'src/generated/protocol.dart';



// Core types
export 'src/core/crud_types.dart';
export 'src/core/crud_models.dart';
export 'src/core/dto.dart';
export 'src/core/exceptions.dart';

// CRUD layer
export 'src/crud/crud_service.dart';
export 'src/crud/base_service.dart';
export 'src/crud/crud_entity_meta.dart';
export 'src/crud/auto_crud_service.dart';

// Query models
export 'src/models/query/query_dto.dart';
export 'src/models/query/query_request.dart';
export 'src/models/query/query_filter.dart';
export 'src/models/query/query_condition.dart';
export 'src/models/query/query_sort.dart';

// Validation
export 'src/validation/validation_result.dart';
export 'src/validation/validator.dart';

// Audit
export 'src/audit/audit_log.dart';
export 'src/audit/audit_service.dart';

// Plugins & runtime
export 'src/plugins/query_mapper_plugin.dart';
export 'src/plugins/operator_plugin.dart';
export 'src/plugins/field_alias_plugin.dart';
export 'src/plugins/data_permission_plugin.dart';
export 'src/plugins/validation_plugin.dart';
export 'src/plugins/audit_plugin.dart';
export 'src/runtime/plugin_registry.dart';
export 'src/runtime/crud_runtime.dart';

// Extensions
export 'src/extensions/session_extension.dart';