import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../theme/app_theme.dart';
import '../algorithm/chn_chinese_calendar.dart';

/// 年月日 → 时分 两步选择，任一步取消返回 null。
/// 不用插件的 showDateTimePicker：它最多三列、年份不上轮盘，选几十年前的日期没法用。
Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initial,
}) async {
  final model = _LunarDateModel(
    currentTime: initial,
    minTime: DateTime(1900),
    maxTime: DateTime(2100, 12, 31),
  );
  final date = await DatePicker.showPicker(
    context,
    locale: LocaleType.zh,
    pickerModel: model,
    theme: datePickerLunarTheme,
    titleActionsBuilder: (context, onCancel, onConfirm, selected) =>
        ValueListenableBuilder<DateTime>(
      valueListenable: model.live,
      builder: (context, current, child) =>
          _lunarTitle(onCancel, onConfirm, current),
    ),
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

/// 滚轮滚动中插件只改 model 不重建标题栏，农历会停在松手前那一刻。
/// 这里把三个 setIndex 转发给 notifier，标题栏订阅它就能跟着滚轮实时变。
class _LunarDateModel extends DatePickerModel {
  _LunarDateModel({
    required DateTime currentTime,
    required DateTime minTime,
    required DateTime maxTime,
  }) : super(
          currentTime: currentTime,
          minTime: minTime,
          maxTime: maxTime,
          locale: LocaleType.zh,
        );

  late final ValueNotifier<DateTime> live = ValueNotifier(currentTime);

  void _publish() => live.value = currentTime;

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);
    _publish();
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    _publish();
  }

  @override
  void setRightIndex(int index) {
    super.setRightIndex(index);
    _publish();
  }
}

/// 插件没留「滚轮上方单加一行」的位置，只能整体接管标题栏：
/// 上一行取消/确定，下一行公历+农历。
Widget _lunarTitle(
  VoidCallback onCancel,
  VoidCallback onConfirm,
  DateTime current,
) {
  final md = '${current.year} 年 ${current.month} 月 ${current.day} 日';
  final lunar = ChnChineseCalendar.instance.getLunarSolarCalendarWithYear(
    current.year,
    current.month,
    current.day,
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: pickerTitleRowHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _titleButton('取消', datePickerTheme.cancelStyle, onCancel),
            _titleButton('确定', datePickerTheme.doneStyle, onConfirm),
          ],
        ),
      ),
      SizedBox(
        height: pickerLunarRowHeight,
        child: Center(
          child: Text(
            lunar == null ? md : '$md · 农历$lunar',
            style: const TextStyle(fontSize: 16, color: TdColors.grey85),
          ),
        ),
      ),
    ],
  );
}

/// 标题栏按钮。插件默认那版是 CupertinoButton，用 TextButton 省一个 import。
Widget _titleButton(String text, TextStyle style, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      minimumSize: const Size(0, pickerTitleRowHeight),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    child: Text(text, style: style),
  );
}
