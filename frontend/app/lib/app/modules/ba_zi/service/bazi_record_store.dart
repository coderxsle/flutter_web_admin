import 'package:get_storage/get_storage.dart';

import '../../zhouyi/algorithm/zy_datetime_model.dart';

/// 一条本地排盘记录。
///
/// 只存入参（而非盘面）：回读时用同一套算法重算，算法更新后旧记录也不会失真。
/// [year]…[minute] 存的是**已做真太阳时校正后**的时间。
/// [pillars] 非空表示这是「甲子历直录」的命例，没有公历生辰，年月的 0 值不可用。
class BaziRecord {
  BaziRecord({
    required this.id,
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
    int? createdAt,
  })  : tags = tags ?? <String>[],
        createdAt = createdAt ?? DateTime.now().millisecondsSinceEpoch;

  final String id;
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

  /// 命例标签，用于检索
  List<String> tags;

  final int createdAt;

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sex': sex,
        'year': year,
        'month': month,
        'day': day,
        'hour': hour,
        'minute': minute,
        'yeZiShi': yeZiShi,
        'longitude': longitude,
        'pillars': pillars,
        'beiZhu': beiZhu,
        'feedback': feedback,
        'tags': tags,
        'createdAt': createdAt,
      };

  static BaziRecord fromJson(Map<String, dynamic> json) => BaziRecord(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        sex: (json['sex'] as num?)?.toInt() ?? 1,
        year: (json['year'] as num?)?.toInt() ?? 1900,
        month: (json['month'] as num?)?.toInt() ?? 1,
        day: (json['day'] as num?)?.toInt() ?? 1,
        hour: (json['hour'] as num?)?.toInt() ?? 0,
        minute: (json['minute'] as num?)?.toInt() ?? 0,
        yeZiShi: json['yeZiShi'] as bool? ?? false,
        longitude: (json['longitude'] as num?)?.toDouble(),
        pillars: (json['pillars'] as List?)?.whereType<String>().toList(),
        beiZhu: json['beiZhu'] as String? ?? '',
        feedback: json['feedback'] as String? ?? '',
        tags: (json['tags'] as List?)?.whereType<String>().toList(),
        createdAt: (json['createdAt'] as num?)?.toInt(),
      );
}

/// 排盘记录的本地存取，后端接入前先落在 GetStorage。
class BaziRecordStore {
  BaziRecordStore._();

  static const String _key = 'bazi_records';

  /// 单条记录最多保留的数量，超出后丢弃最旧的
  static const int maxCount = 200;

  static GetStorage get _box => GetStorage();

  /// 全部记录，按创建时间倒序（最新在前）
  static List<BaziRecord> all() {
    final raw = _box.read(_key);
    if (raw is! List) return [];
    final list = <BaziRecord>[];
    for (final item in raw) {
      if (item is Map) {
        list.add(BaziRecord.fromJson(Map<String, dynamic>.from(item)));
      }
    }
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  static BaziRecord? find(String id) {
    for (final record in all()) {
      if (record.id == id) return record;
    }
    return null;
  }

  /// 全部记录里出现过的标签，按使用次数降序
  static List<String> allTags() {
    final counter = <String, int>{};
    for (final record in all()) {
      for (final tag in record.tags) {
        counter[tag] = (counter[tag] ?? 0) + 1;
      }
    }
    final tags = counter.keys.toList()
      ..sort((a, b) {
        final byCount = counter[b]!.compareTo(counter[a]!);
        return byCount != 0 ? byCount : a.compareTo(b);
      });
    return tags;
  }

  /// 按关键字与标签过滤。[keyword] 匹配姓名、备注、反馈与标签。
  static List<BaziRecord> filter({
    String keyword = '',
    List<String> tags = const [],
  }) {
    final key = keyword.trim();
    return all().where((record) {
      if (tags.isNotEmpty && !tags.every(record.tags.contains)) return false;
      if (key.isEmpty) return true;
      return record.name.contains(key) ||
          record.beiZhu.contains(key) ||
          record.feedback.contains(key) ||
          record.tags.any((t) => t.contains(key));
    }).toList();
  }

  /// 按 id 覆盖写入；不存在则新增
  static Future<void> upsert(BaziRecord record) async {
    final list = all()..removeWhere((e) => e.id == record.id);
    list.insert(0, record);
    if (list.length > maxCount) list.removeRange(maxCount, list.length);
    await _box.write(
      _key,
      list.map((e) => e.toJson()).toList(growable: false),
    );
  }

  static Future<void> remove(String id) async {
    final list = all()..removeWhere((e) => e.id == id);
    await _box.write(
      _key,
      list.map((e) => e.toJson()).toList(growable: false),
    );
  }

  static Future<void> clear() async => _box.remove(_key);

  /// 新建记录用的 id
  static String newId() => DateTime.now().millisecondsSinceEpoch.toString();
}
