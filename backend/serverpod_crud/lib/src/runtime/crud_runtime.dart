import 'package:serverpod/serverpod.dart';
import '../models/query/query_dto.dart';
import 'plugin_registry.dart';

/// CRUD 运行时上下文。
///
/// 提供三个核心能力：
/// - mapQuery：把外部请求映射成 QueryDTO
/// - validate：执行查询参数校验插件
/// - audit：执行查询审计插件
class CrudRuntime implements SerializableModel {
  CrudRuntime({CrudPluginRegistry? plugins}) : plugins = plugins ?? CrudPluginRegistry();

  final CrudPluginRegistry plugins;

  QueryDTO mapQuery(dynamic request) {
    final mapper = plugins.queryMapper;
    if (mapper == null) {
      if (request is QueryDTO) return request;
      throw ArgumentError('No QueryMapperPlugin registered for request type: ${request.runtimeType}');
    }
    return mapper.map(request);
  }

  void validate(QueryDTO query) {
    for (final plugin in plugins.validations) {
      plugin.validate(query);
    }
  }

  Future<void> audit(Session session, QueryDTO query) async {
    for (final plugin in plugins.audits) {
      await plugin.onQuery(session, query);
    }
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'plugins': plugins.toJson(),
    };
  }
}
