
// 分页
class PageModel {
  num? pageSize;            // 设置每页返回的数据条数
  num? dataCount;           // 当前页的数据总量
  num? pagination;          // 当前页码
  num? nextPagination;      // 下一页的页码
  num? paginationCount;     // 总页码
  dynamic dataList;         // 数据

  PageModel({this.pageSize=20,this.dataCount,this.pagination=1,this.nextPagination=1,this.paginationCount,this.dataList});

  PageModel.fromJson(Map<String, dynamic> json) {
    pageSize = json['pageSize']??20;
    dataCount = json['dataCount'];
    pagination = json['pagination']??1;
    nextPagination = json['nextPagination']??1;
    paginationCount = json['paginationCount'];
    dataList = json['dataList'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pageSize': pageSize,
      'pagination': pagination,
      // 'nextPagination': nextPagination,
      // 'dataCount': dataCount,
      // 'paginationCount': paginationCount,
      // 'dataList': dataList,
    };
  }
}