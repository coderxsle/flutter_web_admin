import 'package:serverpod/serverpod.dart';

import 'query_filter.dart';
import 'query_sort.dart';

/// 通用查询请求体（分页 + 过滤 + 排序 + 关键词）。
///
/// 典型调用流程：
/// 1) 前端构造 QueryRequest 并调用 endpoint.query
/// 2) 服务端将 QueryRequest 映射为 core.QueryDTO
/// 3) QueryEngine 根据 DTO 生成 where/order/limit/offset 并执行查询
///
/// 字段说明：
/// - page：页码，从 1 开始
/// - pageSize：每页数量，建议 <= 200（最终以服务端校验为准）
/// - filters：结构化过滤条件列表（AND 组合）
/// - sort：排序条件列表（按顺序生效）
/// - keyword：关键词检索，具体匹配哪些字段由实体 keywordColumns 决定
class QueryRequest implements SerializableModel {
  /// 页码，从 1 开始
  final int page;

  /// 每页数量，建议 <= 200
  final int pageSize;

  /// 关键词搜索
  final String? keyword;

  /// 结构化过滤条件（AND）
  final List<QueryFilter>? filters;

  /// 排序条件（多字段排序）
  final List<QuerySort>? sort;

  /// 限制条数（用于 SQL limit）
  int get limit => pageSize;

  /// 偏移量（用于 SQL offset）
  int get offset => (page - 1) * pageSize;

  QueryRequest({this.page = 1, this.pageSize = 20, this.filters, this.sort,  this.keyword});

  /// 从 JSON 构建
  @override
  factory QueryRequest.fromJson(Map<String, dynamic> json) {
    return QueryRequest(
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      filters: (json['filters'] as List?)
          ?.map((e) => QueryFilter.fromJson(e))
          .toList(),
      sort: (json['sort'] as List?)
          ?.map((e) => QuerySort.fromJson(e))
          .toList(),
      keyword: json['keyword'],
    );
  }

  /// 转 JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'filters': filters?.map((e) => e.toJson()).toList(),
      'sort': sort?.map((e) => e.toJson()).toList(),
      'keyword': keyword,
    };
  }

}