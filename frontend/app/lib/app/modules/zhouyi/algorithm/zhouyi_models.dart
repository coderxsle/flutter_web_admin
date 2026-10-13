import 'chn_chinese_calendar.dart';
import 'cheng_gu_util.dart';
import 'gan_zhi_relation.dart';
import 'wang_shuai_util.dart';
import 'zhouyi_constants.dart';

/// 排盘头部模型（对应安卓 ZYHourQimenHeadModel）
///
/// 奇门与四柱八字共用：八字只用到头部里的六亲/纳音/藏干/十二宫/大运等字段。
class ZYHourQimenHeadModel {
  // ---- 八字字段 ----
  List<String> riGanLiuQinList = [];
  List<String> siZhuNaYin = [];
  List<String> cangGanArray = [];
  List<String> cangGanLiuQinArray = [];
  List<String> shiErGongArray = [];
  String qiYunTime = '';
  String jiaoYunTime = '';
  List<String> daYun = [];
  List<String> daYunTime = [];
  List<String> liuNianList = [];

  /// 神煞：年/月/日/时四柱各一组命中的神煞名
  List<List<String>> shenShaArray = [[], [], [], []];

  /// 神煞去重汇总，供结果页汇总行展示
  List<String> shenShaSummary = [];

  /// 五行个数（木火土金水），天干与地支本气各计 1
  Map<String, int> wuXingCount = {};

  /// 胎元
  String taiYuan = '';

  /// 四柱之间的干支关系（天干五合相冲、地支六合六冲六害相刑、三合三会）
  List<GanZhiRelationItem> ganZhiRelation = [];

  /// 日干在四柱地支上的十二长生
  List<String> changShengArray = [];

  /// 命宫干支
  String mingGong = '';

  /// 身宫干支
  String shenGong = '';

  /// 日主旺衰与喜忌，法定干支不全时为 null
  WangShuaiResult? wangShuai;

  /// 格局（以月令本气取）
  String geJu = '';

  /// 人元司令：交节后当令的藏干
  String renYuan = '';

  /// 交节至出生的天数，人元司令分段与展示用
  double renYuanDays = 0;

  /// 袁天罡称骨结果
  ChengGuResult? chengGu;

  // ---- 通用字段 ----
  List<String> dateTimes = [];
  String yearGanzhi = '';
  String monthGanzhi = '';
  String dayGanzhi = '';
  String hourGanzhi = '';
  String yearEmpty = '';
  String monthEmpty = '';
  String dayEmpty = '';
  String hourEmpty = '';

  /// 三元：上/中/下
  String sanYuan = '';
  String jieQi = '';
  String jieQiTime = '';
  String siZhuName = '';
  String siZhuYangLi = '';
  String yangLi = '';
  String nongli = '';

  /// 阴遁(0) / 阳遁(1)
  int dunType = YinYangType.yang;
  int jushu = 0;
  String hourXunShou = '';
  String zhiFu = '';
  String zhiShi = '';
  String zhongqi = '';
  String zhongQiTime = '';

  void setDateWithTime(int year, int month, int day, int hour, int minute,
      int second) {
    dateTimes = [
      '$year',
      _p2(month),
      _p2(day),
      _p2(hour),
      _p2(minute),
      _p2(second),
    ];
    siZhuYangLi = '$year年${_p2(month)}月${_p2(day)}日 ${_p2(hour)}时';
  }

  static String _p2(int v) => v.toString().padLeft(2, '0');

  /// 设置四柱干支并计算四柱空亡
  void setSiZhuBaZiWithJsonDict(Map<String, String> ganzhiDict) {
    yearGanzhi = ganzhiDict['yearGanzhi'] ?? '';
    monthGanzhi = ganzhiDict['monthGanzhi'] ?? '';
    dayGanzhi = ganzhiDict['dayGanzhi'] ?? '';
    hourGanzhi = ganzhiDict['hourGanzhi'] ?? '';
    computeSiZhuBaZiKongWang();
  }

  void computeSiZhuBaZiKongWang() {
    final ganzhi = '$yearGanzhi$monthGanzhi$dayGanzhi$hourGanzhi';
    final kongwang =
        ChnChineseCalendar.instance.kongwangWithGanzhi(ganzhi);
    yearEmpty = kongwang.substring(0, 2);
    monthEmpty = kongwang.substring(2, 4);
    dayEmpty = kongwang.substring(4, 6);
    hourEmpty = kongwang.substring(6, 8);
  }

  /// 五不遇时
  bool isWuBuYuShi() {
    const tianGan1 = '甲乙丙丁戊己庚辛壬癸';
    const tianGan2 = '戊己庚辛壬癸甲乙丙丁';
    final shiGan = hourGanzhi.substring(0, 1);
    final riGan = dayGanzhi.substring(0, 1);
    return tianGan1.indexOf(shiGan) == tianGan2.indexOf(riGan);
  }
}

/// 奇门整盘模型（对应安卓 ZYHourQimenModel）
///
/// 所有盘的下标 i 对应宫位 (i+1)：index 0 = 坎1宫，index 4 = 中5宫。
class ZYHourQimenModel {
  ZYHourQimenHeadModel head = ZYHourQimenHeadModel();

  /// 地盘三奇六仪
  List<String> diPanQiyi = [];

  /// 天盘九星，如「天蓬」「禽芮」
  List<String> jiuXing = [];

  /// 天盘三奇六仪（五宫寄二宫时二宫元素为两字）
  List<String> tianPanQiyi = [];

  /// 人盘八门，中 5 宫为空串
  List<String> baMen = [];

  /// 神盘八神，中 5 宫为全角空格
  List<String> baShen = [];

  /// 暗干
  List<String> anGan = [];

  /// 马星，1 表示该宫有马星
  List<int> maXing = List<int>.filled(9, 0);

  /// 飞支
  List<String> feiZhi = [];

  /// 地盘八神（单字：符/蛇/阴/合/白/玄/地/天）
  List<String> diBaShen = [];

  /// 地盘值符落宫（0 基）
  int diPanZhiFuIndex = 0;

  /// 十干克应（天盘干 + 地盘干）
  List<String> shiGanKeYing1 = [];

  /// 十干克应（暗干飞支之干 + 地盘干）
  List<String> shiGanKeYing2 = [];
}
