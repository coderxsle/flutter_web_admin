import 'dart:convert';

import 'package:serverpod/serverpod.dart';

// Query filter condition
// 单条过滤条件（会被 QueryRequest.filters 引用）。
//
// 设计说明：
// - field：前端传入的业务字段名（例如 name / createTime / status）
// - comparator：比较运算符，内置支持 eq/ne/like/ilike/in/between/gt/gte/lt/lte
//   也支持通过插件扩展（例如 contains）
// - value：过滤值，协议层使用 String? 以兼容 Serverpod 模型限制，
//   服务端会在 mapper 中尝试 jsonDecode 转回 number/bool/list/map/null
//
// 示例：
// - { field: "name", comparator: "like", value: "serverpod" }
// - { field: "status", comparator: "eq", value: "1" }
// - { field: "ids", comparator: "in", value: "[1,2,3]" }
// - { field: "createTime", comparator: "between", value: "[\"2026-01-01\",\"2026-12-31\"]" }

class QueryFilter implements SerializableModel {
  // 字段名，例如：name / createTime / status
  final String field;

  // 比较运算符：eq/ne/like/in/between/gt/gte/lt/lte
  final String comparator;

  // 过滤值（原始为 String，可能是 JSON 字符串）
  final String? value;

  QueryFilter({required this.field, required this.comparator, this.value});

  // 从 JSON 构建
  factory QueryFilter.fromJson(Map<String, dynamic> json) {
    return QueryFilter(
      field: json['field'] as String,
      comparator: json['comparator'] as String,
      value: json['value'] as String?,
    );
  }

  // 转 JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'comparator': comparator,
      'value': value,
    };
  }

  // 🚀 扩展：自动解析 value（核心能力）
  dynamic get parsedValue {
    if (value == null) return null;

    try {
      return _tryDecode(value!);
    } catch (_) {
      return value;
    }
  }

  dynamic _tryDecode(String val) {
    // 尝试 JSON 解析
    if (val.startsWith('[') || val.startsWith('{')) {
      return _safeJsonDecode(val);
    }

    // bool
    if (val == 'true') return true;
    if (val == 'false') return false;

    // int
    final intVal = int.tryParse(val);
    if (intVal != null) return intVal;

    // double
    final doubleVal = double.tryParse(val);
    if (doubleVal != null) return doubleVal;

    return val;
  }

  dynamic _safeJsonDecode(String val) {
    try {
      return jsonDecode(val);
    } catch (_) {
      return val;
    }
  }
}