/// 表格分页配置
class TablePaginationConfig {
  /// 是否启用分页
  final bool enabled;
  
  /// 每页大小
  final int pageSize;
  
  /// 每页大小选项
  final List<int> pageSizeOptions;
  
  /// 是否显示每页大小选择器
  final bool showPageSize;
  
  /// 是否显示总数
  final bool showTotal;
  
  /// 是否显示快速跳转
  final bool showQuickJumper;
  
  /// 是否服务端分页
  final bool serverSide;
  
  /// 服务端分页时的加载回调
  final Future<void> Function(int page, int pageSize)? onPageLoad;
  
  /// 总数文本格式化
  final String Function(int total, int start, int end)? totalFormatter;

  const TablePaginationConfig({
    this.enabled = true,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50, 100],
    this.showPageSize = true,
    this.showTotal = true,
    this.showQuickJumper = true,
    this.serverSide = false,
    this.onPageLoad,
    this.totalFormatter,
  });

  /// 复制并修改
  TablePaginationConfig copyWith({
    bool? enabled,
    int? pageSize,
    List<int>? pageSizeOptions,
    bool? showPageSize,
    bool? showTotal,
    bool? showQuickJumper,
    bool? serverSide,
    Future<void> Function(int page, int pageSize)? onPageLoad,
    String Function(int total, int start, int end)? totalFormatter,
  }) {
    return TablePaginationConfig(
      enabled: enabled ?? this.enabled,
      pageSize: pageSize ?? this.pageSize,
      pageSizeOptions: pageSizeOptions ?? this.pageSizeOptions,
      showPageSize: showPageSize ?? this.showPageSize,
      showTotal: showTotal ?? this.showTotal,
      showQuickJumper: showQuickJumper ?? this.showQuickJumper,
      serverSide: serverSide ?? this.serverSide,
      onPageLoad: onPageLoad ?? this.onPageLoad,
      totalFormatter: totalFormatter ?? this.totalFormatter,
    );
  }
}



