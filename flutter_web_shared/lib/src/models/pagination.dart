// import 'package:serverpod_serialization/serverpod_serialization.dart';

// /// 分页请求参数
// class Pagination implements SerializableModel {
//   /// 页码，从 1 开始
//   final int page;

//   /// 每页数量
//   final int pageSize;

//   /// 排序字段
//   final String? orderBy;

//   /// 是否降序
//   final bool? orderDescending;

//   /// 搜索关键词
//   final String? keyword;

//   Pagination({
//     this.page = 1,
//     this.pageSize = 20,
//     this.orderBy,
//     this.orderDescending,
//     this.keyword,
//   });

//   /// 计算偏移量
//   int get offset => (page - 1) * pageSize;

//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       'page': page,
//       'pageSize': pageSize,
//       if (orderBy != null) 'orderBy': orderBy,
//       if (orderDescending != null) 'orderDescending': orderDescending,
//       if (keyword != null) 'keyword': keyword,
//     };
//   }

//   @override
//   factory Pagination.fromJson(Map<String, dynamic> json) {
//     return Pagination(
//       page: json['page'] as int? ?? 1,
//       pageSize: json['pageSize'] as int? ?? 20,
//       orderBy: json['orderBy'] as String?,
//       orderDescending: json['orderDescending'] as bool?,
//       keyword: json['keyword'] as String?,
//     );
//   }

//   Pagination copyWith({
//     int? page,
//     int? pageSize,
//     String? orderBy,
//     bool? orderDescending,
//     String? keyword,
//   }) {
//     return Pagination(
//       page: page ?? this.page,
//       pageSize: pageSize ?? this.pageSize,
//       orderBy: orderBy ?? this.orderBy,
//       orderDescending: orderDescending ?? this.orderDescending,
//       keyword: keyword ?? this.keyword,
//     );
//   }

//   @override
//   String toString() {
//     return 'Pagination(page: $page, pageSize: $pageSize, keyword: $keyword)';
//   }
// }
