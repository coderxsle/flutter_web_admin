
import 'package:serverpod/serverpod.dart';

import '../models/query/query_dto.dart';

/// 查询参数校验插件。
abstract class ValidationPlugin implements SerializableModel  {
  const ValidationPlugin();

  void validate(QueryDTO query);
}
