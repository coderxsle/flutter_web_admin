/// 排盘入参时间模型（对应安卓 other/ZYDatetimeModel）
class ZYDatetimeModel {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;

  ZYDatetimeModel({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    this.minute = 0,
    this.second = 0,
  });

  factory ZYDatetimeModel.fromDateTime(DateTime dt) => ZYDatetimeModel(
        year: dt.year,
        month: dt.month,
        day: dt.day,
        hour: dt.hour,
        minute: dt.minute,
        second: dt.second,
      );

  DateTime toDateTime() =>
      DateTime(year, month, day, hour, minute, second);

  ZYDatetimeModel copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) =>
      ZYDatetimeModel(
        year: year ?? this.year,
        month: month ?? this.month,
        day: day ?? this.day,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        second: second ?? this.second,
      );

  @override
  String toString() => '$year-$month-$day $hour:$minute:$second';
}
