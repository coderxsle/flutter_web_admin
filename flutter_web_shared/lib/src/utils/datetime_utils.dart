/// 通用时间格式化工具，统一将 UTC 时间转换为本地时间并输出字符串。
class DateTimeFormatter {


  /// 将 [dt] 转为本地时间后格式化为 `yyyy-MM-dd HH:mm:ss` 字符串。
  /// 
  /// [dt] 为空，则返回空字符串。
  static String format(dynamic dt) {
    if (dt == null) {
      return '';
    }
    final local = dt.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    final s = local.second.toString().padLeft(2, '0');
    return '$y-$m-$d $h:$min:$s';
  }


  /// 将 [dtString] 转为本地时间后格式化为 `yyyy-MM-dd HH:mm:ss` 字符串。
  ///
  /// 如果 [dtString] 格式不正确，则返回空字符串。
  /// 如果 [dtString] 为空或空字符串，则返回空字符串。
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

