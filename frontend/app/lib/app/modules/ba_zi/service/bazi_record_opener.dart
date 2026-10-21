import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/algorithm/bazi_calculator.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../controller/bazi_controller.dart';
import '../model/bazi_record.dart';

/// 用一条记录重算盘面：历史列表与合盘都走这里，免得两处各写一套分支。
class BaziRecordOpener {
  BaziRecordOpener._();

  /// 甲子历直录的走 [BaziCalculator.fromPillars]，其余按公历生辰重算
  static ZYHourQimenHeadModel calculate(BaziRecord record) {
    final calculator = BaziCalculator();
    if (!record.isPillarInput) {
      return calculator.calculate(
        record.toDateTime(),
        sex: record.sex,
        yeZiShi: record.yeZiShi,
        mingZhuName: record.name,
      );
    }
    final four = record.pillars!;
    return calculator.fromPillars(
      yearGanzhi: four[0],
      monthGanzhi: four[1],
      dayGanzhi: four[2],
      hourGanzhi: four[3],
      mingZhuName: record.name,
    );
  }

  /// 重算后进入结果页；算法不认这条记录时提示并留在原页
  static Future<bool> open(BaziRecord record) async {
    try {
      final head = calculate(record);
      await Get.toNamed(Routes.BAZIRESULTPAGE, arguments: BaziResultArgs(head: head, record: record));
      return true;
    } catch (e) {
      showMessage('记录重算失败：$e');
      return false;
    }
  }
}
