import '../../../advanced_table/config/table_column_config.dart';
import '../../../advanced_table/config/table_export_config.dart';

/// CSV 导出器
class CSVExporter {
  /// 导出数据为 CSV
  static String exportToCSV<T>({
    required List<T> data,
    required List<TableColumnConfig<T>> columns,
    required TableExportConfig config,
  }) {
    final buffer = StringBuffer();
    
    // 获取要导出的列
    final exportColumns = config.exportAllColumns
        ? columns
        : columns.where((col) => col.show).toList();
    
    // 写入表头
    final headers = exportColumns.map((col) {
      final label = config.headerLabels?[col.columnKey] ?? col.title;
      return _escapeCSVValue(label);
    }).join(',');
    buffer.writeln(headers);
    
    // 写入数据行
    for (final record in data) {
      final values = exportColumns.map((col) {
        var value = col.getValue(record);
        
        // 应用格式化函数
        if (config.formatters != null && config.formatters!.containsKey(col.columnKey)) {
          value = config.formatters![col.columnKey]!(value);
        }
        
        return _escapeCSVValue(value?.toString() ?? '');
      }).join(',');
      buffer.writeln(values);
    }
    
    return buffer.toString();
  }

  /// 转义 CSV 值
  static String _escapeCSVValue(String value) {
    // 如果包含逗号、引号或换行符，需要用引号包裹
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      // 将引号替换为两个引号
      final escaped = value.replaceAll('"', '""');
      return '"$escaped"';
    }
    return value;
  }

  /// 获取文件名
  static String getFileName(TableExportConfig config) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${config.fileName}_$timestamp.csv';
  }
}

