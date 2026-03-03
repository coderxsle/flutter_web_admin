/// 通用时间格式化工具，统一将 UTC 时间转换为本地时间并输出字符串。
class DateTimeFormatter {
  /// 将 [dt] 转为本地时间后格式化为 `yyyy-MM-dd HH:mm:ss` 字符串。
  static String format(DateTime dt) {
    final local = dt.toLocal();
    final y = local.year.toString().padLeft(4, '0');
    final m = local.month.toString().padLeft(2, '0');
    final d = local.day.toString().padLeft(2, '0');
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    final s = local.second.toString().padLeft(2, '0');
    return '$y-$m-$d $h:$min:$s';
  }
}