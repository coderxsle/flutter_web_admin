import 'package:serverpod/serverpod.dart';

import '../audit/audit_service.dart';
import '../models/query/query_sort.dart';
import '../runtime/crud_runtime.dart';

/// 自动 CRUD 的资源级配置。
class CrudOptions<T extends TableRow> {
  const CrudOptions({
    this.runtime,
    this.tenantIdField = 'tenantId',
    this.deletedField,
    this.keywordFields,
    this.fieldAliases = const {},
    this.auditService,
    this.defaultSort,
  });

  final CrudRuntime? runtime;
  final String tenantIdField;
  final String? deletedField;
  final List<String>? keywordFields;
  final Map<String, String> fieldAliases;
  final AuditService<T>? auditService;

  /// 列表接口的默认排序（前端不带 `sort` 时生效）；不传则按表结构自动推导。
  final List<QuerySort>? defaultSort;
}
