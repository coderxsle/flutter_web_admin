/// 奇门排盘的全部查表。用 List / Map 取代「字符串 + 字符下标」：
/// 后者靠前导空格占位、靠重复拼接续排，一旦被 trim 或格式化就静默错位。
library;

/// 宫序表宫号一律 1..9，取值用 [at]；0 基索引用 [gongIndexOf]。
class QimenTables {
  QimenTables._();

  /// 洛书飞布轨迹，按宫号
  static const List<int> luoshu = [1, 8, 3, 4, 9, 2, 7, 6];

  /// 九星，1..9 宫
  static const List<String> jiuXing = [
    '蓬', '芮', '冲', '辅', '禽', '心', '柱', '任', '英',
  ];

  /// 八门，1..9 宫；5 宫无门，留空
  static const List<String> baMen = [
    '休', '死', '伤', '杜', '', '开', '惊', '生', '景',
  ];

  /// 地盘三奇六仪基串（宫 1..9）：阳遁顺行、阴遁逆行（戊不动，其余逆排）
  static const List<String> qiYiYang = [
    '戊', '己', '庚', '辛', '壬', '癸', '丁', '丙', '乙',
  ];
  static const List<String> qiYiYin = [
    '戊', '乙', '丙', '丁', '癸', '壬', '辛', '庚', '己',
  ];

  /// 六甲旬首地支（序 0..5）
  static const List<String> xunShouZhi = ['子', '寅', '辰', '午', '申', '戌'];

  /// 六甲旬首所遁之干（序 0..5）
  static const List<String> xunShouGan = ['戊', '癸', '壬', '辛', '庚', '己'];

  /// 旬首序 1..6 → 地支，用于推 chunSau
  static const List<String> xunShouZhiOrder = ['子', '戌', '申', '午', '辰', '寅'];

  /// 三元
  static const List<String> sanYuan = ['上', '中', '下'];

  /// 马星：时支序 0..11，每连续 3 个为一组（三合局）
  static const List<String> maXingZhi = [
    '申', '子', '辰', '寅', '午', '戌', '亥', '卯', '未', '巳', '酉', '丑',
  ];

  /// 与 [maXingZhi] 每组对应的马星之支：申子辰马在寅、寅午戌马在申、
  /// 亥卯未马在巳、巳酉丑马在亥
  static const List<String> maXingYing = ['寅', '申', '巳', '亥'];

  /// 八神，阳遁顺布 / 阴遁逆布
  static const List<String> baShenYang = [
    '值符', '腾蛇', '太阴', '六合', '白虎', '玄武', '九地', '九天',
  ];

  static const List<String> baShenYin = [
    '值符', '九天', '九地', '玄武', '白虎', '六合', '太阴', '腾蛇',
  ];

  /// 地盘八神简称，阳遁 / 阴遁
  static const List<String> diBaShenYang = ['符', '蛇', '阴', '合', '白', '玄', '地', '天'];
  static const List<String> diBaShenYin = ['符', '天', '地', '玄', '白', '合', '阴', '蛇'];

  /// 地支落宫（1..9）：子坎1、丑寅艮8、卯震3、辰巳巽4、午离9、未申坤2、酉兑7、戌亥乾6
  static const Map<String, int> diZhiGong = {
    '子': 1, '丑': 8, '寅': 8, '卯': 3, '辰': 4, '巳': 4,
    '午': 9, '未': 2, '申': 2, '酉': 7, '戌': 6, '亥': 6,
  };

  /// 旬空：旬首 → 空亡地支。每旬固定空两支，列出地支即可，落宫由 [diZhiGong] 推
  static const Map<String, List<String>> xunKongZhi = {
    '甲子戊': ['戌', '亥'],
    '甲戌己': ['申', '酉'],
    '甲申庚': ['午', '未'],
    '甲午辛': ['辰', '巳'],
    '甲辰壬': ['寅', '卯'],
    '甲寅癸': ['子', '丑'],
  };

  /// 暗干基串（10 天干），阳遁顺行、阴遁逆行
  static const String anGanYang = '甲乙丙丁戊己庚辛壬癸';
  static const String anGanYin = '癸壬辛庚己戊丁丙乙甲';

  /// 飞支基串（10 支），按旬首 + 阴阳遁
  static const Map<String, String> feiZhiYang = {
    '子': '丑寅卯辰巳午未申酉子',
    '戌': '亥子丑寅卯辰巳午未戌',
    '申': '酉戌亥子丑寅卯辰巳申',
    '午': '未申酉戌亥子丑寅卯午',
    '辰': '巳午未申酉戌亥子丑辰',
    '寅': '卯辰巳午未申酉戌亥寅',
  };

  static const Map<String, String> feiZhiYin = {
    '子': '申未午巳辰卯寅丑子酉',
    '戌': '午巳辰卯寅丑子亥戌未',
    '申': '辰卯寅丑子亥戌酉申巳',
    '午': '寅丑子亥戌酉申未午卯',
    '辰': '子亥戌酉申未午巳辰丑',
    '寅': '戌酉申未午巳辰卯寅亥',
  };

  /// 按 1..9 宫取表值；越界返回空串，不再靠下标对齐
  static String at(List<String> table, int gong) =>
      (gong >= 1 && gong <= table.length) ? table[gong - 1] : '';

  /// 宫号 1..9 → 0 基索引
  static int gongIndexOf(int gong) => gong - 1;

  /// 宫号 → 洛书轨迹下标；5 宫不在轨迹上，传 5 是调用方的编码错误
  static int luoshuPos(int gong) {
    final pos = luoshu.indexOf(gong);
    if (pos < 0) {
      throw ArgumentError.value(gong, 'gong', '该宫不在洛书轨迹 $luoshu 上');
    }
    return pos;
  }

  /// 旬空宫（0 基索引），由 [xunKongZhi] + [diZhiGong] 推得
  static Set<int> xunKongIndexOf(String xunShou) {
    final zhis = xunKongZhi[xunShou];
    if (zhis == null) return const <int>{};
    return zhis.map((z) => gongIndexOf(diZhiGong[z]!)).toSet();
  }

  /// 把 [base] 当首尾相接的环，从 [start] 取 [len] 项；[start] 可越界，按模归位
  static List<String> ring(List<String> base, int start, int len) =>
      List.generate(len, (k) => base[(start + k) % base.length]);

  /// [ring] 的字符串版
  static String cycle(String base, int start, int len) =>
      ring(base.split(''), start, len).join();

  /// 表结构自检，返回问题列表；空列表表示通过。
  ///
  /// 断言各表长度、洛书轨迹覆盖、旬空与旬首一一对应。单测与
  /// `dart run` 直跑都用这一份，避免两处断言漂移。
  static List<String> selfCheck() {
    final errs = <String>[];

    void expectLen(String name, int actual, int want) {
      if (actual != want) errs.add('$name 长度 $actual，应为 $want');
    }

    expectLen('jiuXing', jiuXing.length, 9);
    expectLen('baMen', baMen.length, 9);
    expectLen('qiYiYang', qiYiYang.length, 9);
    expectLen('qiYiYin', qiYiYin.length, 9);
    expectLen('luoshu', luoshu.length, 8);
    expectLen('maXingZhi', maXingZhi.length, 12);
    expectLen('maXingYing', maXingYing.length, 4);
    expectLen('xunShouZhi', xunShouZhi.length, 6);
    expectLen('xunShouGan', xunShouGan.length, 6);
    expectLen('xunShouZhiOrder', xunShouZhiOrder.length, 6);
    expectLen('baShenYang', baShenYang.length, 8);
    expectLen('baShenYin', baShenYin.length, 8);
    expectLen('diBaShenYang', diBaShenYang.length, 8);
    expectLen('diBaShenYin', diBaShenYin.length, 8);

    // 旬首三表必须同序一一对应，否则 chunSau / 旬首干会错位
    if (xunShouZhi.toSet().length != xunShouZhi.length ||
        xunShouZhiOrder.toSet().length != xunShouZhiOrder.length) {
      errs.add('旬首地支表有重复项');
    }
    if (!xunShouZhiOrder.every(xunShouZhi.contains)) {
      errs.add('xunShouZhiOrder 与 xunShouZhi 不是同一组地支');
    }

    // 阴遁地盘基串 = 戊不动、其余八干由阳遁基串逆排
    final wantYin = [qiYiYang.first, ...qiYiYang.skip(1).toList().reversed];
    if (qiYiYin.join() != wantYin.join()) {
      errs.add('qiYiYin 应为「${wantYin.join()}」，实为「${qiYiYin.join()}」');
    }

    // 洛书恰好覆盖 1..9 除 5 外的八宫
    if (luoshu.toSet().length != 8 || luoshu.contains(5)) {
      errs.add('luoshu 应恰好含 1..9 除 5 外的八个宫，实为 $luoshu');
    }
    if (luoshu.toSet().difference({1, 2, 3, 4, 6, 7, 8, 9}).isNotEmpty) {
      errs.add('luoshu 混入了 1..9 以外的宫号：$luoshu');
    }
    for (final g in [1, 2, 3, 4, 6, 7, 8, 9]) {
      if (luoshuPos(g) < 0 || luoshuPos(g) > 7) errs.add('宫 $g 的洛书下标越界');
    }

    // 马星：第 g 组的马星之支不能自己也属于第 g 组，且必须能落 1..9 宫
    for (var g = 0; g < maXingYing.length; g++) {
      final zhi = maXingYing[g];
      final idx = maXingZhi.indexOf(zhi);
      if (idx < 0) {
        errs.add('马星之支 $zhi 不在 maXingZhi 中');
      } else if (idx ~/ 3 == g) {
        errs.add('第 $g 组的马星之支写成了 $zhi，它与本组同局');
      }
      if (diZhiGong[zhi] == null) errs.add('马星之支 $zhi 无落宫');
    }

    // 旬空与旬首一一对应
    for (final zhi in xunShouZhi) {
      final hit = xunKongZhi.keys.where((k) => k.startsWith('甲$zhi'));
      if (hit.isEmpty) errs.add('旬首 $zhi 缺少旬空定义');
    }
    if (xunKongZhi.length != xunShouZhi.length) {
      errs.add('xunKongZhi 有 ${xunKongZhi.length} 项，应为 ${xunShouZhi.length}');
    }

    // 旬空地支必须都能落到 1..9 宫，且每旬去重后至少 1 宫
    for (final entry in xunKongZhi.entries) {
      for (final z in entry.value) {
        final g = diZhiGong[z];
        if (g == null || g < 1 || g > 9) errs.add('${entry.key} 的地支 $z 无落宫');
      }
      if (xunKongIndexOf(entry.key).isEmpty) {
        errs.add('${entry.key} 推不出旬空宫');
      }
    }

    // 飞支基串必须是 10 位且与旬首表键一致
    for (final table in [feiZhiYang, feiZhiYin]) {
      for (final entry in table.entries) {
        if (entry.value.length != 10) {
          errs.add('飞支 ${entry.key} 长 ${entry.value.length}，应为 10');
        }
      }
      for (final zhi in xunShouZhi) {
        if (!table.containsKey(zhi)) errs.add('飞支表缺少旬首 $zhi');
      }
    }

    expectLen('anGanYang', anGanYang.length, 10);
    expectLen('anGanYin', anGanYin.length, 10);

    return errs;
  }
}
