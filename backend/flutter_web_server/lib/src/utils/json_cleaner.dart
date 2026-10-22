import 'datetime_utils.dart';

/// JSON 清理工具：递归去掉 Serverpod 的 `__className__` 和 `password`，
/// 并把所有时间统一成 `yyyy-MM-dd HH:mm:ss`。接口返回前必过这一层。
class JsonCleaner {
  /// 只匹配带时分秒的 ISO 串，纯日期（如 `2026-10-22`）保持原样。
  static final _isoDateTime = RegExp(r'^\d{4}-\d{2}-\d{2}[T ]\d{2}:\d{2}:\d{2}');

  static dynamic clean(dynamic data) {
    if (data == null) return null;

    if (data is DateTime) return DateTimeFormatter.format(data);

    if (data is String) {
      if (!_isoDateTime.hasMatch(data)) return data;
      final formatted = DateTimeFormatter.formatString(data);
      return formatted.isEmpty ? data : formatted;
    }

    if (data is List) {
      return data.map((e) => clean(e)).toList();
    }

    if (data is Map) {
      final cleaned = <String, dynamic>{};
      for (final entry in data.entries) {
        final key = entry.key.toString();
        if (key == '__className__' || key == 'password') continue;
        cleaned[key] = clean(entry.value);
      }
      return cleaned;
    }

    return data;
  }

  /// 清理 Map 数据（便捷方法）
  static Map<String, dynamic> cleanMap(Map<String, dynamic> data) {
    return clean(data) as Map<String, dynamic>;
  }

  /// 清理 List 数据（便捷方法）
  static List<dynamic> cleanList(List<dynamic> data) {
    return clean(data) as List<dynamic>;
  }
}
