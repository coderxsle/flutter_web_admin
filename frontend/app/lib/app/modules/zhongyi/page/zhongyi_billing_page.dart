import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 结算记录列表：账单号 / 时间 / 支付状态 + 患者 / 阶段 / 金额。
///
/// 后端 billing/list 只支持按账单号与患者名查询，没有阶段与状态过滤，
/// 这里沿用参考实现的做法——进页面取最近 50 条，下拉刷新重取。
class ZhongyiBillingPage extends StatefulWidget {
  const ZhongyiBillingPage({super.key});

  @override
  State<ZhongyiBillingPage> createState() => _ZhongyiBillingPageState();
}

class _ZhongyiBillingPageState extends State<ZhongyiBillingPage> {
  static const int _pageSize = 50;

  List<ZhongyiBill> _bills = const [];
  String _patientName = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({bool showLoading = true}) async {
    if (showLoading) setState(() => _loading = true);
    final response = await ZhongyiRequest.billingList(pageNo: 1, pageSize: _pageSize, patientName: _patientName);
    if (!mounted) return;
    if (!response.success) {
      setState(() => _loading = false);
      showMessage(response.message ?? '');
      return;
    }
    final page = ZhongyiPage.from<ZhongyiBill>(zyMap(response.data), ZhongyiBill.fromJson);
    setState(() {
      _bills = page.items;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('结算记录'),
        actions: [
          IconButton(
              onPressed: () => _load(showLoading: false), icon: const Icon(Icons.refresh, color: TdColors.white)),
        ],
      ),
      body: Column(
        children: [
          _toolbar(),
          const SizedBox(height: 8),
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return ZhongyiSearchToolbar(
      search: ZhongyiSearchBar(
        hintText: '搜索患者姓名',
        onSubmitted: (value) {
          _patientName = value.trim();
          _load();
        },
        onClearPressed: () {
          _patientName = '';
          _load();
        },
      ),
    );
  }

  Widget _body() {
    if (_loading) return const ZhongyiLoading();
    if (_bills.isEmpty) {
      return ZhongyiEmpty(text: _patientName.isEmpty ? '暂无结算记录' : '没有该患者的结算记录');
    }
    return RefreshIndicator(
      color: TdColors.brand,
      onRefresh: () => _load(showLoading: false),
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
        itemCount: _bills.length,
        separatorBuilder: (_, __) => SizedBox(height: 5.h),
        itemBuilder: (context, index) => _billCard(_bills[index]),
      ),
    );
  }

  /// 卡片密度对齐药方模板列表：竖向内边距 9、两行之间 3，卡片间距 5。
  Widget _billCard(ZhongyiBill bill) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () =>
          Get.toNamed(Routes.ZHONGYIBILLINGDETAILPAGE, arguments: bill.id)?.then((_) => _load(showLoading: false)),
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
            // 账单号 / 时间 / 阶段合成一行灰字，长号与放大字号都不会把这一行撑破。
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
