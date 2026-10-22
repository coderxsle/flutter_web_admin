import 'dart:convert';

/// 术数类型取值，与库里 arts_record.arts_type 保持一致的汉字。
class ArtsRecordType {
  ArtsRecordType._();

  static const String qimen = '奇门';
  static const String bazi = '八字';
}

/// 一条服务端排盘记录（`arts_record`）。
///
/// 起盘入参与盘面快照都以 JSON 对象返回，历史列表与结果页都读这一份，
/// 不再依赖本地缓存，换设备也能看到同一批记录。
class ArtsRecordItem {
  const ArtsRecordItem({
    required this.id,
    required this.artsType,
    required this.clientKey,
    required this.title,
    required this.question,
    required this.chartTime,
    required this.queryParams,
    required this.chartSnapshot,
    required this.interpretation,
    required this.feedback,
    required this.tags,
    required this.createTime,
  });

  /// 服务端主键，删除与详情用
  final int id;

  /// [ArtsRecordType.qimen] / [ArtsRecordType.bazi]
  final String artsType;

  /// 客户端生成的幂等键，再次保存时沿用同一条
  final String clientKey;

  final String title;
  final String question;
  final DateTime? chartTime;

  /// 起盘入参：八字取生辰与四柱，奇门取局式与盘式开关
  final Map<String, dynamic> queryParams;

  /// 盘面快照，仅供对照，不参与重算
  final Map<String, dynamic> chartSnapshot;

  final String interpretation;
  final String feedback;
  final List<String> tags;
  final DateTime? createTime;

  /// 列表主标题：奇门取占事，八字取姓名
  String get displayTitle {
    final text = title.trim().isNotEmpty ? title.trim() : question.trim();
    if (text.isNotEmpty) return text;
    return artsType == ArtsRecordType.bazi ? '未命名' : '未填写占事';
  }

  static ArtsRecordItem? fromJson(Map<String, dynamic> json) {
    final id = jsonInt(json['id']);
    final clientKey = (json['clientKey'] as String? ?? '').trim();
    if (id == null || id <= 0 || clientKey.isEmpty) return null;
    return ArtsRecordItem(
      id: id,
      artsType: json['artsType'] as String? ?? '',
      clientKey: clientKey,
      title: json['title'] as String? ?? '',
      question: json['question'] as String? ?? '',
      chartTime: DateTime.tryParse(json['chartTime'] as String? ?? ''),
      queryParams: jsonMap(json['queryParams']),
      chartSnapshot: jsonMap(json['chartSnapshot']),
      interpretation: json['interpretation'] as String? ?? '',
      feedback: json['feedback'] as String? ?? '',
      tags: (json['tags'] as List?)?.whereType<String>().toList() ?? const <String>[],
      createTime: DateTime.tryParse(json['createTime'] as String? ?? ''),
    );
  }
}

/// JSON 列可能是对象，也可能是没解析开的文本，统一成对象
Map<String, dynamic> jsonMap(Object? value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  if (value is String && value.trim().isNotEmpty) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } on FormatException {
      // 不是 JSON 就按空对象处理，页面照常能打开
    }
  }
  return <String, dynamic>{};
}

int? jsonInt(Object? value) => switch (value) {
      final num v => v.toInt(),
      final String v => int.tryParse(v.trim()),
      _ => null,
    };
