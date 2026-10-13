import 'constant_api.dart';

/// 分页结果。
///
/// 字段与后端 `PageResponse.toJson()` 的 `data` 一一对应：
/// `{records, total, page, pageSize, totalPage}`，
/// 见 backend/flutter_web_server/lib/src/common/page_response.dart。
class PageModel {
  int page; // 当前页码，从 1 开始
  int pageSize; // 每页条数
  int total; // 总条数
  int totalPage; // 总页数
  List records; // 当前页数据

  PageModel({
    this.page = pageNum_default_first,
    this.pageSize = pageSize_default,
    this.total = 0,
    this.totalPage = 0,
    this.records = const [],
  });

  /// 还有下一页
  bool get hasMore => page < totalPage;

  factory PageModel.fromJson(Map<String, dynamic> json) {
    final pageSize = (json['pageSize'] as num?)?.toInt() ?? pageSize_default;
    final total = (json['total'] as num?)?.toInt() ?? 0;
    return PageModel(
      page: (json['page'] as num?)?.toInt() ?? pageNum_default_first,
      pageSize: pageSize,
      total: total,
      // 后端会下发 totalPage，缺了按 total/pageSize 现算
      totalPage: (json['totalPage'] as num?)?.toInt() ?? (pageSize <= 0 ? 0 : (total / pageSize).ceil()),
      records: (json['records'] as List?) ?? const [],
    );
  }

  /// 列表请求的分页参数，后端从 query 里读 `page` / `pageSize`
  Map<String, dynamic> toJson() => {'page': page, 'pageSize': pageSize};
}


// 小区
class CommunityData {
  final String? companyId;
  final String? communityId;
  final String? communityName;
  final String? firstSpell; // 首字母

  CommunityData({this.companyId, this.communityId, this.communityName, this.firstSpell, });

  factory CommunityData.fromJson(Map<dynamic, dynamic> json) {
    return CommunityData(
      companyId : json['companyId'].toString(),
      communityId : json['communityId'].toString(),
      communityName : json['communityName'].toString(),
      firstSpell : json['firstSpell'].toString(),
    );
  }

}


class DataModel {
  final String? name;
  DataModel({this.name});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      name: json['name'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}