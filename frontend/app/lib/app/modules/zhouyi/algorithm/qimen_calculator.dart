import 'chn_chinese_calendar.dart';
import 'qimen_tables.dart';
import 'shi_gan_ke_ying_data.dart';
import 'zhirun_calculator.dart';
import 'zhouyi_constants.dart';
import 'zhouyi_models.dart';
import 'zy_datetime_model.dart';

/// 奇门起局方式
enum QimenMethod {
  /// 拆补法
  chaibu,

  /// 置闰法
  zhirun,
}

/// 奇门遁甲起局失败
class QimenException implements Exception {
  final String message;
  QimenException(this.message);
  @override
  String toString() => message;
}

/// 时家奇门排盘核心（对应安卓 ZYHourQimenTool）
class QimenCalculator {
  /// 起局。method 默认拆补法。
  ZYHourQimenModel calculate(
    ZYDatetimeModel dt, {
    QimenMethod method = QimenMethod.chaibu,
  }) {
    final model = ZYHourQimenModel();
    final head = model.head;

    // 1. 公历时间 + 四柱干支 + 空亡
    head.setDateWithTime(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
    final sizhu = ChnChineseCalendar.instance
        .ganzhiJsonWithYear(dt.year, dt.month, dt.day, dt.hour);
    head.setSiZhuBaZiWithJsonDict(sizhu);

    // 2. 三元、节气、农历、阴阳遁
    final ctx = _setupSanYuanJieqi(head, dt);

    // 3. 局数（拆补 / 置闰）
    if (method == QimenMethod.chaibu) {
      _juNumberChaibu(head, ctx.jieqiIndex);
    } else {
      _juNumberZhirun(head, dt);
    }

    // 4. 演局
    _yanJu(model);

    return model;
  }

  // ---------------------------------------------------------------------------
  // 第 2 步：三元 / 节气 / 农历 / 阴阳遁
  // ---------------------------------------------------------------------------

  _QiMenCtx _setupSanYuanJieqi(ZYHourQimenHeadModel head, ZYDatetimeModel dt) {
    // 三元：由日支与日干推得
    final riGan = head.dayGanzhi.substring(0, 1);
    final ganIndex = ZhouyiConst.shiTianGan.indexOf(riGan);
    final riZhi = head.dayGanzhi.substring(1, 2);
    final zhiIndex = ZhouyiConst.shiErDiZhi.indexOf(riZhi);

    var idx2 = zhiIndex - ganIndex % 5;
    if (idx2 < 0) idx2 += 12;
    idx2 = idx2 % 3;
    if (idx2 > 0) {
      idx2 = (idx2 == 1) ? 2 : 1;
    }
    head.sanYuan = '上中下'.substring(idx2, idx2 + 1);

    final cal = ChnChineseCalendar.instance;
    final jieqi = cal.getJieqiWithYear(
        dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
    final jieqiIndex = jieqi.currentJieqiIndex;
    final allJqTime = jieqi.allJieqiTime;

    var today = cal.dateToJuliandTimeWithYear(dt.year, dt.month, dt.day, 0);
    today += cal.dateToJuliandTimeWithHour(dt.hour, dt.minute, dt.second);

    head.jieQi = jieqi.currentJieqi;
    head.jieQiTime = jieqi.currentJieqiTime;
    head.nongli = cal.getLunarSolarCalendarWithYear(dt.year, dt.month, dt.day) ?? '';

    // 夏至(索引9)到冬至(索引21)之间为阴遁
    if (today > allJqTime[9] && today < allJqTime[21]) {
      head.dunType = YinYangType.yin;
    } else {
      head.dunType = YinYangType.yang;
    }

    return _QiMenCtx(jieqiIndex: jieqiIndex);
  }

  // ---------------------------------------------------------------------------
  // 第 3 步：局数
  // ---------------------------------------------------------------------------

  /// 拆补法：基础局数按三元每进一元 ±6
  void _juNumberChaibu(ZYHourQimenHeadModel head, int jieqiIndex) {
    var juNumber = ZhouyiConst.juNumbers[jieqiIndex];
    final idx2 = '上中下'.indexOf(head.sanYuan);

    if (head.dunType == YinYangType.yin) {
      for (var i = 0; i < idx2; i++) {
        juNumber -= 6;
        while (juNumber < 1) {
          juNumber += 9;
        }
      }
    } else if (head.dunType == YinYangType.yang) {
      for (var i = 0; i < idx2; i++) {
        juNumber += 6;
        while (juNumber > 9) {
          juNumber -= 9;
        }
      }
    }
    head.jushu = juNumber;
  }

  /// 置闰法：超神接气本地计算
  void _juNumberZhirun(ZYHourQimenHeadModel head, ZYDatetimeModel dt) {
    try {
      final result = ZhirunCalculator.calculate(
        dt.year,
        dt.month,
        dt.day,
        dt.hour,
        dt.minute,
        dt.second,
      );
      head.dunType = result.dunType;
      head.jushu = result.juNumber;
      head.jieQi = result.jieqi;
    } catch (e) {
      throw QimenException('置闰法起局失败：$e');
    }
  }

  // ---------------------------------------------------------------------------
  // 第 4 步：演局
  // ---------------------------------------------------------------------------

  void _yanJu(ZYHourQimenModel model) {
    final head = model.head;
    final juNumber = head.jushu;
    final isYang = head.dunType == YinYangType.yang;

    // 1) 地盘三奇六仪：局数宫起戊，阳遁顺行、阴遁逆行
    model.diPanQiyi = QimenTables.ring(
      isYang ? QimenTables.qiYiYang : QimenTables.qiYiYin,
      9 - juNumber + 1,
      9,
    );

    // 2) 时旬首
    final shizhi = head.hourGanzhi.substring(1, 2);
    final shigan = head.hourGanzhi.substring(0, 1);
    final shiGanIdx = ZhouyiConst.shiTianGan.indexOf(shigan);
    var chunSau = ZhouyiConst.shiErDiZhi.indexOf(shizhi) - shiGanIdx;
    if (chunSau < 0) chunSau += 12;
    final xunIdx = chunSau ~/ 2;
    final xunshou = QimenTables.xunShouZhi[xunIdx];
    final xunshouGan = QimenTables.xunShouGan[xunIdx];
    head.hourXunShou = '甲$xunshou$xunshouGan';
    // 六甲旬序 0..5（子戌申午辰寅），值符值使都按它推宫
    final xunOrder = QimenTables.xunShouZhiOrder.indexOf(xunshou);

    // 3) 值符
    final qiYiIdx =
        QimenTables.qiYiYang.indexOf(shigan == '甲' ? xunshouGan : shigan);
    final jikFuIdx = _wrapGong(
      isYang ? juNumber + xunOrder : juNumber - xunOrder,
    );
    final jikFuStar = _wrapGong(
      isYang ? qiYiIdx + juNumber : juNumber - qiYiIdx,
    );

    final zhiFuStarChar = QimenTables.at(QimenTables.jiuXing, jikFuIdx);
    head.zhiFu = '天$zhiFuStarChar落$jikFuStar宫';
    // 禽星寄二宫
    final zhiFuStarGong = jikFuStar == 5 ? 2 : jikFuStar;

    // 4) 值使：值符宫随时干推移
    final jikFuMunGong = _wrapGong(
      isYang ? jikFuIdx + shiGanIdx : jikFuIdx - shiGanIdx,
    );
    final zhiShiMenChar = QimenTables.at(QimenTables.baMen, jikFuIdx);
    head.zhiShi = '${zhiShiMenChar.isEmpty ? '死' : zhiShiMenChar}門落$jikFuMunGong宫';
    // 值使落 5 宫寄 2 宫
    final jikFuMun = jikFuMunGong == 5 ? 2 : jikFuMunGong;

    // 5) 九星盘
    final starPan = _buildPan(QimenTables.luoshuPos(zhiFuStarGong), jikFuIdx);
    final housesStar = <String>[
      for (final gong in starPan)
        '天${QimenTables.at(QimenTables.jiuXing, gong)}',
    ];
    // 五宫禽星寄二宫
    var erGongIndex = 0;
    for (var i = 0; i < 9; i++) {
      if (housesStar[i] == '天芮') {
        erGongIndex = i;
        housesStar[i] = '禽芮';
      } else if (housesStar[i] == '天禽') {
        housesStar[i] = '';
      }
    }
    model.jiuXing = housesStar;

    // 6) 天盘三奇六仪
    final tianPan = <String>[];
    for (var i = 0; i < 9; i++) {
      final t = _wrapGong(
        isYang ? starPan[i] - juNumber + 1 : juNumber - starPan[i] + 1,
      );
      tianPan.add(QimenTables.at(QimenTables.qiYiYang, t));
    }
    // 五宫寄二宫：中五宫天盘干并入二宫
    final wuGan = tianPan[4];
    tianPan[4] = '';
    tianPan[erGongIndex] = '$wuGan${tianPan[erGongIndex]}';
    model.tianPanQiyi = tianPan;

    // 7) 人盘八门
    final doorPan = _buildPan(QimenTables.luoshuPos(jikFuMun), jikFuIdx);
    final houseDoor = <String>[
      for (final gong in doorPan) '${QimenTables.at(QimenTables.baMen, gong)}门',
    ];
    houseDoor[4] = '';
    model.baMen = houseDoor;

    // 8) 神盘八神
    final godTarget = QimenTables.luoshuPos(zhiFuStarGong);
    final housesGod = List<String>.of(
      isYang ? QimenTables.baShenYang : QimenTables.baShenYin,
    );
    while (housesGod[godTarget] != '值符') {
      housesGod.insert(0, housesGod.removeLast());
    }
    model.baShen = <String>[
      for (var i = 1; i < 10; i++)
        i == 5 ? '　' : housesGod[QimenTables.luoshuPos(i)],
    ];

    // 9) 马星：时支定三合局，局定马星之支
    final maxing = List<int>.filled(9, 0);
    final hourZhi = head.hourGanzhi.substring(1, 2);
    final maIdx = QimenTables.maXingZhi.indexOf(hourZhi);
    if (maIdx < 0) throw QimenException('时支 $hourZhi 不在马星表中');
    final maZhi = QimenTables.maXingYing[maIdx ~/ 3];
    maxing[QimenTables.gongIndexOf(QimenTables.diZhiGong[maZhi]!)] = 1;
    model.maXing = maxing;

    // 10) 地盘值符落宫（时旬首之干在地盘的位置）
    var diZhiFuIndex = model.diPanQiyi.indexOf(xunshouGan);
    if (diZhiFuIndex == 4) diZhiFuIndex = 1; // 5 宫寄 2 宫
    model.diPanZhiFuIndex = diZhiFuIndex;

    // 11) 暗干（地盘值符宫起甲）
    final anGan =
        _buildAnGan(head.dunType == YinYangType.yin, diZhiFuIndex);
    model.anGan = _splitPairedString(
        anGan, diZhiFuIndex, head.dunType == YinYangType.yin);

    // 12) 飞支
    final feiZhiStr = _buildFeiZhi(
        isYang: isYang, xunshou: xunshou, diZhiFuIndex: diZhiFuIndex);
    model.feiZhi = _splitPairedString(
        feiZhiStr, diZhiFuIndex, head.dunType == YinYangType.yin);

    // 13) 地盘八神
    final diGodTarget = QimenTables.luoshuPos(diZhiFuIndex + 1);
    final diHousesGod = List<String>.of(
      isYang ? QimenTables.diBaShenYang : QimenTables.diBaShenYin,
    );
    while (diHousesGod[diGodTarget] != '符') {
      diHousesGod.insert(0, diHousesGod.removeLast());
    }
    model.diBaShen = <String>[
      for (var i = 1; i < 10; i++)
        i == 5 ? '　' : diHousesGod[QimenTables.luoshuPos(i)],
    ];

    // 14) 十干克应
    model.shiGanKeYing1 = List<String>.filled(9, '');
    model.shiGanKeYing2 = List<String>.filled(9, '');
    for (var i = 0; i < model.diPanQiyi.length; i++) {
      var tianPanGan = tianPan[i];
      if (tianPanGan.length == 2) tianPanGan = tianPanGan.substring(1);
      if (tianPanGan.isEmpty) continue;
      final diPanGan = model.diPanQiyi[i];
      model.shiGanKeYing1[i] = ShiGanKeYingData.find(tianPanGan, diPanGan);

      var anGanStr = model.anGan[i];
      if (anGanStr.length == 2) anGanStr = anGanStr.replaceAll('甲', '');
      if (anGanStr.isEmpty) continue;
      model.shiGanKeYing2[i] = ShiGanKeYingData.find(anGanStr, diPanGan);
    }
  }

  /// 把宫号规整到 1..9
  static int _wrapGong(int gong) {
    var v = gong;
    while (v > 9) {
      v -= 9;
    }
    while (v < 1) {
      v += 9;
    }
    return v;
  }

  /// 按洛书轨迹落宫：把 [QimenTables.luoshu] 旋转到 [targetPos] 处对齐 [jikFuIdx]
  List<int> _buildPan(int targetPos, int jikFuIdx) {
    final idx = List<int>.of(QimenTables.luoshu);
    final align = jikFuIdx == 5 ? 2 : jikFuIdx;
    if (!idx.contains(align)) {
      throw QimenException('值符宫 $align 不在洛书轨迹上');
    }
    while (idx[targetPos] != align) {
      idx.insert(0, idx.removeLast());
    }
    return <int>[
      for (var gong = 1; gong < 10; gong++)
        gong == 5 ? 5 : idx[QimenTables.luoshuPos(gong)],
    ];
  }

  /// 暗干串：从地盘值符宫起甲
  String _buildAnGan(bool isYin, int diZhiFuIndex) {
    final base = isYin ? QimenTables.anGanYin : QimenTables.anGanYang;
    return QimenTables.cycle(base, 9 - diZhiFuIndex, 10);
  }

  /// 飞支串：按旬首选取地支序列
  String _buildFeiZhi({
    required bool isYang,
    required String xunshou,
    required int diZhiFuIndex,
  }) {
    final base =
        (isYang ? QimenTables.feiZhiYang : QimenTables.feiZhiYin)[xunshou];
    if (base == null) {
      throw QimenException('飞支序列缺失：旬首 $xunshou');
    }
    return QimenTables.cycle(base, 9 - diZhiFuIndex - 1, 10);
  }

  /// 把长度 10 的串拆成 9 项：值符宫合并两字，阴遁时调换两字顺序
  List<String> _splitPairedString(
    String source,
    int diZhiFuIndex,
    bool isYin,
  ) {
    if (source.length != 10 || diZhiFuIndex < 0 || diZhiFuIndex > 8) {
      throw QimenException(
          '暗干/飞支串长 ${source.length} 与值符宫 ${diZhiFuIndex + 1} 不匹配');
    }
    final result = <String>[];
    for (var i = 0; i < source.length; i++) {
      if (i == diZhiFuIndex) {
        var str = source.substring(i, i + 2);
        if (isYin) {
          str = '${str.substring(1)}${str.substring(0, 1)}';
        }
        result.add(str);
      } else if (i == diZhiFuIndex + 1) {
        continue;
      } else {
        result.add(source.substring(i, i + 1));
      }
    }
    return result;
  }
}

class _QiMenCtx {
  final int jieqiIndex;
  _QiMenCtx({required this.jieqiIndex});
}
