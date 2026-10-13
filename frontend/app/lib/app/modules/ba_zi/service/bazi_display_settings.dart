import 'package:get_storage/get_storage.dart';

/// 八字结果页的显示设置，落 GetStorage 全局持久化。
///
/// 主要给「专业盘」用户收口：只看四柱时把神煞、五行、旺衰等段关掉，
/// 界面就只剩自己关心的内容。
class BaziDisplaySettings {
  BaziDisplaySettings({
    this.shenSha = true,
    this.wuXing = true,
    this.wangShuai = true,
    this.yunShi = true,
    this.relation = true,
    this.timePanel = true,
    this.rowShiShen = true,
    this.rowChangSheng = true,
  });

  /// 神煞段开关
  bool shenSha;

  /// 五行段开关
  bool wuXing;

  /// 旺衰格局段开关
  bool wangShuai;

  /// 运势曲线段开关
  bool yunShi;

  /// 干支关系段开关
  bool relation;

  /// 时间推演段开关
  bool timePanel;

  /// 四柱表的十神行
  bool rowShiShen;

  /// 四柱表的长生行
  bool rowChangSheng;

  static const String storageKey = 'bazi_display_settings';

  static GetStorage get _box => GetStorage();

  static BaziDisplaySettings load() {
    final raw = _box.read(storageKey);
    if (raw is! Map) return BaziDisplaySettings();

    bool read(String key, bool fallback) {
      final value = raw[key];
      return value is bool ? value : fallback;
    }

    return BaziDisplaySettings(
      shenSha: read('shenSha', true),
      wuXing: read('wuXing', true),
      wangShuai: read('wangShuai', true),
      yunShi: read('yunShi', true),
      relation: read('relation', true),
      timePanel: read('timePanel', true),
      rowShiShen: read('rowShiShen', true),
      rowChangSheng: read('rowChangSheng', true),
    );
  }

  Map<String, bool> toJson() => {
        'shenSha': shenSha,
        'wuXing': wuXing,
        'wangShuai': wangShuai,
        'yunShi': yunShi,
        'relation': relation,
        'timePanel': timePanel,
        'rowShiShen': rowShiShen,
        'rowChangSheng': rowChangSheng,
      };

  void save() => _box.write(storageKey, toJson());
}
