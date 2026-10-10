
// 分页
class PageModel {
  num? pageSize;            // 设置每页返回的数据条数
  num? dataCount;           // 当前页的数据总量
  num? pagination;          // 当前页码
  num? nextPagination;      // 下一页的页码
  num? paginationCount;     // 总页码
  dynamic dataList;         // 数据

  PageModel({this.pageSize=10,this.dataCount,this.pagination=1,this.nextPagination=1,this.paginationCount,this.dataList});

  PageModel.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize']??10;
    dataCount = json['dataCount'];
    pagination = json['pagination']??1;
    nextPagination = json['nextPagination']??1;
    paginationCount = json['paginationCount'];
    dataList = json['dataList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pageSize': pageSize ?? 10,
       // 当前页码,需要传下一页的页码
      'pagination': (nextPagination ?? 1) > 1 ? nextPagination : 1,
      // 'nextPagination': nextPagination,
      // 'dataCount': dataCount,
      // 'paginationCount': paginationCount,
      // 'dataList': dataList,
    };
  }
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