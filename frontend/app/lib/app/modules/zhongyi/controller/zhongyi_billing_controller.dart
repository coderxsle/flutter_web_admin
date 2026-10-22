import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import '../../../routes/app_pages.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import 'zhongyi_list_controller.dart';

/// 结算记录列表：后端能按账单号 / 患者名过滤，页面只按患者名查。
class ZhongyiBillingController extends ZhongyiListController<ZhongyiBill> {
  @override
  String get emptyTip => hasQuery ? '没有该患者的结算记录' : '暂无结算记录';

  @override
  Future<ResponseAnalyzed> fetchPage(int page, String query) => ZhongyiRequest.billingList(
        page: page,
        pageSize: ZhongyiListController.pageSize,
        patientName: query.isEmpty ? null : query,
      );

  @override
  ZhongyiBill fromJson(Map<String, dynamic> json) => ZhongyiBill.fromJson(json);

  /// 删账单、收款都在详情页，回来重拉一次
  void open(ZhongyiBill bill) {
    Get.toNamed(Routes.ZHONGYIBILLINGDETAILPAGE, arguments: bill.id)?.then((_) => requestDataList());
  }
}
