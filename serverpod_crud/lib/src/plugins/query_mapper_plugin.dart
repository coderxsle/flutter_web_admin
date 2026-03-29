
import 'package:serverpod/serverpod.dart';

import '../models/query/query_dto.dart';

/// Query 入参映射插件。
///
/// 当 Endpoint 传入的并非 QueryDTO 时，可通过该插件做统一转换。
abstract class QueryMapperPlugin implements SerializableModel {
  const QueryMapperPlugin();

  QueryDTO map(dynamic request);
}
