import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../theme/app_theme.dart';

/// 年月日 → 时分 两步选择，任一步取消返回 null。
/// 不用插件的 showDateTimePicker：它最多三列、年份不上轮盘，选几十年前的日期没法用。
Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initial,
}) async {
  final date = await DatePicker.showDatePicker(
    context,
    locale: LocaleType.zh,
    currentTime: initial,
    minTime: DateTime(1900),
    maxTime: DateTime(2100, 12, 31),
    theme: datePickerTheme,
  );
  if (date == null || !context.mounted) return null;

  final time = await DatePicker.showTimePicker(
    context,
    locale: LocaleType.zh,
    showSecondsColumn: false,
    currentTime: initial,
    theme: datePickerTheme,
  );
  if (time == null) return null;

  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
