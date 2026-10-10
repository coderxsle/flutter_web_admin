import 'chn_chinese_calendar.dart';
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
  /// 九宫洛书飞布轨迹，所有盘都靠旋转这个 8 元素序列落宫
  static const String _luoshu = '18349276';

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

    // 1) 地盘三奇六仪
    final qiyiLocation = 9 - juNumber + 1;
    final String diPan;
    if (isYang) {
      const qiyi = '戊己庚辛壬癸丁丙乙戊己庚辛壬癸丁丙乙';
      diPan = qiyi.substring(qiyiLocation, qiyiLocation + 9);
    } else {
      const qiyi = '戊乙丙丁癸壬辛庚己戊乙丙丁癸壬辛庚己';
      diPan = qiyi.substring(qiyiLocation, qiyiLocation + 9);
    }
    model.diPanQiyi = diPan.split('');

    // 2) 时旬首
    final shizhi = head.hourGanzhi.substring(1, 2);
    final shigan = head.hourGanzhi.substring(0, 1);
    var chunSau =
        ZhouyiConst.shiErDiZhi.indexOf(shizhi) - ZhouyiConst.shiTianGan.indexOf(shigan);
    if (chunSau < 0) chunSau += 12;
    final startIdx = chunSau ~/ 2;
    final xunshou = '子寅辰午申戌'.substring(startIdx, startIdx + 1);
    final xunshouGan = '戊癸壬辛庚己'.substring(startIdx, startIdx + 1);
    head.hourXunShou = '甲$xunshou$xunshouGan';

    // 3) 值符
    final idxString = '子寅辰午申戌'.substring(startIdx, startIdx + 1);
    chunSau = ' 子戌申午辰寅'.indexOf(idxString);

    var jikFuIdx = 0;
    var jikFuStar = 0;
    var tmp = head.hourGanzhi.substring(0, 1);

    if (isYang) {
      jikFuIdx = juNumber + chunSau - 1;
      while (jikFuIdx > 9) {
        jikFuIdx -= 9;
      }
      while (jikFuIdx < 1) {
        jikFuIdx += 9;
      }
      if (tmp == '甲') tmp = ' 戊己庚辛壬癸'.substring(chunSau, chunSau + 1);
      jikFuStar = ' 戊己庚辛壬癸丁丙乙'.indexOf(tmp) + juNumber - 1;
      while (jikFuStar > 9) {
        jikFuStar -= 9;
      }
    } else {
      jikFuIdx = 1 + juNumber - chunSau;
      while (jikFuIdx > 9) {
        jikFuIdx -= 9;
      }
      while (jikFuIdx < 1) {
        jikFuIdx += 9;
      }
      if (tmp == '甲') tmp = ' 戊己庚辛壬癸'.substring(chunSau, chunSau + 1);
      jikFuStar = 1 + juNumber - ' 戊己庚辛壬癸丁丙乙'.indexOf(tmp);
      while (jikFuStar < 1) {
        jikFuStar += 9;
      }
    }

    final zhiFu = ' 蓬芮冲辅禽心柱任英'.substring(jikFuIdx, jikFuIdx + 1);
    head.zhiFu = '天$zhiFu落$jikFuStar宫';
    // 禽星寄二宫
    if (jikFuStar == 5) jikFuStar = 2;

    // 4) 值使
    var jikFuMun = 0;
    final ganLoc =
        ' 甲乙丙丁戊己庚辛壬癸'.indexOf(head.hourGanzhi.substring(0, 1));
    if (head.dunType == YinYangType.yang) {
      jikFuMun = jikFuIdx + ganLoc - 1;
    } else {
      jikFuMun = jikFuIdx - ganLoc + 1;
    }
    while (jikFuMun > 9) {
      jikFuMun -= 9;
    }
    while (jikFuMun < 1) {
      jikFuMun += 9;
    }

    var zhiShi = ' 休死伤杜 开惊生景'.substring(jikFuIdx, jikFuIdx + 1);
    if (zhiShi == ' ') zhiShi = '死';
    final displayJikFuMun = jikFuMun;
    // 值使落 5 宫寄 2 宫
    if (jikFuMun == 5) jikFuMun = 2;
    head.zhiShi = '$zhiShi門落$displayJikFuMun宫';

    // 5) 九星盘
    final starPan = _buildPan(_luoshu.indexOf('$jikFuStar'), jikFuIdx);
    final housesStar = <String>[];
    const starString = ' 蓬芮冲辅禽心柱任英';
    for (var i = 0; i < 9; i++) {
      final v = starPan[i];
      housesStar.add('天${starString.substring(v, v + 1)}');
    }
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
      int t;
      if (isYang) {
        t = starPan[i] - juNumber + 1;
      } else {
        t = juNumber - starPan[i] + 1;
      }
      while (t < 1) {
        t += 9;
      }
      tianPan.add(' 戊己庚辛壬癸丁丙乙'.substring(t, t + 1));
    }
    // 五宫寄二宫：中五宫天盘干并入二宫
    final wuGan = tianPan[4];
    tianPan[4] = '';
    tianPan[erGongIndex] = '$wuGan${tianPan[erGongIndex]}';
    model.tianPanQiyi = tianPan;

    // 7) 人盘八门
    final doorPan = _buildPan(_luoshu.indexOf('$jikFuMun'), jikFuIdx);
    final houseDoor = <String>[];
    for (var i = 0; i < 9; i++) {
      final v = doorPan[i];
      houseDoor.add('${'，休死伤杜　开惊生景'.substring(v, v + 1)}门');
    }
    houseDoor[4] = '';
    model.baMen = houseDoor;

    // 8) 神盘八神
    final godTarget = _luoshu.indexOf('$jikFuStar');
    final housesGod = <String>[
      if (isYang) ...['值符', '腾蛇', '太阴', '六合', '白虎', '玄武', '九地', '九天']
      else ...['值符', '九天', '九地', '玄武', '白虎', '六合', '太阴', '腾蛇'],
    ];
    while (housesGod[godTarget] != '值符') {
      housesGod.insert(0, housesGod.removeLast());
    }
    final godPan = <String>[];
    for (var i = 1; i < 10; i++) {
      if (i == 5) {
        godPan.add('　');
      } else {
        godPan.add(housesGod[_luoshu.indexOf('$i')]);
      }
    }
    model.baShen = godPan;

    // 9) 马星
    final maxing = List<int>.filled(9, 0);
    final hourZhi = head.hourGanzhi.substring(1, 2);
    final maIndex = '申子辰寅午戌亥卯未巳酉丑'.indexOf(hourZhi);
    if (maIndex == 0 || maIndex == 1 || maIndex == 2) {
      maxing[7] = 1; // 马星在寅
    } else if (maIndex == 3 || maIndex == 4 || maIndex == 5) {
      maxing[1] = 1; // 马星在申
    } else if (maIndex == 6 || maIndex == 7 || maIndex == 8) {
      maxing[3] = 1; // 马星在巳
    } else if (maIndex == 9 || maIndex == 10 || maIndex == 11) {
      maxing[5] = 1; // 马星在亥
    }
    model.maXing = maxing;

    // 10) 地盘值符落宫（时旬首之干在地盘的位置）
    var diZhiFuIndex = diPan.indexOf(xunshouGan);
    if (diZhiFuIndex == 4) diZhiFuIndex = 1; // 5 宫寄 2 宫
    model.diPanZhiFuIndex = diZhiFuIndex;

    // 11) 暗干（地盘值符宫起甲）
    final anGan = _buildAnGan(head.dunType == YinYangType.yin, diZhiFuIndex);
    model.anGan = _splitPairedString(
        anGan, diZhiFuIndex, head.dunType == YinYangType.yin);

    // 12) 飞支
    final feiZhiStr = _buildFeiZhi(
        isYang: isYang, xunshou: xunshou, diZhiFuIndex: diZhiFuIndex);
    model.feiZhi = _splitPairedString(
        feiZhiStr, diZhiFuIndex, head.dunType == YinYangType.yin);

    // 13) 地盘八神
    final diGodTarget = _luoshu.indexOf('${diZhiFuIndex + 1}');
    final diHousesGod = <String>[
      if (isYang) ...['符', '蛇', '阴', '合', '白', '玄', '地', '天']
      else ...['符', '天', '地', '玄', '白', '合', '阴', '蛇'],
    ];
    while (diHousesGod[diGodTarget] != '符') {
      diHousesGod.insert(0, diHousesGod.removeLast());
    }
    final diGodPan = <String>[];
    for (var i = 1; i < 10; i++) {
      if (i == 5) {
        diGodPan.add('　');
      } else {
        diGodPan.add(diHousesGod[_luoshu.indexOf('$i')]);
      }
    }
    model.diBaShen = diGodPan;

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

  /// 按洛书轨迹落宫：把 [1,8,3,4,9,2,7,6] 旋转到目标位置，再映射回 1..9 宫
  ///
  /// [targetPos] 为目标宫在 [_luoshu] 中的下标，[alignValue] 为参与旋转对齐的值。
  List<int> _buildPan(int targetPos, int jikFuIdx) {
    final idx = <int>[1, 8, 3, 4, 9, 2, 7, 6];
    final align = (jikFuIdx == 5 ? 2 : jikFuIdx);
    while (idx[targetPos] != align) {
      idx.insert(0, idx.removeLast());
    }
    final pan = <int>[];
    for (var i = 1; i < 10; i++) {
      if (i == 5) {
        pan.add(5);
      } else {
        pan.add(idx[_luoshu.indexOf('$i')]);
      }
    }
    return pan;
  }

  /// 暗干串：从地盘值符宫起甲
  String _buildAnGan(bool isYin, int diZhiFuIndex) {
    const yangGan = '甲乙丙丁戊己庚辛壬癸甲乙丙丁戊己庚辛壬癸';
    const yinGan = '癸壬辛庚己戊丁丙乙甲癸壬辛庚己戊丁丙乙甲';
    final source = isYin ? yinGan : yangGan;
    final loc = 9 - diZhiFuIndex;
    return source.substring(loc, loc + 10);
  }

  /// 飞支串：按旬首选取地支序列
  String _buildFeiZhi({
    required bool isYang,
    required String xunshou,
    required int diZhiFuIndex,
  }) {
    const yangZhi = {
      '子': '丑寅卯辰巳午未申酉子丑寅卯辰巳午未申酉子',
      '戌': '亥子丑寅卯辰巳午未戌亥子丑寅卯辰巳午未戌',
      '申': '酉戌亥子丑寅卯辰巳申酉戌亥子丑寅卯辰巳申',
      '午': '未申酉戌亥子丑寅卯午未申酉戌亥子丑寅卯午',
      '辰': '巳午未申酉戌亥子丑辰巳午未申酉戌亥子丑辰',
      '寅': '卯辰巳午未申酉戌亥寅卯辰巳午未申酉戌亥寅',
    };
    const yinZhi = {
      '子': '申未午巳辰卯寅丑子酉申未午巳辰卯寅丑子酉',
      '戌': '午巳辰卯寅丑子亥戌未午巳辰卯寅丑子亥戌未',
      '申': '辰卯寅丑子亥戌酉申巳辰卯寅丑子亥戌酉申巳',
      '午': '寅丑子亥戌酉申未午卯寅丑子亥戌酉申未午卯',
      '辰': '子亥戌酉申未午巳辰丑子亥戌酉申未午巳辰丑',
      '寅': '戌酉申未午巳辰卯寅亥戌酉申未午巳辰卯寅亥',
    };
    final source = (isYang ? yangZhi : yinZhi)[xunshou];
    if (source == null) {
      throw QimenException('飞支序列缺失：旬首 $xunshou');
    }
    final loc = 9 - diZhiFuIndex - 1;
    return source.substring(loc, loc + 10);
  }

  /// 把长度 10 的串拆成 9 项：值符宫合并两字，阴遁时调换两字顺序
  List<String> _splitPairedString(
    String source,
    int diZhiFuIndex,
    bool isYin,
  ) {
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
