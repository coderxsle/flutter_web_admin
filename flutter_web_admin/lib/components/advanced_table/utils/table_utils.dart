import 'package:flutter/material.dart';

/// 表格工具类
class TableUtils {
  /// 防抖函数
  static void Function() debounce(
    void Function() function, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(duration, function);
    };
  }

  /// 节流函数
  static void Function() throttle(
    void Function() function, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    bool canExecute = true;
    return () {
      if (canExecute) {
        function();
        canExecute = false;
        Timer(duration, () {
          canExecute = true;
        });
      }
    };
  }

  /// 计算文本宽度
  static double calculateTextWidth(
    String text,
    TextStyle style, {
    double padding = 16.0,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    
    return textPainter.width + padding;
  }

  /// 生成唯一 ID
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  /// 下载文件（Web）
  static void downloadFile(String content, String fileName, String mimeType) {
    // Web 平台下载实现
    // 注意：这需要 dart:html，在实际使用时需要条件导入
    // import 'dart:html' as html;
    
    // final blob = html.Blob([content], mimeType);
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // final anchor = html.AnchorElement(href: url)
    //   ..setAttribute('download', fileName)
    //   ..click();
    // html.Url.revokeObjectUrl(url);
    
    debugPrint('下载文件: $fileName');
  }

  /// 格式化日期
  static String formatDate(DateTime? date, {String format = 'yyyy-MM-dd'}) {
    if (date == null) return '';
    
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');
    
    return format
        .replaceAll('yyyy', year)
        .replaceAll('MM', month)
        .replaceAll('dd', day)
        .replaceAll('HH', hour)
        .replaceAll('mm', minute)
        .replaceAll('ss', second);
  }

  /// 格式化数字
  static String formatNumber(num? number, {int decimals = 2}) {
    if (number == null) return '';
    return number.toStringAsFixed(decimals);
  }

  /// 复制到剪贴板
  static Future<void> copyToClipboard(String text) async {
    // await Clipboard.setData(ClipboardData(text: text));
    debugPrint('复制到剪贴板: $text');
  }

  /// 获取对比色（用于高亮显示）
  static Color getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  /// 生成随机颜色
  static Color getRandomColor() {
    return Color((DateTime.now().millisecondsSinceEpoch % 0xFFFFFF) + 0xFF000000);
  }
}

/// Timer 类（简化版，实际使用 dart:async）
class Timer {
  final Duration duration;
  final void Function() callback;

  Timer(this.duration, this.callback) {
    Future.delayed(duration, callback);
  }

  void cancel() {
    // 简化版，实际需要真正的取消逻辑
  }
}



