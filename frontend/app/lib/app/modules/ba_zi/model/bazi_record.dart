import '../../zhouyi/algorithm/zy_datetime_model.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/http/arts_record_item.dart';

/// 一条八字命例的起盘入参。
///
/// 只存参数不存盘面：回看时用同一套算法重算，算法更新后旧记录也不会失真。
/// [year]…[minute] 是**已做真太阳时校正后**的时间；[pillars] 非空表示甲子历直录。
class BaziRecord {
  BaziRecord({
    required this.clientKey,
    required this.name,
    required this.sex,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.yeZiShi,
    this.longitude,
    this.pillars,
    this.beiZhu = '',
    this.feedback = '',
    List<String>? tags,
  }) : tags = tags ?? <String>[];

  /// 服务端幂等键，补写卦解/反馈时认这一条
  final String clientKey;

  final String name;

  /// 0=女 1=男
  final int sex;

  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final bool yeZiShi;

  /// 出生地经度，仅用于回显；为 null 表示未校正
  final double? longitude;

  /// 甲子历直录的四柱（年/月/日/时各一条二字干支），长度恒为 4
  final List<String>? pillars;

  /// 是否为甲子历直录的命例
  bool get isPillarInput => pillars != null && pillars!.length == 4;

  /// 卦解/断语
  String beiZhu;

  /// 反馈/应验
  String feedback;

  /// 命例标签
  List<String> tags;

  ZYDatetimeModel toDateTime() => ZYDatetimeModel(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
      );

  /// 「1998年05月12日 10时30分」，甲子历记录则直接列四柱
  String get birthLabel {
    if (isPillarInput) return '甲子历　${pillars!.join(' ')}';
    String p2(int v) => v.toString().padLeft(2, '0');
    return '$year年${p2(month)}月${p2(day)}日 ${p2(hour)}时${p2(minute)}分';
  }

  /// 服务端记录还原成命例：生辰与四柱存在 `query_params` 里
  factory BaziRecord.fromArtsRecord(ArtsRecordItem item) {
    final params = item.queryParams;
    final birth = jsonMap(params['birth']);
    return BaziRecord(
      clientKey: item.clientKey,
      name: item.title,
      sex: jsonInt(params['sex']) ?? BaziSex.man,
      year: jsonInt(birth['year']) ?? 0,
      month: jsonInt(birth['month']) ?? 0,
      day: jsonInt(birth['day']) ?? 0,
      hour: jsonInt(birth['hour']) ?? 0,
      minute: jsonInt(birth['minute']) ?? 0,
      yeZiShi: params['ye_zi_shi'] == true,
      longitude: (params['longitude'] as num?)?.toDouble(),
      pillars: (params['pillars'] as List?)?.whereType<String>().toList(),
      beiZhu: item.interpretation,
      feedback: item.feedback,
      tags: item.tags.toList(),
    );
  }
}
