import 'dart:math' as math;

import 'zhouyi_constants.dart';

/// 节气查询结果（对应安卓 getJieqiWithYear 返回的字典）
class JieqiResult {
  /// 当前节气名，如「立春」
  final String currentJieqi;

  /// 当前节气在 [ZhouyiConst.jq0Arr] 中的索引（0=立春）
  final int currentJieqiIndex;

  /// 当前节气开始时间，格式 yyyy年MM月dd日HH时mm分ss秒
  final String currentJieqiTime;

  /// 该年度从立春开始的 25 个节气儒略日（下标 0..24）
  final List<double> allJieqiTime;

  JieqiResult({
    required this.currentJieqi,
    required this.currentJieqiIndex,
    required this.currentJieqiTime,
    required this.allJieqiTime,
  });
}

/// 万年历核心：儒略日、24 节气（VSOP 摄动修正）、四柱干支、空亡、农历。
///
/// 逐行对应安卓 com.bubble.zhouyi.calendar.CHNChineseCalendar，
/// 保留原实现的取整与截断口径，避免结果与安卓端产生差异。
class ChnChineseCalendar {
  ChnChineseCalendar._();

  static final ChnChineseCalendar instance = ChnChineseCalendar._();

  static const double _synmonth = 29.530588853;

  /// Java 的 (int) 转型为向零截断
  static int _toInt(double v) => v.truncate();

  /// Java Tools.fmod：向零取模（Dart 的 % 为欧几里得取模）
  static double _fmod(double x, double y) => x.remainder(y);

  final List<double> _jdezArr = List<double>.filled(50, 0);

  // ---------------------------------------------------------------------------
  // 干支
  // ---------------------------------------------------------------------------

  /// 四柱干支字符串，如「丁酉甲辰壬戌丙午」
  String ganzhiStringWithYear(int year, int month, int day, int hour) =>
      _ganzhiParts(year, month, day, hour, 0, 0, 0).sublist(0, 8).join();

  /// 四柱干支字典，key 为 yearGanzhi / monthGanzhi / dayGanzhi / hourGanzhi
  ///
  /// [yeZiShi] 为 true 且 hour == 23 时，日柱回退取 hour-1 的日柱（夜子时归前一日）。
  Map<String, String> ganzhiJsonWithYear(
    int year,
    int month,
    int day,
    int hour, {
    bool yeZiShi = false,
  }) {
    final parts = _ganzhiParts(year, month, day, hour, 0, 0, 0);
    final bazi = parts.sublist(0, 8);

    if (hour == 23 && yeZiShi) {
      final yeziBazi = _ganzhiParts(year, month, day, hour - 1, 0, 0, 0);
      bazi[4] = yeziBazi[4];
      bazi[5] = yeziBazi[5];
    }

    return {
      'yearGanzhi': bazi[0] + bazi[1],
      'monthGanzhi': bazi[2] + bazi[3],
      'dayGanzhi': bazi[4] + bazi[5],
      'hourGanzhi': bazi[6] + bazi[7],
    };
  }

  /// 返回 20 个单字（年干年支月干月支日干日支时干时支 分干分支 秒干秒支 毫秒 混元 无极 究竟）
  List<String> _ganzhiParts(
    int y,
    int m,
    int d,
    int h,
    int i,
    int s,
    int ms,
  ) {
    final tin =
        '甲乙丙丁戊己庚辛壬癸甲乙丙丁戊己庚辛壬癸甲乙';
    const di = '子丑寅卯辰巳午未申酉戌亥';

    double jtoday = dateToJuliandTimeWithYear(y, m, d, 0);
    jtoday += dateToJuliandTimeWithHour(h, i, s);

    final jqTime = List<double>.filled(50, 0);
    getPureJQsinceSpring2(y, 0, 0, 0, jqTime);
    if (jtoday < jqTime[0]) {
      y = y - 1;
      getPureJQsinceSpring2(y, 0, 0, 0, jqTime);
    }

    final rtn = <String>[];

    // ******** 年柱 ********
    final ygz = ((y + 4712 + 24) % 60 + 60) % 60;
    final niangan = ygz % 10;
    rtn.add(tin.substring(niangan, niangan + 1));
    final nianzhi = ygz % 12;
    rtn.add(di.substring(nianzhi, nianzhi + 1));

    // ******** 月柱 ********
    var dgz = -1;
    for (var ii = 24; ii > 0; ii--) {
      if (jtoday > jqTime[ii - 1]) {
        dgz = ii;
        break;
      }
    }
    if (dgz < 0) dgz = 1;
    if (dgz % 2 == 0) dgz--;
    dgz = dgz ~/ 2;
    if (dgz == 12) dgz = 11;

    final yuegan = (((ygz % 10) % 5) * 2 + 2);
    final monthTin = tin.substring(yuegan, yuegan + 12);
    rtn.add(monthTin.substring(dgz, dgz + 1));
    rtn.add('寅卯辰巳午未申酉戌亥子丑'.substring(dgz, dgz + 1));

    // ******** 日柱 ********
    final jda = jtoday + 0.5;
    final thes = ((jda - jda.floorToDouble()) * 86400) + 3600;
    final dayjd = jda.floorToDouble() + thes / 86400;
    dgz = ((dayjd + 49).floor() % 60 + 60) % 60;

    final rigan = dgz % 10;
    rtn.add(tin.substring(rigan, rigan + 1));
    final rizhi = dgz % 12;
    rtn.add(di.substring(rizhi, rizhi + 1));

    // ******** 时柱 ********
    final dh = dayjd * 12;
    final value0 = (dh + 48).floorToDouble();
    final value1 = _fmod(value0, 60);
    final value2 = value1 + 60;
    var hgz = _fmod(value2, 60);
    if (_fmod((h / 2.0).ceilToDouble(), 12) != _fmod(hgz, 12)) {
      hgz++;
    }
    final shigan = _toInt(_fmod(hgz, 10));
    rtn.add(tin.substring(shigan, shigan + 1));
    final shizhi = _toInt(_fmod(hgz, 12));
    rtn.add(di.substring(shizhi, shizhi + 1));

    // ******** 分柱 ********
    var minhz = i;
    if (h % 2 == 0) minhz += 60;
    minhz = (minhz * 60) ~/ 600;

    const ganIdx = [0, 2, 4, 6, 8, 0, 2, 4, 6, 8];
    final ganString = rtn[6];
    final ganLoc = tin.indexOf(ganString);
    final raLoc = ganIdx[ganLoc];
    rtn.add(tin
        .substring(raLoc, raLoc + 12)
        .substring(minhz, minhz + 1));
    final fenzhi = minhz % 12;
    rtn.add(di.substring(fenzhi, fenzhi + 1));

    // ******** 秒柱 ********
    var second = i;
    if (h % 2 == 0) second += 60;
    second = ((second * 60) % 600 + s) ~/ 50;
    final secondString = rtn[8];
    final secondLoc = tin.indexOf(secondString);
    final secondGanLoc = ganIdx[secondLoc];
    rtn.add(tin
        .substring(secondGanLoc, secondGanLoc + 12)
        .substring(second, second + 1));
    final mianzhi = second % 12;
    rtn.add(di.substring(mianzhi, mianzhi + 1));

    // ******** 毫秒 / 混元 / 无极 / 究竟 柱 ********
    var msec = i;
    if (h % 2 == 0) msec += 60;
    msec = _toInt(msec * 60.0 + s);
    msec = _toInt(msec * 1000.0 + ms);

    final msec3 = ((msec % 50000) / (50000 / 12.0)).floor();
    final msec4 = (_fmod(msec.toDouble(), 50000.0 / 12.0) /
            (50000 / 12.0 / 12.0))
        .floor();
    final msec5 = (_fmod(msec.toDouble(), 50000.0 / 12.0 / 12.0) /
            (50000 / 12.0 / 12.0 / 12.0))
        .floor();
    final msec6 = (_fmod(msec.toDouble(), 50000.0 / 12.0 / 12.0 / 12.0) /
            (50000 / 12.0 / 12.0 / 12.0 / 12.0))
        .floor();

    // 毫秒柱
    _appendDerivedCol(rtn, tin, di, rtn[10], ganIdx, msec3);
    // 混元柱
    _appendDerivedCol(rtn, tin, di, rtn[12], ganIdx, msec4);
    // 无极柱
    _appendDerivedCol(rtn, tin, di, rtn[14], ganIdx, msec5);
    // 究竟柱
    _appendDerivedCol(rtn, tin, di, rtn[16], ganIdx, msec6);

    return rtn;
  }

  void _appendDerivedCol(
    List<String> rtn,
    String tin,
    String di,
    String ganStr,
    List<int> ganIdx,
    int offset,
  ) {
    final index = tin.indexOf(ganStr);
    if (index >= 0) {
      final loc = ganIdx[index];
      rtn.add(tin.substring(loc, loc + 12).substring(offset, offset + 1));
      rtn.add(di.substring(offset % 12, offset % 12 + 1));
    } else {
      rtn.add('甲');
      rtn.add('子');
    }
  }

  /// 返回干支串对应的空亡，每柱两字
  String kongwangWithGanzhi(String ganzhi) {
    final result = <String>[];
    for (var i = 0; i < ganzhi.length; i += 2) {
      final zhiString = ganzhi.substring(i + 1, i + 2);
      final zhi = '子丑寅卯辰巳午未申酉戌亥'.indexOf(zhiString);
      final ganString = ganzhi.substring(i, i + 1);
      final gan = '甲乙丙丁戊己庚辛壬癸'.indexOf(ganString);

      var chunSau = zhi - gan;
      if (chunSau < 0) chunSau += 12;
      var hungMon = chunSau - 2;
      if (hungMon < 0) hungMon += 12;
      result.add('子丑寅卯辰巳午未申酉戌亥'.substring(hungMon, hungMon + 2));
    }
    return result.join();
  }

  // ---------------------------------------------------------------------------
  // 节气
  // ---------------------------------------------------------------------------

  /// 返回当前节气（对应安卓 getJieqiWithYear）
  JieqiResult getJieqiWithYear(int y, int m, int d, int h, int i, int s) {
    var jtoday = dateToJuliandTimeWithYear(y, m, d, 0);
    jtoday += dateToJuliandTimeWithHour(h, i, s);

    final jqTime = List<double>.filled(50, 0);
    getPureJQsinceSpring2(y, 0, 0, 0, jqTime);
    if (jtoday < jqTime[0]) {
      getPureJQsinceSpring2(y - 1, 0, 0, 0, jqTime);
    }

    var index = 0;
    for (var ii = 1; ii < 25; ii++) {
      if (jtoday < jqTime[ii]) {
        index = ii - 1;
        return JieqiResult(
          currentJieqi: ZhouyiConst.jq0Arr[index],
          currentJieqiIndex: index,
          currentJieqiTime: jtime(false, jqTime[ii - 1]),
          allJieqiTime: jqTime,
        );
      }
    }
    return JieqiResult(
      currentJieqi: ZhouyiConst.jq0Arr[index],
      currentJieqiIndex: index,
      currentJieqiTime: jtime(false, jqTime[index]),
      allJieqiTime: jqTime,
    );
  }

  // ---------------------------------------------------------------------------
  // 儒略日 <-> 公历
  // ---------------------------------------------------------------------------

  /// 格里历转儒略日（含日的小数部分）
  double dateToJuliandTimeWithYear(int year, int month, int day, int hour) {
    const op = false;
    var jdy = 0;
    var init = 0.0;
    final yp = (year + ((month - 3) / 10.0).floor()).toInt();

    if (year < -400000 || year > 400000) return 0;

    if ((year > 1582) ||
        (year == 1582 && month > 10) ||
        (year == 1582 && month == 10 && day >= 15) ||
        op) {
      init = 1721119.5;
      jdy = ((yp * 365.25).floor() - (yp ~/ 100) + (yp ~/ 400));
    } else {
      if ((year < 1582) ||
          (year == 1582 && month < 10) ||
          (year == 1582 && month == 10 && day <= 4)) {
        init = 1721117.5;
        jdy = (yp * 365.25).floor();
      } else {
        return 0;
      }
    }

    final mp = ((month + 9).floor()) % 12;
    final jdm = mp * 30 + ((mp + 1) * 34 ~/ 57);
    final jdd = day - 1;
    final jdh = hour / 24.0;
    return jdy + jdm + jdd + jdh + init;
  }

  /// 时分秒转儒略日的小数部分
  double dateToJuliandTimeWithHour(int hour, int min, int second) =>
      ((hour * 3600) + (min * 60) + second) / 86400.0;

  /// 儒略日转日期字符串：yyyy年MM月dd日HH时mm分ss秒
  String jtime(bool op, double jtoday) {
    final int y4h;
    final double init;
    if (jtoday >= 2299160.5 || op) {
      y4h = 146097;
      init = 1721119.5;
    } else {
      y4h = 146100;
      init = 1721117.5;
    }
    final jdr = (jtoday - init).floor();
    final yh = y4h / 4.0;
    final cen = ((jdr + 0.75) / yh).floor();
    var d = (jdr + 0.75 - cen * yh).floor();
    final ywl = 1461 / 4.0;
    final jy = ((d + 0.75) / ywl).floor();
    d = (d + 0.75 - ywl * jy + 1).floor();
    final ml = 153 / 5.0;
    final mp = ((d - 0.5) / ml).floor();
    d = ((d - 0.5) - 30.6 * mp + 1).floor();
    var y = (100 * cen) + jy;
    final m = (mp + 2) % 12 + 1;
    if (m < 3) y = y + 1;
    final sd =
        (((jtoday + 0.5 - (jtoday + 0.5).floorToDouble()) * 24 * 60 * 60) +
                0.00005)
            .floor();
    final mt = sd ~/ 60;
    final ss = sd % 60;
    final hh = mt ~/ 60;
    final mmt = mt % 60;

    return '$y年${_p2(m)}月${_p2(d)}日${_p2(hh)}时${_p2(mmt)}分${_p2(ss)}秒';
  }

  static String _p2(int v) => v.toString().padLeft(2, '0');

  // ---------------------------------------------------------------------------
  // 二十四节气（VSOP 摄动修正）
  // ---------------------------------------------------------------------------

  /// 求出以立春点开始的含中气之 24 节气，结果写入 jdpjq[0..24]
  void getPureJQsinceSpring2(
    int yy,
    int ptsa,
    int ptsb,
    int ptsc,
    List<double> jdpjq,
  ) {
    final sjdjq = List<double>.filled(50, 0);

    var yea = yy - 1;
    _getAdjustedJq(yea, 21, 3, sjdjq);
    jdpjq[0] = sjdjq[22]; // 立春
    jdpjq[1] = sjdjq[23]; // 雨水
    jdpjq[2] = sjdjq[24]; // 惊蛰

    yea = yy;
    _getAdjustedJq(yea, 0, 26, sjdjq);
    for (var i = 2; i <= 24; i++) {
      jdpjq[i + 1] = sjdjq[i - 1];
    }
  }

  void _getAdjustedJq(int yy, int ini, int num, List<double> jdjq) {
    final veb = _ve(yy);
    final ty = _ve(yy + 1) - veb;
    final ok = _meanJqjd(yy, veb, ty, ini, num);
    if (ok) {
      for (var i = ini + 1; i <= ini + num; i++) {
        final ptb = _perturbation(_jdezArr[i]);
        final dt = _deltaT(yy, (i ~/ 2) + 3);
        var v = _jdezArr[i] + ptb - dt / 60.0 / 24.0;
        v = v + 8 / 24.0; // 中国时间比格林威治先行 8 小时
        jdjq[i] = v;
      }
    }
  }

  /// 计算指定年份的春分点
  double _ve(int year) {
    final yx = year;
    double jdve;
    double m;
    if (yx >= 1000 && yx <= 8001) {
      m = (yx - 2000) / 1000.0;
      jdve = 2451623.80984 +
          365242.37404 * m +
          0.05169 * m * m -
          0.00411 * m * m * m -
          0.00057 * m * m * m * m;
    } else {
      if (yx >= -8000 && yx < 1000) {
        m = yx / 1000.0;
        jdve = 1721139.29189 +
            365242.1374 * m +
            0.06134 * m * m +
            0.00111 * m * m * m -
            0.00071 * m * m * m * m;
      } else {
        return 0;
      }
    }
    return jdve;
  }

  bool _meanJqjd(int yy, double jdve, double ty, int ini, int num) {
    const ath = 2 * math.pi / 24;
    final tx = (jdve - 2451545) / 365250;
    final e = 0.0167086342 -
        0.0004203654 * tx -
        0.0000126734 * tx * tx +
        0.0000001444 * tx * tx * tx -
        0.0000000002 * tx * tx * tx * tx +
        0.0000000003 * tx * tx * tx * tx * tx;
    final tt = yy / 1000.0;
    final vp = 111.25586939 -
        17.0119934518333 * tt -
        0.044091890166673 * tt * tt -
        4.37356166661345E-04 * tt * tt * tt +
        8.16716666602386E-06 * tt * tt * tt * tt;
    final rvp = vp * 2 * math.pi / 360;

    final peri = List<double>.filled(50, 0);

    for (var i = 1; i <= ini + num; i++) {
      var flag = 0;
      var th = ath * (i - 1) + rvp;
      if (th > math.pi && th <= 3 * math.pi) {
        th = 2 * math.pi - th;
        flag = 1;
      }
      if (th > 3 * math.pi) {
        th = 4 * math.pi - th;
        flag = 2;
      }
      final f1 = 2 * math.atan(math.sqrt((1 - e) / (1 + e)) * math.tan(th / 2));
      final f2 = (e * math.sqrt(1 - e * e) * math.sin(th)) /
          (1 + e * math.cos(th));
      var f = (f1 - f2) * ty / 2 / math.pi;
      if (flag == 1) f = ty - f;
      if (flag == 2) f = 2 * ty - f;
      peri[i] = f;
    }

    for (var i = ini; i <= ini + num; i++) {
      _jdezArr[i] = jdve + peri[i] - peri[1];
    }
    return true;
  }

  /// 其他星球摄动修正
  double _perturbation(double jdez) {
    final t = (jdez - 2451545) / 36525;
    var s = 0.0;

    const ptsa = [
      485, 203, 199, 182, 156,
      136, 77, 74, 70, 58,
      52, 50, 45, 44, 29,
      18, 17, 16, 14, 12,
      12, 12, 9, 8,
    ];
    const ptsb = [
      324.96, 337.23, 342.08, 27.85,
      73.14, 171.52, 222.54, 296.72,
      243.58, 119.81, 297.17, 21.02,
      247.54, 325.15, 60.93, 155.12,
      288.79, 198.04, 199.76, 95.39,
      287.11, 320.81, 227.73, 15.45,
    ];
    const ptsc = [
      1934.136, 32964.467, 20.186, 445267.112,
      45036.886, 22518.443, 65928.934, 3034.906,
      9037.513, 33718.147, 150.678, 2281.226,
      29929.562, 31555.956, 4443.417, 67555.328,
      4562.452, 62894.029, 31436.921, 14577.848,
      31931.756, 34777.259, 1222.114, 16859.074,
    ];

    for (var k = 0; k <= 23; k++) {
      s = s +
          ptsa[k] *
              math.cos(ptsb[k] * 2 * math.pi / 360 + ptsc[k] * 2 * math.pi / 360 * t);
    }
    final w = 35999.373 * t - 2.47;
    final l = 1 +
        0.0334 * math.cos(w * 2 * math.pi / 360) +
        0.0007 * math.cos(2 * w * 2 * math.pi / 360);
    return 0.00001 * s / l;
  }

  /// 地球运行速度偏差修正（分钟）
  double _deltaT(int yy, int mm) {
    double u, t, dt;
    final y = yy + (mm - 0.5) / 12;

    if (y <= -500) {
      u = (y - 1820) / 100;
      dt = (-20 + 32 * u * u);
    } else if (y < 500) {
      u = y / 100;
      dt = (10583.6 -
          1014.41 * u +
          33.78311 * u * u -
          5.952053 * u * u * u -
          0.1798452 * u * u * u * u +
          0.022174192 * u * u * u * u * u +
          0.0090316521 * u * u * u * u * u * u);
    } else if (y < 1600) {
      u = (y - 1000) / 100;
      dt = (1574.2 -
          556.01 * u +
          71.23472 * u * u +
          0.319781 * u * u * u -
          0.8503463 * u * u * u * u -
          0.005050998 * u * u * u * u * u +
          0.0083572073 * u * u * u * u * u * u);
    } else if (y < 1700) {
      t = y - 1600;
      dt = (120 - 0.9808 * t - 0.01532 * t * t + t * t * t / 7129);
    } else if (y < 1800) {
      t = y - 1700;
      dt = (8.83 +
          0.1603 * t -
          0.0059285 * t * t +
          0.00013336 * t * t * t -
          t * t * t * t / 1174000);
    } else if (y < 1860) {
      t = y - 1800;
      dt = (13.72 -
          0.332447 * t +
          0.0068612 * t * t +
          0.0041116 * t * t * t -
          0.00037436 * t * t * t * t +
          0.0000121272 * t * t * t * t * t -
          0.0000001699 * t * t * t * t * t * t +
          0.000000000875 * t * t * t * t * t * t * t);
    } else if (y < 1900) {
      t = y - 1860;
      dt = (7.62 +
          0.5737 * t -
          0.251754 * t * t +
          0.01680668 * t * t * t -
          0.0004473624 * t * t * t * t +
          t * t * t * t * t / 233174);
    } else if (y < 1920) {
      t = y - 1900;
      dt = (-2.79 +
          1.494119 * t -
          0.0598939 * t * t +
          0.0061966 * t * t * t -
          0.000197 * t * t * t * t);
    } else if (y < 1941) {
      t = y - 1920;
      dt = (21.2 + 0.84493 * t - 0.0761 * t * t + 0.0020936 * t * t * t);
    } else if (y < 1961) {
      t = y - 1950;
      dt = (29.07 + 0.407 * t - t * t / 233 + t * t * t / 2547);
    } else if (y < 1986) {
      t = y - 1975;
      dt = (45.45 + 1.067 * t - t * t / 260 - t * t * t / 718);
    } else if (y < 2005) {
      t = y - 2000;
      dt = (63.86 +
          0.3345 * t -
          0.060374 * t * t +
          0.0017275 * t * t * t +
          0.000651814 * t * t * t * t +
          0.00002373599 * t * t * t * t * t);
    } else if (y < 2050) {
      t = y - 2000;
      dt = (62.92 + 0.32217 * t + 0.005589 * t * t);
    } else if (y < 2150) {
      u = (y - 1820) / 100;
      dt = (-20 + 32 * u * u - 0.5628 * (2150 - y));
    } else {
      u = (y - 1820) / 100;
      dt = (-20 + 32 * u * u);
    }

    if (y < 1955 || y >= 2005) {
      dt = dt - (0.000012932 * (y - 1955) * (y - 1955));
    }
    return dt / 60;
  }

  // ---------------------------------------------------------------------------
  // 农历
  // ---------------------------------------------------------------------------

  /// 公历转农历，返回如「闰四月十四」；超范围或非法日期返回 null
  String? getLunarSolarCalendarWithYear(int y, int m, int d) {
    final yea = y;
    final mx = m;
    final dx = d;

    final zr = List<double>.filled(20, 0);
    final sjd = List<double>.filled(20, 0);
    final mc = List<double>.filled(20, 0);

    const op = false;

    if (yea < -7000 || yea > 7000) return null;
    if (yea < -1000 || yea > 3000) return null;
    if (!_validDateWithOp(op, yea, mx, dx)) return null;

    _getZQandSMandLunarMonthCodeWithOp(op, yea, zr, sjd, mc);

    final jdx = dateToJuliandTimeWithYear(yea, mx, dx, 12);

    // 安卓原实现此处还置了 flag 并算过阴历年 yi，但两者均未被使用，故省略
    if (jdx.floor() < (sjd[0] + 0.5).floor()) {
      _getZQandSMandLunarMonthCodeWithOp(op, yea - 1, zr, sjd, mc);
    }

    var mi = 0;
    for (var i = 0; i <= 14; i++) {
      final v1 = jdx.floor();
      final v2 = (sjd[i] + 0.5).floor();
      final v3 = (sjd[i + 1] + 0.5).floor();
      if (v1 >= v2 && v1 < v3) {
        mi = i;
        break;
      }
    }

    final dz = (jdx.floor() - (sjd[mi] + 0.5).floor() + 1);

    final ry = ((mc[mi] - mc[mi].floorToDouble()) * 2 + 1 == 1) ? '' : '闰';
    final mis = (_fmod((mc[mi] + 10).floorToDouble(), 12) + 1).toInt();

    final monthString = _monthChangeToChineseLanguage(mis);
    final dayString = _dayChangeToChineseLanguage(dz);

    return '$ry$monthString月$dayString';
  }

  bool _validDateWithOp(bool op, int yy, int mm, int dd) {
    var vd = true;
    if (mm <= 0 || mm > 12) {
      vd = false;
    } else {
      final ndf1 = yy % 4 == 0 ? -1 : 0;
      const ndf2 = 0;
      final ndf = ndf1 + ndf2;
      final jdage = mm == 2 ? 1 : 0;
      final dom = _toInt(30 +
          _fmod(((mm - 7.5).abs() + 0.5), 2) -
          (jdage * (2 + ndf)));
      if (dd <= 0 || dd > dom) {
        vd = false;
      }
    }

    if ((yy == 1582 && mm == 10 && dd >= 5 && dd < 15) && !op) {
      vd = false;
    }
    return vd;
  }

  void _getZQandSMandLunarMonthCodeWithOp(
    bool op,
    int yy,
    List<double> jdzq,
    List<double> jdnm,
    List<double> mc,
  ) {
    var yz = 0;
    _getZQsinceWinterSolsticeWithYear(yy, jdzq);
    _getSMsinceWinterSolsticeWithOp(op, yy, jdzq[0], jdnm);

    if ((jdzq[12] + 0.5).floor() >= (jdnm[13] + 0.5).floor()) {
      for (var i = 1; i <= 14; i++) {
        final value1 = (jdnm[i] + 0.5).floor();
        final value2 = (jdzq[i - 1 - yz] + 0.5).floor();
        final value3 = (jdnm[i + 1] + 0.5).floor();
        final value4 = (jdzq[i - yz] + 0.5).floor();
        if (value1 > value2 && value3 <= value4) {
          mc[i] = i - 0.5;
          yz = 1;
        } else {
          mc[i] = (i - yz).toDouble();
        }
      }
    } else {
      for (var i = 0; i <= 12; i++) {
        mc[i] = i.toDouble();
      }
      for (var i = 13; i <= 14; i++) {
        final value1 = (jdnm[i] + 0.5).floor();
        final value2 = (jdzq[i - 1 - yz] + 0.5).floor();
        final value3 = (jdnm[i + 1] + 0.5).floor();
        final value4 = (jdzq[i - yz] + 0.5).floor();
        if (value1 > value2 && value3 <= value4) {
          mc[i] = i - 0.5;
          yz = 1;
        } else {
          mc[i] = (i - yz).toDouble();
        }
      }
    }
  }

  void _getZQsinceWinterSolsticeWithYear(int yy, List<double> jdzq) {
    final dj = List<double>.filled(30, 0);

    _getAdjustedJq(yy - 1, 18, 5, dj);
    jdzq[0] = dj[19]; // 冬至中气
    jdzq[1] = dj[21]; // 大寒中气
    jdzq[2] = dj[23]; // 雨水中气

    _getAdjustedJq(yy, 0, 26, dj);
    for (var i = 1; i <= 13; i++) {
      jdzq[i + 2] = dj[2 * i - 1];
    }
  }

  void _getSMsinceWinterSolsticeWithOp(
    bool op,
    int yy,
    double jdws,
    List<double> jdnm,
  ) {
    final tjd = List<double>.filled(30, 0);

    final spcjd = dateToJuliandTimeWithYear(yy - 1, 11, 0, 0);
    final kn = _meanNewMoonWithJd(spcjd);
    for (var i = 0; i <= 19; i++) {
      final k = kn + i;
      tjd[i] = _trueNewMoonWithK(k) + 1 / 3.0;
      tjd[i] = tjd[i] - _deltaT(yy, i - 1) / 1440;
    }

    var j = 0;
    for (j = 0; j <= 18; j++) {
      if ((tjd[j] + 0.5).floor() > (jdws + 0.5).floor()) {
        break;
      }
    }
    var jj = j;
    if (jj < 1) jj = 1; // 保护：正常年份不会命中
    for (var g = 0; g <= 15; g++) {
      jdnm[g] = tjd[jj - 1 + g];
    }
  }

  /// 指定日期所属朔望月的均值新月月序（原实现中的均值修正项不影响返回的 k）
  int _meanNewMoonWithJd(double jd) =>
      ((jd - 2451550.09765) / _synmonth).floor();

  /// 实际新月点
  double _trueNewMoonWithK(num k) {
    final jdt = 2451550.09765 + k * _synmonth;

    final t = (jdt - 2451545) / 36525;
    final t2 = t * t;
    final t3 = t2 * t;
    final t4 = t3 * t;

    final pt = jdt + 0.0001337 * t2 - 0.00000015 * t3 + 0.00000000073 * t4;
    final m = 2.5534 + 29.10535669 * k - 0.0000218 * t2 - 0.00000011 * t3;
    final mprime = 201.5643 +
        385.81693528 * k +
        0.0107438 * t2 +
        0.00001239 * t3 -
        0.000000058 * t4;
    final f = 160.7108 +
        390.67050274 * k -
        0.0016341 * t2 -
        0.00000227 * t3 +
        0.000000011 * t4;
    final omega = 124.7746 - 1.5637558 * k + 0.0020691 * t2 + 0.00000215 * t3;
    final es = 1 - 0.002516 * t - 0.0000074 * t2;

    const d2r = math.pi / 180;
    var apt1 = -0.4072 * math.sin(d2r * mprime);
    apt1 += 0.17241 * es * math.sin(d2r * m);
    apt1 += 0.01608 * math.sin(d2r * 2 * mprime);
    apt1 += 0.01039 * math.sin(d2r * 2 * f);
    apt1 += 0.00739 * es * math.sin(d2r * (mprime - m));
    apt1 -= 0.00514 * es * math.sin(d2r * (mprime + m));
    apt1 += 0.00208 * es * es * math.sin(d2r * (2 * m));
    apt1 -= 0.00111 * math.sin(d2r * (mprime - 2 * f));
    apt1 -= 0.00057 * math.sin(d2r * (mprime + 2 * f));
    apt1 += 0.00056 * es * math.sin(d2r * (2 * mprime + m));
    apt1 -= 0.00042 * math.sin(d2r * 3 * mprime);
    apt1 += 0.00042 * es * math.sin(d2r * (m + 2 * f));
    apt1 += 0.00038 * es * math.sin(d2r * (m - 2 * f));
    apt1 -= 0.00024 * es * math.sin(d2r * (2 * mprime - m));
    apt1 -= 0.00017 * math.sin(d2r * omega);
    apt1 -= 0.00007 * math.sin(d2r * (mprime + 2 * m));
    apt1 += 0.00004 * math.sin(d2r * (2 * mprime - 2 * f));
    apt1 += 0.00004 * math.sin(d2r * (3 * m));
    apt1 += 0.00003 * math.sin(d2r * (mprime + m - 2 * f));
    apt1 += 0.00003 * math.sin(d2r * (2 * mprime + 2 * f));
    apt1 -= 0.00003 * math.sin(d2r * (mprime + m + 2 * f));
    apt1 += 0.00003 * math.sin(d2r * (mprime - m + 2 * f));
    apt1 -= 0.00002 * math.sin(d2r * (mprime - m - 2 * f));
    apt1 -= 0.00002 * math.sin(d2r * (3 * mprime + m));
    apt1 += 0.00002 * math.sin(d2r * (4 * mprime));

    var apt2 = 0.000325 * math.sin(d2r * (299.77 + 0.107408 * k - 0.009173 * t2));
    apt2 += 0.000165 * math.sin(d2r * (251.88 + 0.016321 * k));
    apt2 += 0.000164 * math.sin(d2r * (251.83 + 26.651886 * k));
    apt2 += 0.000126 * math.sin(d2r * (349.42 + 36.412478 * k));
    apt2 += 0.00011 * math.sin(d2r * (84.66 + 18.206239 * k));
    apt2 += 0.000062 * math.sin(d2r * (141.74 + 53.303771 * k));
    apt2 += 0.00006 * math.sin(d2r * (207.14 + 2.453732 * k));
    apt2 += 0.000056 * math.sin(d2r * (154.84 + 7.30686 * k));
    apt2 += 0.000047 * math.sin(d2r * (34.52 + 27.261239 * k));
    apt2 += 0.000042 * math.sin(d2r * (207.19 + 0.121824 * k));
    apt2 += 0.00004 * math.sin(d2r * (291.34 + 1.844379 * k));
    apt2 += 0.000037 * math.sin(d2r * (161.72 + 24.198154 * k));
    apt2 += 0.000035 * math.sin(d2r * (239.56 + 25.513099 * k));
    apt2 += 0.000023 * math.sin(d2r * (331.55 + 3.592518 * k));

    return pt + apt1 + apt2;
  }

  static String _monthChangeToChineseLanguage(int number) {
    const array = [
      '无极', '一', '二', '三',
      '四', '五', '六', '七', '八',
      '九', '十', '十一', '十二',
    ];
    return array[number];
  }

  static String _dayChangeToChineseLanguage(int number) {
    const array = [
      '无极', '初一', '初二', '初三', '初四',
      '初五', '初六', '初七', '初八', '初九',
      '初十', '十一', '十二', '十三', '十四',
      '十五', '十六', '十七', '十八', '十九',
      '二十', '廿一', '廿二', '廿三', '廿四',
      '廿五', '廿六', '廿七', '廿八', '廿九',
      '三十', '卅一',
    ];
    return array[number];
  }
}
