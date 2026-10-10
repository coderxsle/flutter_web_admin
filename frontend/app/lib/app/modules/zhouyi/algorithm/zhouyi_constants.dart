/// 术数排盘常量（对应安卓工程 com.bubble.zhouyi.constant.Constants）
class ZhouyiConst {
  ZhouyiConst._();

  static const String shiTianGan = '甲乙丙丁戊己庚辛壬癸';
  static const String shiErDiZhi = '子丑寅卯辰巳午未申酉戌亥';

  /// 24 节气，索引 0 = 立春（对应 CHNChineseCalendar.jq0Arr）
  static const List<String> jq0Arr = [
    '立春', '雨水', '惊蛰',
    '春分', '清明', '谷雨',
    '立夏', '小满', '芒种',
    '夏至', '小暑', '大暑',
    '立秋', '处暑', '白露',
    '秋分', '寒露', '霜降',
    '立冬', '小雪', '大雪',
    '冬至', '小寒', '大寒',
  ];

  /// 拆补法基础局数（每进一元 ±6）
  static const List<int> juNumbers = [
    8, 9, 1, // 立春 雨水 惊蛰
    3, 4, 5, // 春分 清明 谷雨
    4, 5, 6, // 立夏 小满 芒种
    9, 8, 7, // 夏至 小暑 大暑
    2, 1, 9, // 立秋 处暑 白露
    7, 6, 5, // 秋分 寒露 霜降
    6, 5, 4, // 立冬 小雪 大雪
    1, 2, 3, // 冬至 小寒 大寒
  ];

  /// 置闰法基础局数（每进一元 ±3）
  static const List<int> juNumbersZhirun = [
    8, 9, 1,
    3, 4, 5,
    4, 5, 6,
    9, 8, 7,
    2, 1, 9,
    7, 6, 8, // 霜降由 5 改为 8
    6, 5, 4,
    1, 2, 3,
  ];

  static const String unitYear = '年';
  static const String unitMonth = '月';
  static const String unitDay = '日';
  static const String unitHour = '时';
  static const String unitMinute = '分';
  static const String unitSecond = '秒';
}

/// 阴遁 / 阳遁。全工程用 0 表示阴遁、1 表示阳遁，与安卓 dunType 一致。
class YinYangType {
  YinYangType._();
  static const int yin = 0;
  static const int yang = 1;
}

/// 四柱八字性别
class BaziSex {
  BaziSex._();
  static const int woman = 0;
  static const int man = 1;
}
