import 'query_condition.dart';
import 'query_sort.dart';

/// 通用查询请求 DTO。
///
/// - page/pageSize：分页
/// - filters：结构化过滤条件
/// - sort：排序条件
/// - keyword：关键字搜索
class QueryDTO {

  /// 默认页大小的**唯一出处**（每页请求上限见 `CrudConfig.maxPageSize`）。
  static const int defaultPageSize = 20;

  final int page;
  final int pageSize;
  final List<QueryCondition>? filters;
  final List<QuerySort>? sort;
  final String? keyword;

  const QueryDTO({this.page = 1, this.pageSize = defaultPageSize, this.filters, this.sort, this.keyword});

  QueryDTO copyWith({int? page, int? pageSize, List<QueryCondition>? filters, List<QuerySort>? sort, String? keyword}) {
    return QueryDTO(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      filters: filters ?? this.filters,
      sort: sort ?? this.sort,
      keyword: keyword ?? this.keyword,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'filters': filters?.map((f) => f.toJson()).toList(),
      'sort': sort?.map((s) => s.toJson()).toList(),
      'keyword': keyword,
    };
  }
}