import 'chn_chinese_calendar.dart';
import 'time_utils.dart';
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

    // 4. 十神环（以日干为起点）
    final rigan = head.dayGanzhi.substring(0, 1);
    final ganIndex = ZhouyiConst.shiTianGan.indexOf(rigan);

    final String tenGod;
    if (ganIndex % 2 == 0) {
      final sub = 10 - ganIndex;
      tenGod =
          '比劫食傷才財殺官梟印比劫食傷才財殺官梟印'.substring(sub, sub + 10);
    } else {
      final sub = 10 - (ganIndex - 1);
      tenGod =
          '劫比傷食財才官殺印梟劫比傷食財才官殺印梟'.substring(sub, sub + 10);
    }

    final fcol = cal.ganzhiStringWithYear(year, month, day, hour);

    final zhiList = <String>[];
    final ganLiuQinList = <String>[];
    for (var i = 0; i <= 6; i += 2) {
      final str = fcol.substring(i, i + 1);
      final idx = ZhouyiConst.shiTianGan.indexOf(str);
      ganLiuQinList.add(tenGod.substring(idx, idx + 1));
    }
    for (var i = 1; i <= 8; i += 2) {
      zhiList.add(fcol.substring(i, i + 1));
    }
    head.riGanLiuQinList = ganLiuQinList;

    // 5. 纳音
    final naYinMap = _liuShiHuaJiaArray();
    head.siZhuNaYin = [
      naYinMap[head.yearGanzhi] ?? '',
      naYinMap[head.monthGanzhi] ?? '',
      naYinMap[head.dayGanzhi] ?? '',
      naYinMap[head.hourGanzhi] ?? '',
    ];

    // 6. 藏干与藏干六亲
    final cangGanMap = <String, String>{};
    for (var i = 0; i < ZhouyiConst.shiErDiZhi.length; i++) {
      cangGanMap[ZhouyiConst.shiErDiZhi.substring(i, i + 1)] =
          _cangGanValues[i];
    }

    final cangGanArray = List<String>.filled(zhiList.length, '');
    final cangGanLiuQinArray = List<String>.filled(zhiList.length, '');
    for (var i = 0; i < zhiList.length; i++) {
      final gan = cangGanMap[zhiList[i]] ?? '';
      var liuQin = '';
      for (var j = 0; j < gan.length; j++) {
        final cangGan = gan.substring(j, j + 1);
        final index = ZhouyiConst.shiTianGan.indexOf(cangGan);
        liuQin = liuQin + tenGod.substring(index, index + 1);
      }
      cangGanArray[i] = gan;
      cangGanLiuQinArray[i] = liuQin;
    }
    head.cangGanArray = cangGanArray;
    head.cangGanLiuQinArray = cangGanLiuQinArray;

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

    // 8. 大运顺逆与起运
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

    // 9. 大运干支（从月柱起排 12 步）
    final tinIdx = ZhouyiConst.shiTianGan.indexOf(fcol.substring(2, 3));
    final deiIdx = ZhouyiConst.shiErDiZhi.indexOf(fcol.substring(3, 4));
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

    // 10. 流年（120 项，盘面暂不展示）
    final tinIdx0 = ZhouyiConst.shiTianGan.indexOf(fcol.substring(0, 1));
    final deiIdx0 = ZhouyiConst.shiErDiZhi.indexOf(fcol.substring(1, 2));
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
