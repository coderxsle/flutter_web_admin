import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 基于 tdesign [TPickerPopup] + [TDateTimePicker] 封装的时间选择弹窗。
///
/// 官方入口仍要调用方自管受控值与确认/取消，这里补「命令式调用 + Future 回传」。
///
/// 返回值：确认时返回所选时间，取消或点击蒙层返回 null。
Future<DateTime?> showTDateTimePicker({
  required BuildContext context,
  required DateTime initial,
  String title = '选择时间',
  bool withSecond = true,
  int startYear = 1900,
  int endYear = 2100,
}) {
  var picked = initial;
  final completer = Completer<DateTime?>();

  TPickerPopup.show(
    context,
    headerBuilder: (_, close) => TPopupHeader(
      title: Text(title),
      cancelButton: TButton(
        size: TButtonSize.small,
        variant: TButtonVariant.text,
        onPressed: () {
          if (!completer.isCompleted) completer.complete(null);
          close();
        },
        child: const Text('取消'),
      ),
      confirmButton: TButton(
        size: TButtonSize.small,
        variant: TButtonVariant.text,
        onPressed: () {
          if (!completer.isCompleted) completer.complete(picked);
          close();
        },
        child: const Text('确定'),
      ),
    ),
    // 新版的滚轮是受控的：不把选中值回传并重建，松手会弹回原位
    child: StatefulBuilder(
      builder: (ctx, setPopupState) => TDateTimePicker(
        value: TDateTimePickerValue(
          year: picked.year,
          month: picked.month,
          day: picked.day,
          hour: picked.hour,
          minute: picked.minute,
          second: picked.second,
        ),
        mode: DateTimePickerMode(
          dateMode: DateMode.date,
          timeMode: withSecond ? TimeMode.second : TimeMode.minute,
        ),
        start: TDateTimePickerValue(year: startYear),
        end: TDateTimePickerValue(year: endYear),
        onChanged: (value) => setPopupState(() {
          picked = value.toDateTime(fallback: initial);
        }),
      ),
    ),
    // 点蒙层关闭时兜底回 null
    onClosed: () {
      if (!completer.isCompleted) completer.complete(null);
    },
  );

  return completer.future;
}

/// 输入页的「一行标签 + 值」展示行，点击可触发选择。
class TFormRow extends StatelessWidget {
  const TFormRow({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
    this.showArrow = true,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return TCell(
      title: Text(label, style: const TextStyle(fontSize: 15, color: Colors.black)),
      note: Text(value, style: const TextStyle(fontSize: 14)),
      arrow: showArrow,
      onTap: onTap,
    );
  }
}
