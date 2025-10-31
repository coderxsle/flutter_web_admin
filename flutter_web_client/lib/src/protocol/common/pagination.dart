/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 分页请求参数
/// 用于所有分页查询的通用参数模型
abstract class Pagination implements _i1.SerializableModel {
  Pagination._({
    int? page,
    int? pageSize,
    this.orderBy,
    this.orderDescending,
    this.keyword,
  })  : page = page ?? 1,
        pageSize = pageSize ?? 20;

  factory Pagination({
    int? page,
    int? pageSize,
    String? orderBy,
    bool? orderDescending,
    String? keyword,
  }) = _PaginationImpl;

  factory Pagination.fromJson(Map<String, dynamic> jsonSerialization) {
    return Pagination(
      page: jsonSerialization['page'] as int,
      pageSize: jsonSerialization['pageSize'] as int,
      orderBy: jsonSerialization['orderBy'] as String?,
      orderDescending: jsonSerialization['orderDescending'] as bool?,
      keyword: jsonSerialization['keyword'] as String?,
    );
  }

  /// 页码，从 1 开始
  int page;

  /// 每页数量
  int pageSize;

  /// 排序字段
  String? orderBy;

  /// 是否降序排序
  bool? orderDescending;

  /// 搜索关键词
  String? keyword;

  /// Returns a shallow copy of this [Pagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Pagination copyWith({
    int? page,
    int? pageSize,
    String? orderBy,
    bool? orderDescending,
    String? keyword,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      if (orderBy != null) 'orderBy': orderBy,
      if (orderDescending != null) 'orderDescending': orderDescending,
      if (keyword != null) 'keyword': keyword,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaginationImpl extends Pagination {
  _PaginationImpl({
    int? page,
    int? pageSize,
    String? orderBy,
    bool? orderDescending,
    String? keyword,
  }) : super._(
          page: page,
          pageSize: pageSize,
          orderBy: orderBy,
          orderDescending: orderDescending,
          keyword: keyword,
        );

  /// Returns a shallow copy of this [Pagination]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Pagination copyWith({
    int? page,
    int? pageSize,
    Object? orderBy = _Undefined,
    Object? orderDescending = _Undefined,
    Object? keyword = _Undefined,
  }) {
    return Pagination(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      orderBy: orderBy is String? ? orderBy : this.orderBy,
      orderDescending:
          orderDescending is bool? ? orderDescending : this.orderDescending,
      keyword: keyword is String? ? keyword : this.keyword,
    );
  }
}
