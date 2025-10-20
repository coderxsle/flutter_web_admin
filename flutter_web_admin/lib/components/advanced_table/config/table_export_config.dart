/// 导出格式
enum ExportFormat {
  excel,
  csv,
  json,
}

/// 表格导出配置
class TableExportConfig {
  /// 是否启用 Excel 导出
  final bool enableExcel;
  
  /// 是否启用 CSV 导出
  final bool enableCSV;
  
  /// 是否启用 JSON 导出
  final bool enableJSON;
  
  /// 默认文件名
  final String fileName;
  
  /// 是否导出所有数据（包括未显示的列）
  final bool exportAllColumns;
  
  /// 是否导出所有页（服务端分页时）
  final bool exportAllPages;
  
  /// 数据格式化函数
  final Map<String, String Function(dynamic)>? formatters;
  
  /// 表头文本映射
  final Map<String, String>? headerLabels;

  const TableExportConfig({
    this.enableExcel = true,
    this.enableCSV = true,
    this.enableJSON = false,
    this.fileName = 'table_data',
    this.exportAllColumns = false,
    this.exportAllPages = false,
    this.formatters,
    this.headerLabels,
  });

  /// 是否启用导出功能
  bool get enabled => enableExcel || enableCSV || enableJSON;

  /// 获取支持的导出格式
  List<ExportFormat> get supportedFormats {
    final formats = <ExportFormat>[];
    if (enableExcel) formats.add(ExportFormat.excel);
    if (enableCSV) formats.add(ExportFormat.csv);
    if (enableJSON) formats.add(ExportFormat.json);
    return formats;
  }

  /// 复制并修改
  TableExportConfig copyWith({
    bool? enableExcel,
    bool? enableCSV,
    bool? enableJSON,
    String? fileName,
    bool? exportAllColumns,
    bool? exportAllPages,
    Map<String, String Function(dynamic)>? formatters,
    Map<String, String>? headerLabels,
  }) {
    return TableExportConfig(
      enableExcel: enableExcel ?? this.enableExcel,
      enableCSV: enableCSV ?? this.enableCSV,
      enableJSON: enableJSON ?? this.enableJSON,
      fileName: fileName ?? this.fileName,
      exportAllColumns: exportAllColumns ?? this.exportAllColumns,
      exportAllPages: exportAllPages ?? this.exportAllPages,
      formatters: formatters ?? this.formatters,
      headerLabels: headerLabels ?? this.headerLabels,
    );
  }
}



