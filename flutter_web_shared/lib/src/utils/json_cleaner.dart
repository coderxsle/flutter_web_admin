import 'datetime_utils.dart';

/// JSON 清理工具类
/// 用于移除 Serverpod 自动添加的 __className__ 字段，以及服务端不应暴露给前端的字段，如 password，使接口更适合非 Flutter 客户端使用
class JsonCleaner {
  /// 递归清理 JSON 数据，移除所有敏感/冗余字段
  /// __className__、password
  /// 
  static dynamic clean(dynamic data) {
    if (data == null) return null;

    if (data is List) {
      return data.map((e) => clean(e)).toList();
    }

    if (data is Map<String, dynamic>) {
      final cleaned = <String, dynamic>{};
      for (final entry in data.entries) {
        // 跳过不应返回给前端的字段
        if (entry.key != '__className__' && entry.key != 'password') {
          cleaned[entry.key] = clean(entry.value);
        }
        // 格式化时间字段（仅在值为 DateTime 时处理）
        if (entry.key == 'createTime' || entry.key == 'updateTime' || entry.key == 'loginTime') {
          if (entry.value is String) {
            cleaned[entry.key] = DateTimeFormatter.formatString(entry.value);
          } else {
            cleaned[entry.key] = entry.value;
          }
        }
      }
      return cleaned;
    }

    // 基本类型直接返回
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

