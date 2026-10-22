import 'dart:convert';

import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/common_widget/logger.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/http/arts_record_item.dart';
import '../../zhouyi/http/arts_record_request.dart';
import '../model/bazi_record.dart';

/// 八字排盘记录落库。
///
/// 起盘时落一条，结果页保存卦解/反馈、增删标签时用同一 [BaziRecord.clientKey]
/// 覆盖，服务端按 `client_key` 幂等，不会产生重复记录。
class BaziRecordSync {
  BaziRecordSync._();

  /// 一次排盘的业务主键，客户端生成，服务端据此幂等
  static String newClientKey() => 'bazi_${DateTime.now().microsecondsSinceEpoch}';

  /// 新增或覆盖同一条记录；失败只记日志，不打断排盘
  static Future<bool> save(BaziRecord record, ZYHourQimenHeadModel head) async {
    try {
      final response = await ArtsRecordRequest.save({
        'artsType': ArtsRecordType.bazi,
        'clientKey': record.clientKey,
        'title': record.name,
        'question': '',
        'chartTime': _chartTime(record).toIso8601String(),
        'queryParams': _queryParams(record),
        'chartSnapshot': _snapshot(head),
        'interpretation': record.beiZhu,
        'feedback': record.feedback,
        'tags': record.tags,
      });
      return response.success;
    } catch (e) {
      logger.e('八字排盘记录写入失败：$e');
      return false;
    }
  }

  /// 甲子历直录没有公历生辰，取排盘时刻占位
  static DateTime _chartTime(BaziRecord record) =>
      record.isPillarInput ? DateTime.now() : record.toDateTime().toDateTime();

  /// 起盘入参原文：历史回看看到的就是这些字段，服务端不再二次推导
  static Map<String, dynamic> _queryParams(BaziRecord record) => {
        'name': record.name,
        'sex': record.sex,
        'ye_zi_shi': record.yeZiShi,
        'longitude': record.longitude,
        'pillars': record.pillars,
        'birth': {
          'year': record.year,
          'month': record.month,
          'day': record.day,
          'hour': record.hour,
          'minute': record.minute,
        },
      };

  /// 盘面快照：四柱、空亡、节气、大运、神煞、旺衰等结果页展示项
  static String _snapshot(ZYHourQimenHeadModel head) {
    final wangShuai = head.wangShuai;
    final chengGu = head.chengGu;
    return jsonEncode({
      'si_zhu': [head.yearGanzhi, head.monthGanzhi, head.dayGanzhi, head.hourGanzhi],
      'kong_wang': [head.yearEmpty, head.monthEmpty, head.dayEmpty, head.hourEmpty],
      'jie_qi': head.jieQi,
      'jie_qi_time': head.jieQiTime,
      'nong_li': head.nongli,
      'yang_li': head.yangLi,
      'tai_yuan': head.taiYuan,
      'ming_gong': head.mingGong,
      'shen_gong': head.shenGong,
      'ge_ju': head.geJu,
      'ren_yuan': head.renYuan,
      'wu_xing_count': head.wuXingCount,
      'chang_sheng': head.changShengArray,
      'shen_sha': head.shenShaArray,
      'shen_sha_summary': head.shenShaSummary,
      'qi_yun_time': head.qiYunTime,
      'jiao_yun_time': head.jiaoYunTime,
      'da_yun': head.daYun,
      'da_yun_time': head.daYunTime,
      if (wangShuai != null)
        'wang_shuai': {
          'day_element': wangShuai.dayElement,
          'level': wangShuai.level,
          'strong': wangShuai.strong,
          'xi_yong': wangShuai.xiYong,
          'ji_shen': wangShuai.jiShen,
        },
      if (chengGu != null) 'cheng_gu': {'label': chengGu.label, 'total_cents': chengGu.totalCents},
    });
  }
}
