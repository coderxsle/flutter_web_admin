import 'dart:convert';

import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/common_widget/logger.dart';
import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/http/arts_record_item.dart';
import '../../zhouyi/http/arts_record_request.dart';

/// 奇门排盘记录落库。
///
/// 触发点只有两处：输入页「开始排盘」后落一条（占事为空），结果页「保存」时
/// 用同一个 `clientKey` 覆盖，补上占事、卦解与反馈。
class QimenRecordSync {
  QimenRecordSync._();

  /// 一次排盘的业务主键，客户端生成，服务端据此幂等
  static String newClientKey() => 'qimen_${DateTime.now().microsecondsSinceEpoch}';

  /// 排盘时调用；失败只记日志，不影响出盘
  static Future<bool> report({
    required String clientKey,
    required DateTime chartTime,
    required QimenMethod method,
    required bool showAnGan,
    required bool showDiBaShen,
    required ZYHourQimenModel model,
  }) =>
      _save(
        clientKey: clientKey,
        chartTime: chartTime,
        method: method,
        showAnGan: showAnGan,
        showDiBaShen: showDiBaShen,
        model: model,
      );

  /// 保存占事/卦解/反馈
  static Future<bool> saveNotes({
    required String clientKey,
    required DateTime chartTime,
    required QimenMethod method,
    required bool showAnGan,
    required bool showDiBaShen,
    required ZYHourQimenModel model,
    required String question,
    required String interpretation,
    required String feedback,
  }) =>
      _save(
        clientKey: clientKey,
        chartTime: chartTime,
        method: method,
        showAnGan: showAnGan,
        showDiBaShen: showDiBaShen,
        model: model,
        question: question,
        interpretation: interpretation,
        feedback: feedback,
      );

  static Future<bool> _save({
    required String clientKey,
    required DateTime chartTime,
    required QimenMethod method,
    required bool showAnGan,
    required bool showDiBaShen,
    required ZYHourQimenModel model,
    String question = '',
    String interpretation = '',
    String feedback = '',
  }) async {
    try {
      final response = await ArtsRecordRequest.save({
        'arts_type': ArtsRecordType.qimen,
        'client_key': clientKey,
        'title': question.trim(),
        'question': question.trim(),
        'chart_time': chartTime.toIso8601String(),
        'query_params': _queryParams(chartTime, method, showAnGan, showDiBaShen),
        'chart_snapshot': _snapshot(model),
        'interpretation': interpretation.trim(),
        'feedback': feedback.trim(),
      });
      return response.success;
    } catch (e) {
      logger.e('奇门排盘记录写入失败：$e');
      return false;
    }
  }

  static Map<String, dynamic> _queryParams(DateTime chartTime, QimenMethod method, bool showAnGan, bool showDiBaShen) =>
      {
        'chart_time': chartTime.toIso8601String(),
        'method': method.name,
        'show_an_gan': showAnGan,
        'show_di_ba_shen': showDiBaShen,
      };

  /// 盘面快照：只存结果页要展示与复盘的部分，算法改动后旧记录仍可对照。
  static String _snapshot(ZYHourQimenModel model) {
    final head = model.head;
    return jsonEncode({
      'si_zhu': [head.yearGanzhi, head.monthGanzhi, head.dayGanzhi, head.hourGanzhi],
      'kong_wang': [head.yearEmpty, head.monthEmpty, head.dayEmpty, head.hourEmpty],
      'jie_qi': head.jieQi,
      'jie_qi_time': head.jieQiTime,
      'zhong_qi': head.zhongqi,
      'san_yuan': head.sanYuan,
      'dun_type': head.dunType,
      'ju_shu': head.jushu,
      'zhi_fu': head.zhiFu,
      'zhi_shi': head.zhiShi,
      'xun_shou': head.hourXunShou,
      'nong_li': head.nongli,
      'yang_li': head.yangLi,
      'pan': {
        'di_pan': model.diPanQiyi,
        'jiu_xing': model.jiuXing,
        'tian_pan': model.tianPanQiyi,
        'ba_men': model.baMen,
        'ba_shen': model.baShen,
        'an_gan': model.anGan,
        'ma_xing': model.maXing,
        'fei_zhi': model.feiZhi,
        'di_ba_shen': model.diBaShen,
      },
      'shi_gan_ke_ying': [model.shiGanKeYing1, model.shiGanKeYing2],
    });
  }
}
