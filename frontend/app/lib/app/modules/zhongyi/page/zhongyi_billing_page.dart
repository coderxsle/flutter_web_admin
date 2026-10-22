import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../controller/zhongyi_billing_controller.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 结算记录列表：分页与刷新在 [ZhongyiBillingController]，这里只管渲染。
class ZhongyiBillingPage extends GetView<ZhongyiBillingController> {
  const ZhongyiBillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('结算记录'),
      ),
      body: Column(
        children: [
          _toolbar(),
          const SizedBox(height: 8),
          _body(context),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return ZhongyiSearchToolbar(
      search: ZhongyiSearchBar(
        hintText: '搜索患者姓名',
        controller: controller.keyword,
        onChanged: controller.onKeywordChanged,
        onSubmitted: controller.search,
        onClearPressed: controller.clearKeyword,
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(
      () => LayoutSubviews(
        state: controller.recode.value,
        controller: controller.refreshCtrl,
        onRefresh: controller.onRefresh,
        onLoad: controller.onLoad,
        emptyTip: controller.emptyTip,
        emptyActionText: '重新加载',
        emptyRetry: () => controller.requestDataList(showLoading: true),
        errorTip: '网络不太顺畅，稍后重试一次',
        onRetry: () => controller.requestDataList(showLoading: true),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
          itemCount: controller.items.length,
          separatorBuilder: (_, __) => SizedBox(height: 5.h),
          itemBuilder: (_, index) => _billCard(controller.items[index]),
        ),
      ),
    );
  }

  /// 卡片密度对齐药方模板列表：竖向内边距 9、两行之间 3，卡片间距 5。
  Widget _billCard(ZhongyiBill bill) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.open(bill),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(12.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(bill.patientLabel(),
                      style: blackBoldStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                SizedBox(width: 8.w),
                _paymentTag(bill),
              ],
            ),
            SizedBox(height: 3.h),
            // 账单号 / 时间 / 阶段合成一行灰字，长号与放大字号都不会把这一行撑破
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${bill.billNo} · ${zyTimeText(bill.createTime)} · ${zhongyiStageText(bill.billingStage)}',
                    style: greyStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Text('¥${zhongyiAmountText(bill.totalAmount)}', style: redThemeBoldStyle(font: 17.sp)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 支付状态胶囊：已付/退款走成功与灰，未付与部分付走品牌色提示待处理。
  Widget _paymentTag(ZhongyiBill bill) {
    if (bill.cancelled) return const ZhongyiStatusTag('已取消');
    final preset = switch (bill.paymentStatus) {
      'paid' => TTagColorPreset.success,
      'refunding' => TTagColorPreset.warning,
      'refunded' => TTagColorPreset.defaultTheme,
      _ => TTagColorPreset.primary,
    };
    return ZhongyiStatusTag(zhongyiPaymentStatusText(bill.paymentStatus), colorPreset: preset);
  }
}
