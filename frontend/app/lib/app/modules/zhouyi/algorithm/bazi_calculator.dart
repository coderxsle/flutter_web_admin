import 'chn_chinese_calendar.dart';
import 'chang_sheng_util.dart';
import 'cheng_gu_util.dart';
import 'gan_zhi_relation.dart';
import 'ming_gong_util.dart';
import 'shen_sha_calculator.dart';
import 'time_utils.dart';
import 'wang_shuai_util.dart';
import 'wu_xing_util.dart';
import 'zhouyi_constants.dart';
import 'zhouyi_models.dart';
import 'zy_datetime_model.dart';

/// 四柱八字排盘核心（对应安卓 ZYBaziTool）
///
/// 与安卓一致：结果挂在 [ZYHourQimenHeadModel] 上（奇门与八字共用头部模型）。
class BaziCalculator {
  /// 十二地支对应的藏干（子→亥）
  static const List<String> _cangGanValues = [
    '癸', '己癸辛', '甲丙戊', '乙', '戊乙癸', '丙戊庚',
    '丁己', '己乙丁', '庚戊壬', '辛', '戊辛丁', '壬甲',
  ];

  /// 用于十二宫配天干的循环天干串
  static const String _unknownConst = '癸壬辛庚己戊丁丙乙甲癸壬辛庚己戊丁丙乙甲癸';

  /// 十二宫名
  static const List<String> _shiErGong = [
    '身命', '财帛', '兄弟', '田宅', '子女', '奴仆',
    '夫妻', '疾厄', '迁移', '官禄', '福德', '相貌',
  ];

  /// 起排。sex：0=女 1=男（默认男），影响大运顺逆。
  ZYHourQimenHeadModel calculate(
    ZYDatetimeModel dt, {
    int sex = BaziSex.man,
    bool yeZiShi = false,
    String mingZhuName = '',
  }) {
    final cal = ChnChineseCalendar.instance;
    final head = ZYHourQimenHeadModel();

    final year = dt.year;
    final month = dt.month;
    final day = dt.day;
    final hour = dt.hour;

    // 1. 公历时间 + 四柱干支 + 空亡
    head.setDateWithTime(year, month, day, hour, dt.minute, dt.second);
    final sizhu = cal.ganzhiJsonWithYear(year, month, day, hour,
        yeZiShi: yeZiShi);
    head.setSiZhuBaZiWithJsonDict(sizhu);
    head.siZhuName = mingZhuName;

    // 2. 农历
    head.nongli = cal.getLunarSolarCalendarWithYear(year, month, day) ?? '';

    // 3. 节气与中气
    final jieqi =
        cal.getJieqiWithYear(year, month, day, hour, dt.minute, dt.second);
    final allJqTime = jieqi.allJieqiTime;

    var jtoday = cal.dateToJuliandTimeWithYear(year, month, day, hour);
    jtoday += cal.dateToJuliandTimeWithHour(0, dt.minute, dt.second);

    var jqpos = 0;
    for (var ii = 1; ii < 25; ii++) {
      if (jtoday < allJqTime[ii]) {
        if ((ii - 1) % 2 == 0) {
          head.jieQi = ZhouyiConst.jq0Arr[ii - 1];
          head.jieQiTime = cal.jtime(false, allJqTime[ii - 1]);
          head.zhongqi = ZhouyiConst.jq0Arr[ii];
          head.zhongQiTime = cal.jtime(false, allJqTime[ii]);
        } else {
          head.jieQi = ZhouyiConst.jq0Arr[ii - 2];
          head.jieQiTime = cal.jtime(false, allJqTime[ii - 2]);
          head.zhongqi = ZhouyiConst.jq0Arr[ii - 1];
          head.zhongQiTime = cal.jtime(false, allJqTime[ii - 1]);
        }
        jqpos = ii - 1;
        break;
      }
    }

    // 4-6. 十神、纳音、藏干
    _fillPillarDerived(head);

    // 7. 十二宫（月将加时 + 年干起五虎遁配天干）
    final arrGen = <double>[];
    for (var i = 2; i < 25; i += 2) {
      arrGen.add(allJqTime[i - 1]);
    }

    var gen = 11;
    for (var i = 0; i < 12; i++) {
      if (jtoday > arrGen[11 - i]) {
        gen = 11 - i;
        break;
      }
    }

    final reversedDiZhi = ZhouyiConst.shiErDiZhi.split('').reversed.join();
    final yuejiang = reversedDiZhi.substring(gen, gen + 1);

    final yueJiangIndex = ZhouyiConst.shiErDiZhi.indexOf(yuejiang);
    final shiZhi = head.hourGanzhi.substring(1, 2);
    final shiZhiIndex = ZhouyiConst.shiErDiZhi.indexOf(shiZhi);
    var gg = yueJiangIndex - shiZhiIndex;
    if (gg < 0) gg += 12;

    final tianPan =
        '子丑寅卯辰巳午未申酉戌亥子丑寅卯辰巳午未申酉戌亥'.substring(gg, gg + 12);
    final st = tianPan.substring(3, 4);

    const wuHuDunMap = {
      '甲': '丙', '己': '丙',
      '乙': '戊', '庚': '戊',
      '丙': '庚', '辛': '庚',
      '丁': '壬', '壬': '壬',
      '戊': '甲', '癸': '甲',
    };
    final nianGan = head.yearGanzhi.substring(0, 1);
    final wuHuDun = wuHuDunMap[nianGan]!;
    final wuHuDunIndex = _unknownConst.indexOf(wuHuDun);
    final tiangan = _unknownConst.substring(wuHuDunIndex, wuHuDunIndex + 12);

    final zhiInd = reversedDiZhi.indexOf(st);
    final zhiHiz = '$reversedDiZhi亥戌酉申未午巳辰卯寅丑'
        .substring(zhiInd, zhiInd + 12);

    final shiErGongArray = List<String>.filled(12, '');
    for (var i = 0; i < shiErGongArray.length; i++) {
      shiErGongArray[i] =
          '${tiangan.substring(i, i + 1)}${zhiHiz.substring(i, i + 1)}${_shiErGong[i]}';
    }
    head.shiErGongArray = shiErGongArray;

    // 8-10. 神煞、五行胎元、干支关系与十二长生
    _fillShenShaAndWuXing(head);

    // 11. 命宫身宫、格局与旺衰喜忌
    _fillGongAndGeJu(head, nianGan);

    // 人元司令需要交节时刻，只有公历起盘算得出
    head.renYuanDays = RenYuanUtil.daysAfter(
        head.jieQiTime, DateTime(year, month, day, hour, dt.minute));
    head.renYuan = RenYuanUtil.of(_zhiOf(head.monthGanzhi), head.renYuanDays);

    // 12. 袁天罡称骨（农历月日，闰月下半月算下月）
    final lunarMd = cal.lunarMonthDayWithYear(year, month, day);
    head.chengGu = ChengGuUtil.calc(
      yearGanzhi: head.yearGanzhi,
      lunarMonth: lunarMd?.month ?? 0,
      lunarDay: lunarMd?.day ?? 0,
      hourZhi: _zhiOf(head.hourGanzhi),
      leapMonth: lunarMd?.leap == '闰',
    );

    // 13. 大运顺逆与起运
    final posneg = ' 甲乙丙丁戊己庚辛壬癸'.indexOf(nianGan) % 2;
    final shunPai = (sex == BaziSex.man && posneg == 1) ||
        (sex == BaziSex.woman && posneg == 0);

    double startTime;
    if (shunPai) {
      // 阳男、阴女：顺排，算到下一个「节」
      var jqpos2 = jqpos + (jqpos % 2 == 0 ? 2 : 1);
      if (jqpos2 > 23) {
        jqpos2 = 0;
        cal.getPureJQsinceSpring2(year, 0, 0, 0, allJqTime);
      }
      startTime = allJqTime[jqpos2] - jtoday;
    } else {
      // 阴男、阳女：逆排，算到上一个「节」
      var jqpos2 = jqpos - (jqpos % 2 == 0 ? 0 : 1);
      if (jqpos2 < 0) {
        jqpos2 = 0;
        cal.getPureJQsinceSpring2(year - 1, 0, 0, 0, allJqTime);
      }
      startTime = jtoday - allJqTime[jqpos2];
    }

    // 三天折一岁
    final st111 = cal.jtime(false, jtoday);
    var st11 = cal.jtime(false, jtoday + 365.25 * (startTime / 3.0));
    final ddd = st111.indexOf('时');
    st11 = st11.substring(0, ddd + 1);

    head.qiYunTime = TimeUtils.timeDifferenceFromTime(st111, st11);
    head.jiaoYunTime = st11;

    // 14. 大运干支（从月柱起排 12 步）
    final tinIdx = ZhouyiConst.shiTianGan.indexOf(_ganOf(head.monthGanzhi));
    final deiIdx = ZhouyiConst.shiErDiZhi.indexOf(_zhiOf(head.monthGanzhi));
    final daYun = <String>[];

    if (shunPai) {
      for (var i = 1; i <= 12; i++) {
        final t = (tinIdx + i) % 10;
        final d = (deiIdx + i) % 12;
        daYun.add('${ZhouyiConst.shiTianGan.substring(t, t + 1)}'
            '${ZhouyiConst.shiErDiZhi.substring(d, d + 1)}');
      }
    } else {
      for (var i = 1; i <= 12; i++) {
        var t = (tinIdx - i) % 10;
        if (t < 0) t += 10;
        var d = (deiIdx - i) % 12;
        if (d < 0) d += 12;
        daYun.add('${ZhouyiConst.shiTianGan.substring(t, t + 1)}'
            '${ZhouyiConst.shiErDiZhi.substring(d, d + 1)}');
      }
    }
    head.daYun = daYun;

    final daYunTime = List<String>.filled(12, '');
    for (var i = 0; i < daYunTime.length; i++) {
      daYunTime[i] = cal.jtime(false, startTime + 3652.5 * i);
    }
    head.daYunTime = daYunTime;

    // 15. 流年（120 项，结果页点开某步大运时按年份取用）
    final tinIdx0 = ZhouyiConst.shiTianGan.indexOf(_ganOf(head.yearGanzhi));
    final deiIdx0 = ZhouyiConst.shiErDiZhi.indexOf(_zhiOf(head.yearGanzhi));
    final liuNianList = <String>[];
    for (var i = 0; i < 12; i++) {
      for (var j = 0; j < 10; j++) {
        final t = (tinIdx0 + i * 10 + j) % 10;
        final d = (deiIdx0 + i * 10 + j) % 12;
        liuNianList.add('${ZhouyiConst.shiTianGan.substring(t, t + 1)}'
            '${ZhouyiConst.shiErDiZhi.substring(d, d + 1)}');
      }
    }
    head.liuNianList = liuNianList;

    return head;
  }

  /// 按四柱干支直录出盘（甲子历录入）。
  ///
  /// 除四柱本身之外的一切都依赖真实时刻 —— 节气、人元司令、称骨、大运起运、
  /// 流年、十二宫在这里一律留空，界面需要另行提示。
  ZYHourQimenHeadModel fromPillars({
    required String yearGanzhi,
    required String monthGanzhi,
    required String dayGanzhi,
    required String hourGanzhi,
    String mingZhuName = '',
  }) {
    final head = ZYHourQimenHeadModel()
      ..siZhuName = mingZhuName;

    head.setSiZhuBaZiWithJsonDict({
      'yearGanzhi': yearGanzhi,
      'monthGanzhi': monthGanzhi,
      'dayGanzhi': dayGanzhi,
      'hourGanzhi': hourGanzhi,
    });

    _fillPillarDerived(head);
    _fillShenShaAndWuXing(head);
    _fillGongAndGeJu(head, _ganOf(head.yearGanzhi));
    return head;
  }

  static String _ganOf(String ganzhi) =>
      ganzhi.isEmpty ? '' : ganzhi.substring(0, 1);

  static String _zhiOf(String ganzhi) =>
      ganzhi.length >= 2 ? ganzhi.substring(1, 2) : '';

  /// 由四柱推出十神、纳音与藏干。两条入口都用它，所以取的是 head 上已定的四柱。
  void _fillPillarDerived(ZYHourQimenHeadModel head) {
    final fcol = '${head.yearGanzhi}${head.monthGanzhi}'
        '${head.dayGanzhi}${head.hourGanzhi}';
    if (fcol.length != 8) return;

    final ganIndex = ZhouyiConst.shiTianGan.indexOf(_ganOf(head.dayGanzhi));
    if (ganIndex < 0) return;

    final String tenGod;
    if (ganIndex % 2 == 0) {
      final sub = 10 - ganIndex;
      tenGod = '比劫食傷才財殺官梟印比劫食傷才財殺官梟印'.substring(sub, sub + 10);
    } else {
      final sub = 10 - (ganIndex - 1);
      tenGod = '劫比傷食財才官殺印梟劫比傷食財才官殺印梟'.substring(sub, sub + 10);
    }

    String godOf(String gan) {
      final i = ZhouyiConst.shiTianGan.indexOf(gan);
      return i < 0 ? '' : tenGod.substring(i, i + 1);
    }

    final zhiList = <String>[
      for (var i = 1; i <= 8; i += 2) fcol.substring(i, i + 1),
    ];
    head.riGanLiuQinList = [
      for (var i = 0; i <= 6; i += 2) godOf(fcol.substring(i, i + 1)),
    ];

    final naYinMap = _liuShiHuaJiaArray();
    head.siZhuNaYin = [
      naYinMap[head.yearGanzhi] ?? '',
      naYinMap[head.monthGanzhi] ?? '',
      naYinMap[head.dayGanzhi] ?? '',
      naYinMap[head.hourGanzhi] ?? '',
    ];

    final cangGanMap = <String, String>{};
    for (var i = 0; i < ZhouyiConst.shiErDiZhi.length; i++) {
      cangGanMap[ZhouyiConst.shiErDiZhi.substring(i, i + 1)] = _cangGanValues[i];
    }

    head.cangGanArray = [for (final zhi in zhiList) cangGanMap[zhi] ?? ''];
    head.cangGanLiuQinArray = [
      for (final zhi in zhiList)
        (cangGanMap[zhi] ?? '').split('').map(godOf).join(),
    ];
  }

  /// 神煞、五行与胎元、干支关系与十二长生
  void _fillShenShaAndWuXing(ZYHourQimenHeadModel head) {
    head.shenShaArray = ShenShaCalculator.compute(
      yearGanzhi: head.yearGanzhi,
      monthGanzhi: head.monthGanzhi,
      dayGanzhi: head.dayGanzhi,
      hourGanzhi: head.hourGanzhi,
    );
    head.shenShaSummary = ShenShaCalculator.summary(head.shenShaArray);

    final siZhu = [
      head.yearGanzhi,
      head.monthGanzhi,
      head.dayGanzhi,
      head.hourGanzhi,
    ];
    head.wuXingCount = WuXingUtil.count(siZhu);
    head.taiYuan = FuShuUtil.taiYuan(head.monthGanzhi);
    head.ganZhiRelation = GanZhiRelation.compute(siZhu);
    head.changShengArray = ChangShengUtil.listOf(
      _ganOf(head.dayGanzhi),
      GanZhiRelation.zhisOf(siZhu),
    );
  }

  /// 命宫身宫、格局与旺衰喜忌
  void _fillGongAndGeJu(ZYHourQimenHeadModel head, String nianGan) {
    final rigan = _ganOf(head.dayGanzhi);
    final monthZhi = _zhiOf(head.monthGanzhi);
    final hourZhi = _zhiOf(head.hourGanzhi);

    String gong(String zhi) =>
        zhi.isEmpty ? '' : '${MingGongUtil.ganOf(nianGan, zhi)}$zhi';

    head.mingGong = gong(MingGongUtil.mingGongZhi(monthZhi, hourZhi));
    head.shenGong = gong(MingGongUtil.shenGongZhi(monthZhi, hourZhi));
    head.geJu = GeJuUtil.of(rigan, monthZhi);
    head.wangShuai = WangShuaiUtil.judge(rigan, [
      head.yearGanzhi,
      head.monthGanzhi,
      head.dayGanzhi,
      head.hourGanzhi,
    ]);
  }

  /// 六十甲子纳音映射
  Map<String, String> _liuShiHuaJiaArray() {
    const ganzhi2 = ['子丑', '寅卯', '辰巳', '午未', '申酉', '戌', '亥'];
    const nayin = [
      '海中金', '炉中火', '大林木', '路旁土', '剑锋金', '山头火', '涧下水',
      '城头土', '白腊金', '杨柳木', '井泉水', '屋上土', '霹雳火', '松柏木',
      '长流水', '沙中金', '山下火', '平地木', '壁上土', '金箔金', '覆灯火',
      '天河水', '大驿土', '钗钏金', '桑拓木', '大溪水', '沙中土', '天上火',
      '石榴木', '大海水',
    ];

    final shiGanList = <String>['甲乙', '丙丁', '戊己', '庚辛', '壬癸'];
    final map = <String, String>{};

    const subStringIdx = 1;
    var nayinIndex = 0;

    for (var count = 0; count < 5; count++) {
      for (var i = 0; i < shiGanList.length; i++) {
        final beforeString = shiGanList[i].substring(0, subStringIdx);
        final afterString = shiGanList[i].substring(subStringIdx, 2);
        final beforeShichenStr = ganzhi2[i].substring(0, subStringIdx);
        final afterShichenStr = ganzhi2[i].substring(subStringIdx, 2);

        final firstString = '$beforeString$beforeShichenStr';
        final secondString = '$afterString$afterShichenStr';

        map[firstString] = nayin[nayinIndex];
        map[secondString] = nayin[nayinIndex];
        nayinIndex += 1;
      }

      final outBeforeShigan = shiGanList[0].substring(0, subStringIdx);
      final outAfterShigan = shiGanList[0].substring(subStringIdx, 2);
      final xuStr = '$outBeforeShigan${ganzhi2[5]}';
      final haiStr = '$outAfterShigan${ganzhi2[6]}';

      map[xuStr] = nayin[nayinIndex];
      map[haiStr] = nayin[nayinIndex];
      nayinIndex += 1;

      shiGanList.add(shiGanList[0]);
      shiGanList.removeAt(0);
    }

    return map;
  }
}
