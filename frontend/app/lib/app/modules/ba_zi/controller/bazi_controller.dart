import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../../routes/app_pages.dart';
import '../../zhouyi/algorithm/bazi_calculator.dart';
import '../../zhouyi/algorithm/lunar_solar_util.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';

/// 结果页入参
class BaziResultArgs {
  const BaziResultArgs({
    required this.head,
    required this.sex,
    required this.name,
  });

  final ZYHourQimenHeadModel head;

  /// 0=女 1=男
  final int sex;
  final String name;
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

  final calculating = false.obs;

  void setName(String value) => name.value = value;

  void setSex(int value) => sex.value = value;

  /// 起四柱并跳转结果页
  Future<void> start() async {
    if (calculating.value) return;
    calculating.value = true;
    await Future<void>.delayed(Duration.zero);
    try {
      final head = _calculator.calculate(
        ZYDatetimeModel.fromDateTime(birthTime.value),
        sex: sex.value,
        mingZhuName: name.value,
      );
      Get.toNamed(
        Routes.BAZIRESULTPAGE,
        arguments: BaziResultArgs(head: head, sex: sex.value, name: name.value),
      );
    } catch (e) {
      showMessage('排盘失败：$e');
    } finally {
      calculating.value = false;
    }
  }

  /// 阴历（YYYYMMDD）转阳历，成功返回对应日期并保留原时分
  DateTime? lunarToSolar(String lunarDate) {
    if (lunarDate.length != 8) return null;
    final String solar;
    try {
      solar = LunarSolarUtil.lunarToSolar(lunarDate, false);
    } catch (_) {
      return null;
    }
    if (solar.length != 8) return null;
    final now = birthTime.value;
    return DateTime(
      int.parse(solar.substring(0, 4)),
      int.parse(solar.substring(4, 6)),
      int.parse(solar.substring(6, 8)),
      now.hour,
      now.minute,
    );
  }
}
