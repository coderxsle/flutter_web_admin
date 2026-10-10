import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 基于 tdesign [TPopup] + [TDateTimePicker] 封装的时间选择弹窗。
///
/// tdesign 的 [TDateTimePicker] 只提供滚轮本体，没有命令式弹窗入口，
/// 这里补齐「底部弹窗 + 取消/确定回传」的交互。
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

  TPopup.show(
    context,
    options: TPopupOptions.bottom(
      titleWidget: Text(title),
      child: SizedBox(
        height: 200.h,
        child: TDateTimePicker(
          value: TDateTimePickerValue(
            year: initial.year,
            month: initial.month,
            day: initial.day,
            hour: initial.hour,
            minute: initial.minute,
            second: initial.second,
          ),
          mode: DateTimePickerMode(
            dateMode: DateMode.date,
            timeMode: withSecond ? TimeMode.second : TimeMode.minute,
          ),
          start: TDateTimePickerValue(year: startYear),
          end: TDateTimePickerValue(year: endYear),
          onChanged: (value) => picked = value.toDateTime(fallback: initial),
        ),
      ),
      cancelBuilder: (ctx, close) => TButton(
        size: TButtonSize.small,
        variant: TButtonVariant.text,
        onPressed: () {
          if (!completer.isCompleted) completer.complete(null);
          close();
        },
        child: const Text('取消'),
      ),
      confirmBuilder: (ctx, close) => TButton(
        size: TButtonSize.small,
        variant: TButtonVariant.text,
        onPressed: () {
          if (!completer.isCompleted) completer.complete(picked);
          close();
        },
        child: const Text('确定'),
      ),
      // 点蒙层关闭时兜底回 null
      onClosed: () {
        if (!completer.isCompleted) completer.complete(null);
      },
    ),
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
