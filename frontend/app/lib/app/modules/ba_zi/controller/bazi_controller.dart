import 'dart:async';

import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../../routes/app_pages.dart';
import '../../zhouyi/algorithm/bazi_calculator.dart';
import '../../zhouyi/algorithm/solar_time_util.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';
import '../model/bazi_record.dart';
import '../service/bazi_record_sync.dart';

/// 结果页入参
class BaziResultArgs {
  const BaziResultArgs({required this.head, required this.record});

  final ZYHourQimenHeadModel head;

  /// 本次命例，结果页据此回写卦解/反馈/标签
  final BaziRecord record;

  String get name => record.name;

  /// 0=女 1=男
  int get sex => record.sex;

  /// 是否按夜子时起盘（23 时后日柱归前一日）
  bool get yeZiShi => record.yeZiShi;

  /// 出生地经度，null 表示未做真太阳时校正
  double? get longitude => record.longitude;
}

/// 四柱八字输入页控制器（对应安卓 BaZiFragment）。
class BaziInputController extends GetxController {
  final BaziCalculator _calculator = BaziCalculator();

  /// 命主姓名
  final name = ''.obs;

  /// 生辰
  final birthTime = DateTime.now().obs;

  /// 性别：0=女 1=男
  final sex = BaziSex.man.obs;

  /// 夜子时：23 时之后日柱归前一日，默认关闭
  final yeZiShi = false.obs;

  /// 出生地经度，为 null 时不做真太阳时校正
  final longitude = RxnDouble();

  /// 甲子历直录的四柱（年/月/日/时），空串表示该柱未选
  final pillars = <String>['', '', '', ''].obs;

  /// 四柱是否已填全，填全即按甲子历直录出盘
  bool get pillarsComplete =>
      pillars.length == 4 && pillars.every((e) => e.length == 2);

  /// 已填了几柱
  int get pillarsFilled => pillars.where((e) => e.isNotEmpty).length;

  final calculating = false.obs;

  void setName(String value) => name.value = value;

  void setSex(int value) => sex.value = value;

  void setYeZiShi(bool value) => yeZiShi.value = value;

  void setLongitude(double? value) => longitude.value = value;

  /// 设置第 [index] 柱；传空串即清空该柱
  void setPillar(int index, String value) {
    if (index < 0 || index >= pillars.length) return;
    final next = [...pillars];
    next[index] = value;
    pillars.value = next;
  }

  void clearPillars() => pillars.value = ['', '', '', ''];

  /// 起四柱并跳转结果页
  ///
  /// 甲子历四柱填全时改走直录；只填了一部分则拦下，避免拿着半截干支起盘。
  Future<void> start() async {
    if (calculating.value) return;
    if (pillarsComplete) return startFromPillars();
    if (pillarsFilled > 0) {
      showMessage('甲子历需填全年、月、日、时四柱');
      return;
    }
    calculating.value = true;
    await Future<void>.delayed(Duration.zero);
    try {
      final lng = longitude.value;
      final birth =
          lng == null ? birthTime.value : SolarTimeUtil.correct(birthTime.value, lng);
      final head = _calculator.calculate(
        ZYDatetimeModel.fromDateTime(birth),
        sex: sex.value,
        yeZiShi: yeZiShi.value,
        mingZhuName: name.value,
      );

      final record = BaziRecord(
        clientKey: BaziRecordSync.newClientKey(),
        name: name.value,
        sex: sex.value,
        year: birth.year,
        month: birth.month,
        day: birth.day,
        hour: birth.hour,
        minute: birth.minute,
        yeZiShi: yeZiShi.value,
        longitude: lng,
      );
      // 排盘即写库；失败只记日志，结果页保存时会用同一 clientKey 重试
      unawaited(BaziRecordSync.save(record, head));

      _open(head, record);
    } catch (e) {
      showMessage('排盘失败：$e');
    } finally {
      calculating.value = false;
    }
  }

  /// 按甲子历直录四柱出盘，节气、称骨、大运等依赖真实时刻的内容留空
  Future<void> startFromPillars() async {
    if (calculating.value) return;
    if (!pillarsComplete) {
      showMessage('甲子历需填全年、月、日、时四柱');
      return;
    }
    calculating.value = true;
    await Future<void>.delayed(Duration.zero);
    try {
      final four = pillars.toList();
      final head = _calculator.fromPillars(
        yearGanzhi: four[0],
        monthGanzhi: four[1],
        dayGanzhi: four[2],
        hourGanzhi: four[3],
        mingZhuName: name.value,
      );

      final record = BaziRecord(
        clientKey: BaziRecordSync.newClientKey(),
        name: name.value,
        sex: sex.value,
        year: 0,
        month: 0,
        day: 0,
        hour: 0,
        minute: 0,
        yeZiShi: false,
        pillars: four,
      );
      unawaited(BaziRecordSync.save(record, head));

      _open(head, record);
    } catch (e) {
      showMessage('排盘失败：$e');
    } finally {
      calculating.value = false;
    }
  }

  void _open(ZYHourQimenHeadModel head, BaziRecord record) {
    Get.toNamed(Routes.BAZIRESULTPAGE, arguments: BaziResultArgs(head: head, record: record));
  }
}
