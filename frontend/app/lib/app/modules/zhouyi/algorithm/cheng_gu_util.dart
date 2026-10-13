/// 袁天罡称骨：年、月、日、时各有一段骨重，四项相加即总骨重，再查称骨歌。
///
/// 重量一律以「钱」为单位的整数保存，相加不做浮点运算。
/// 年月日时四表的数值取自通行本；称骨歌各版本文字略有出入，此处取流传最广的一套。
class ChengGuUtil {
  ChengGuUtil._();

  /// 年重（钱），键为六十甲子干支
  static const Map<String, int> yearWeight = {
    '甲子': 12, '乙丑': 9, '丙寅': 6, '丁卯': 7, '戊辰': 12,
    '己巳': 5, '庚午': 9, '辛未': 8, '壬申': 7, '癸酉': 8,
    '甲戌': 15, '乙亥': 9, '丙子': 16, '丁丑': 8, '戊寅': 8,
    '己卯': 19, '庚辰': 12, '辛巳': 6, '壬午': 8, '癸未': 7,
    '甲申': 5, '乙酉': 15, '丙戌': 6, '丁亥': 16, '戊子': 15,
    '己丑': 7, '庚寅': 9, '辛卯': 12, '壬辰': 10, '癸巳': 7,
    '甲午': 15, '乙未': 6, '丙申': 5, '丁酉': 14, '戊戌': 14,
    '己亥': 9, '庚子': 7, '辛丑': 7, '壬寅': 9, '癸卯': 12,
    '甲辰': 8, '乙巳': 7, '丙午': 13, '丁未': 5, '戊申': 14,
    '己酉': 5, '庚戌': 9, '辛亥': 17, '壬子': 5, '癸丑': 7,
    '甲寅': 12, '乙卯': 8, '丙辰': 8, '丁巳': 6, '戊午': 19,
    '己未': 6, '庚申': 8, '辛酉': 16, '壬戌': 10, '癸亥': 7,
  };

  /// 月重（钱），下标 0 为正月
  static const List<int> monthWeight = [
    6, 7, 18, 9, 5, 16, 9, 15, 18, 8, 9, 5,
  ];

  /// 日重（钱），下标 0 为初一
  static const List<int> dayWeight = [
    5, 10, 8, 15, 16, 15, 8, 16, 8, 16,
    9, 17, 8, 17, 10, 8, 9, 18, 5, 15,
    10, 9, 8, 9, 15, 18, 7, 8, 16, 6,
  ];

  /// 时重（钱），下标 0 为子时
  static const List<int> hourWeight = [
    16, 6, 7, 10, 9, 16, 10, 8, 8, 9, 6, 6,
  ];

  /// 称骨歌，键为总骨重（钱），区间 21 ~ 72
  static const Map<int, String> song = {
    21: '短命非业谓大空，平生灾难事重重，凶祸频临陷逆境，终世困苦事不成。',
    22: '身寒骨冷苦伶仃，此命推来行乞人，劳劳碌碌无度日，终年打拱过平生。',
    23: '此命推来骨肉轻，求谋做事事难成，妻儿兄弟实难靠，外出他乡做散人。',
    24: '此命推来福禄无，门庭困苦总难荣，六亲骨肉皆无靠，流浪他乡作老翁。',
    25: '此命推来祖业微，门庭营度似稀奇，六亲骨肉如冰炭，一世勤劳自把持。',
    26: '平生衣禄苦中求，独自营谋事不休，离祖出门宜早计，晚来衣禄自无休。',
    27: '一生作事少商量，难靠祖宗作主张，独马单枪空做去，早年晚岁总无长。',
    28: '一生行事似飘蓬，祖宗产业在梦中，若不过房改名姓，也当移徒二三通。',
    29: '初年运限未曾亨，纵有功名在后成，须过四旬才可立，移居改姓始为良。',
    30: '劳劳碌碌苦中求，东奔西走何日休，若使终身勤与俭，老来稍可免忧愁。',
    31: '忙忙碌碌苦中求，何日云开见日头，难得祖基家可立，中年衣食渐无忧。',
    32: '初年运蹇事难谋，渐有财源如水流，到得中年衣食旺，那时名利一齐收。',
    33: '早年作事事难成，百计徒劳枉费心，半世自如流水去，后来运到得黄金。',
    34: '此命福气果如何，僧道门中衣禄多，离祖出家方为妙，朝晚拜佛念弥陀。',
    35: '生平福量不周全，祖业根基觉少传，营事生涯宜守旧，时来衣食胜从前。',
    36: '不须劳碌过平生，独自成家福不轻，早有福星常照命，任君行去百般成。',
    37: '此命般般事不成，弟兄少力自孤行，虽然祖业须微有，来得明时去不明。',
    38: '一身骨肉最清高，早入簧门姓氏标，待到年将三十六，蓝衫脱去换红袍。',
    39: '此命终身运不通，劳劳作事尽皆空，苦心竭力成家计，到得那时在梦中。',
    40: '平生衣禄是绵长，件件心中自主张，前面风霜多受过，后来必定享安康。',
    41: '此命推来事不同，为人能干异凡庸，中年还有逍遥福，不比前年运未通。',
    42: '得宽怀处且宽怀，何用双眉皱不开，若使中年命运济，那时名利一齐来。',
    43: '为人心性最聪明，作事轩昂近贵人，衣禄一生天数定，不须劳碌过平生。',
    44: '万事由天莫苦求，须知福禄命里收，少壮名利难如意，晚景欣然更不忧。',
    45: '福中取贵格求真，明敏才华志自伸，福禄寿全家道吉，桂兰毓秀晚荣臻。',
    46: '东西南北尽皆通，出姓移名更觉隆，衣禄无亏天数定，中年晚景一般同。',
    47: '此命推来旺末年，妻荣子贵自怡然，平生原有滔滔福，可有财源如水流。',
    48: '幼年运道未曾享，苦是蹉跎再不兴，兄弟六亲皆无靠，一身事业晚年成。',
    49: '此命推来福不轻，自立自成显门庭，从来富贵人亲近，使婢差奴过一生。',
    50: '为利为名终日劳，中年福禄也多遭，老来是有财星照，不比前番目下高。',
    51: '一世荣华事事通，不须劳碌自亨通，兄弟叔侄皆如意，家业成时福禄宏。',
    52: '一世亨通事事能，不须劳思自然能，宗施欣然心皆好，家业丰亨自称心。',
    53: '此格推来气象真，兴家发达在其中，一生福禄安排定，却是人间一富翁。',
    54: '此命推来厚且清，诗书满腹看功成，丰衣足食自然稳，正是人间有福人。',
    55: '走马扬鞭争名利，少年做事废筹论，一朝福禄源源至，富贵荣华显六亲。',
    56: '此格推来礼仪通，一生福禄用无穷，甜酸苦辣皆尝过，财源滚滚稳且丰。',
    57: '福禄盈盈万事全，一生荣耀显双亲，名扬威震人钦敬，处世逍遥似遇春。',
    58: '平生福禄自然来，名利兼全福禄偕，雁塔提名为贵客，紫袍金带走金鞋。',
    59: '细推此格妙且清，必定才高礼仪通，甲第之中应有分，扬鞭走马显威荣。',
    60: '一朝金榜快题名，显祖荣宗立大功，衣食定然原欲足，田园财帛更丰盈。',
    61: '不做朝中金榜客，定为世上一财翁，聪明天赋经书熟，名显高克自是荣。',
    62: '此名生来福不穷，读书必定显亲荣，紫衣金带为卿相，富贵荣华皆可同。',
    63: '命主为官福禄长，得来富贵定非常，名题金塔传金榜，定中高科天下扬。',
    64: '此格权威不可当，紫袍金带坐高堂，荣华富贵谁能及，积玉堆金满储仓。',
    65: '细推此命福不轻，安国安邦极品人，文绣雕梁政富贵，威声照耀四方闻。',
    66: '此格人间一福人，堆金积玉满堂春，从来富贵由天定，正笏垂绅谒圣君。',
    67: '此名生来福自宏，田园家业最高隆，平生衣禄丰盈足，一世荣华万事通。',
    68: '富贵由天莫苦求，万金家计不须谋，十年不比前番事，祖业根基水上舟。',
    69: '君是人间衣禄星，一生富贵众人钦，纵然福禄由天定，安享荣华过一生。',
    70: '此命推来福不轻，不须愁虑苦劳心，一生天定衣与禄，富贵荣华过一生。',
    71: '此名生来大不同，公侯卿相在其中，一生自有逍遥福，富贵荣华极品隆。',
    72: '此格世界罕有生，十代积善产此人，天上紫微来照命，统治万民乐太平。',
  };

  /// 称骨结果
  static ChengGuResult calc({
    required String yearGanzhi,
    required int lunarMonth,
    required int lunarDay,
    required String hourZhi,
    bool leapMonth = false,
  }) {
    final year = yearWeight[yearGanzhi];
    final hourIndex = _zhiOrder.indexOf(hourZhi);
    if (year == null || hourIndex < 0) return ChengGuResult.empty();

    // 闰月上半月仍算本月，下半月算下月
    var month = lunarMonth;
    if (leapMonth && lunarDay > 15) month += 1;
    if (month > 12) month -= 12;
    if (month < 1 || month > 12) return ChengGuResult.empty();
    if (lunarDay < 1 || lunarDay > 30) return ChengGuResult.empty();

    final monthValue = monthWeight[month - 1];
    final dayValue = dayWeight[lunarDay - 1];
    final hourValue = hourWeight[hourIndex];

    return ChengGuResult(
      yearCents: year,
      monthCents: monthValue,
      dayCents: dayValue,
      hourCents: hourValue,
    );
  }

  static const List<String> _zhiOrder = [
    '子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥',
  ];
}

/// 称骨结果，各项以「钱」为单位
class ChengGuResult {
  const ChengGuResult({
    required this.yearCents,
    required this.monthCents,
    required this.dayCents,
    required this.hourCents,
  });

  const ChengGuResult.empty()
      : yearCents = 0,
        monthCents = 0,
        dayCents = 0,
        hourCents = 0;

  final int yearCents;
  final int monthCents;
  final int dayCents;
  final int hourCents;

  /// 总骨重（钱）
  int get totalCents => yearCents + monthCents + dayCents + hourCents;

  bool get isEmpty => totalCents == 0;

  /// 「三两九钱」这样的传统写法
  String get label {
    if (isEmpty) return '';
    final liang = totalCents ~/ 10;
    final qian = totalCents % 10;
    if (liang == 0) return '${_num(qian)}钱';
    return qian == 0 ? '${_num(liang)}两' : '${_num(liang)}两${_num(qian)}钱';
  }

  /// 对应的称骨歌，超出 21~72 钱范围时返回空串
  String get text => ChengGuUtil.song[totalCents] ?? '';

  /// 各项明细，如「年 一两七 · 月 六钱 · 日 五钱 · 时 一两六钱」
  String get detail =>
      '年 ${_fmt(yearCents)} · 月 ${_fmt(monthCents)} · '
      '日 ${_fmt(dayCents)} · 时 ${_fmt(hourCents)}';

  static String _fmt(int cents) {
    final liang = cents ~/ 10;
    final qian = cents % 10;
    if (liang == 0) return '${_num(qian)}钱';
    return qian == 0 ? '${_num(liang)}两' : '${_num(liang)}两${_num(qian)}钱';
  }

  static const List<String> _digits = [
    '零', '一', '二', '三', '四', '五', '六', '七', '八', '九',
  ];

  static String _num(int value) =>
      value >= 0 && value < _digits.length ? _digits[value] : '$value';
}
