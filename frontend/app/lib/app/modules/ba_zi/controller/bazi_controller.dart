import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../../routes/app_pages.dart';
import '../../zhouyi/algorithm/bazi_calculator.dart';
import '../../zhouyi/algorithm/solar_time_util.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';
import '../service/bazi_record_store.dart';

/// 结果页入参
class BaziResultArgs {
  const BaziResultArgs({
    required this.head,
    required this.sex,
    required this.name,
    this.yeZiShi = false,
    this.longitude,
    this.recordId,
  });

  final ZYHourQimenHeadModel head;

  /// 0=女 1=男
  final int sex;
  final String name;

  /// 是否按夜子时起盘（23 时后日柱归前一日）
  final bool yeZiShi;

  /// 出生地经度，null 表示未做真太阳时校正
  final double? longitude;

  /// 本地记录 id，用于回读与保存卦解
  final String? recordId;
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

  /// 历史排盘，按时间倒序
  final history = <BaziRecord>[].obs;

  final calculating = false.obs;

  @override
  void onInit() {
    super.onInit();
    refreshHistory();
  }

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

  void refreshHistory() => history.value = BaziRecordStore.all();

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

      // 先落一条记录，卦解与反馈留空，等结果页补
      final record = BaziRecord(
        id: BaziRecordStore.newId(),
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
      await BaziRecordStore.upsert(record);

      _open(head, record: record, lng: lng);
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
        id: BaziRecordStore.newId(),
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
      await BaziRecordStore.upsert(record);

      _open(head, record: record);
    } catch (e) {
      showMessage('排盘失败：$e');
    } finally {
      calculating.value = false;
    }
  }

  /// 用历史记录重算并打开结果页
  void openRecord(BaziRecord record) {
    try {
      final four = record.pillars ?? const <String>[];
      final head = record.isPillarInput
          ? _calculator.fromPillars(
              yearGanzhi: four[0],
              monthGanzhi: four[1],
              dayGanzhi: four[2],
              hourGanzhi: four[3],
              mingZhuName: record.name,
            )
          : _calculator.calculate(
              record.toDateTime(),
              sex: record.sex,
              yeZiShi: record.yeZiShi,
              mingZhuName: record.name,
            );
      _open(head, record: record, lng: record.longitude);
    } catch (e) {
      showMessage('记录重算失败：$e');
    }
  }

  Future<void> removeRecord(String id) async {
    await BaziRecordStore.remove(id);
    refreshHistory();
  }

  void _open(ZYHourQimenHeadModel head, {required BaziRecord record, double? lng}) {
    Get.toNamed(
      Routes.BAZIRESULTPAGE,
      arguments: BaziResultArgs(
        head: head,
        sex: record.sex,
        name: record.name,
        yeZiShi: record.yeZiShi,
        longitude: lng,
        recordId: record.id,
      ),
    );
  }
}
