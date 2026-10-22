/// 统一把时间输出成 `yyyy-MM-dd HH:mm:ss`，供接口返回前使用。
class DateTimeFormatter {
  /// 按 [dt] 自身的年月日时分秒输出，**不做时区转换**。
  ///
  /// 库里的时间列是 `timestamp without time zone`，读出来就是本地墙钟；
  /// 再做 toLocal/toUtc 会额外偏移（开发机 +8、容器 UTC 不偏）。
  static String format(dynamic dt) {
    if (dt == null) return '';
    if (dt is! DateTime) return dt.toString();
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y-$m-$d $h:$min:$s';
  }

  /// 把 ISO 串转成 `yyyy-MM-dd HH:mm:ss`；解析失败或为空时返回空串。
  static String formatString(String? dtString) {
    if (dtString == null || dtString.trim().isEmpty) {
      return '';
    }
    final parsed = DateTime.tryParse(dtString.trim());
    if (parsed == null) {
      return '';
    }
    return format(parsed);
  }
}
