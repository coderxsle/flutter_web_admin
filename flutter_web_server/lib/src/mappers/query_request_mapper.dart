import 'dart:convert';
import 'package:serverpod_crud/serverpod_crud.dart';

// 协议层 QueryRequest -> core 层 QueryDTO 的转换器。
//
// 重点：QueryFilter.value 在 protocol 中为 String?，
//  这里会尝试将其解析为 JSON 原生类型（number/bool/list/map/null），
// 解析失败则保留原始字符串。
class QueryRequestMapper {
  const QueryRequestMapper();

  QueryDTO toCore(QueryRequest request) {
    return QueryDTO(
      page: request.page,
      pageSize: request.pageSize,
      filters: request.filters?.map((f) {
            final item = f as dynamic;
            //  网络传来的字符串 "123" → 解析为 int 123
            //  网络传来的字符串 "true" → 解析为 bool true
            //  网络传来的字符串 "[1,2,3]" → 解析为 List [1, 2, 3]
            //  网络传来的字符串 "hello" → 保留为 String "hello"
            return QueryCondition(
              field: item.field as String,
              comparator: item.comparator as String,
              value: _decodeFilterValue(item.value),
            );
          })
          .whereType<QueryCondition>()
          .toList(),
      sort: request.sort
          ?.map((s) => QuerySort(field: s.field, order: s.order))
          .toList(),
      keyword: request.keyword,
    );
  }

  dynamic _decodeFilterValue(dynamic value) {
    if (value == null || value is! String) return value;
    final text = value.trim();
    if (text.isEmpty) return text;
    final first = text[0];
    final looksLikeJson = first == '{' || first == '[' || first == '"' || first == '-' || first == 't' || first == 'f' || first == 'n' || _isDigit(first);
    if (!looksLikeJson) return value;
    try {
      return jsonDecode(text);
    } catch (_) {
      return value;
    }
  }

  bool _isDigit(String ch) => ch.codeUnitAt(0) >= 48 && ch.codeUnitAt(0) <= 57;
}

