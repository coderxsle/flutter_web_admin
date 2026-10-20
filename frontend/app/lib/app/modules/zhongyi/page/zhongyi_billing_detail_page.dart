import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_sheet.dart';
import '../widget/zhongyi_ui.dart';

/// 结算详情：账单/金额/明细/退款，底部按状态给出收款与取消账单。
class ZhongyiBillingDetailPage extends StatefulWidget {
  const ZhongyiBillingDetailPage({super.key});

  @override
  State<ZhongyiBillingDetailPage> createState() => _ZhongyiBillingDetailPageState();
}

class _ZhongyiBillingDetailPageState extends State<ZhongyiBillingDetailPage> {
  int _billId = 0;
  ZhongyiBill? _bill;
  bool _loading = true;
  bool _paying = false;
  bool _cancelling = false;
  bool _deleting = false;

  @override
  void initState() {
    super.initState();
    _billId = zyInt(Get.arguments) ?? 0;
    _load();
  }

  Future<void> _load() async {
    if (_billId <= 0) {
      setState(() => _loading = false);
      return;
    }
    setState(() => _loading = true);
    final response = await ZhongyiRequest.billingDetail(_billId);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _bill = response.success ? ZhongyiBill.fromJson(zyMap(response.data)) : null;
    });
    if (!response.success) showMessage(response.message ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('结算详情'),
        actions: [
          if (_bill != null)
            IconButton(
              tooltip: '删除',
              onPressed: _deleting ? null : () => _delete(_bill!),
              icon: const Icon(Icons.delete_outline, color: TdColors.white),
            ),
        ],
      ),
      body: _body(),
      bottomNavigationBar: _bill == null ? null : _footer(_bill!),
    );
  }

  Widget _body() {
    if (_loading) return const ZhongyiLoading();
    final bill = _bill;
    if (bill == null) return const ZhongyiEmpty(text: '未找到结算记录');

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _summaryCard(bill),
          _infoCard(bill),
          _amountCard(bill),
          _itemsCard(bill),
          _refundCard(bill),
        ],
      ),
    );
  }

  Widget _summaryCard(ZhongyiBill bill) {
    return ZhongyiCard(
      padding: EdgeInsets.all(16.w),
      divided: false,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(bill.patientLabel(), style: blackBoldStyle(font: 18.sp))),
            SizedBox(width: 8.w),
            Text('¥${zhongyiAmountText(bill.totalAmount)}', style: redThemeBoldStyle(font: 22.sp)),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            ZhongyiStatusTag(
              bill.cancelled ? '已取消' : zhongyiPaymentStatusText(bill.paymentStatus),
              colorPreset: bill.cancelled
                  ? TTagColorPreset.defaultTheme
                  : (bill.paymentStatus == 'paid' ? TTagColorPreset.success : TTagColorPreset.primary),
            ),
            const Spacer(),
            Text(
              bill.canPay
                  ? '待收 ¥${zhongyiAmountText(bill.payableAmount)}'
                  : '已收 ¥${zhongyiAmountText(bill.paidAmount)}',
              style: greyStyle(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoCard(ZhongyiBill bill) {
    return ZhongyiCard(
      title: '账单信息',
      children: [
        ZhongyiKeyValueRow(label: '账单号', value: bill.billNo),
        ZhongyiKeyValueRow(label: '收费阶段', value: zhongyiStageText(bill.billingStage)),
        ZhongyiKeyValueRow(label: '支付状态', value: zhongyiPaymentStatusText(bill.paymentStatus)),
        ZhongyiKeyValueRow(label: '账单状态', value: zhongyiBillStatusText(bill.status)),
        ZhongyiKeyValueRow(label: '创建时间', value: zyTimeText(bill.createTime)),
        ZhongyiKeyValueRow(label: '备注', value: zyText(bill.remark) ?? '-'),
      ],
    );
  }

  /// 金额：三格高亮 + 一行明细，与参考实现的层次一致。
  Widget _amountCard(ZhongyiBill bill) {
    return ZhongyiCard(
      title: '金额信息',
      padding: EdgeInsets.only(bottom: 12.h),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
          child: Row(
            children: [
              _amountTile('总金额', bill.totalAmount, TdColors.textPrimary),
              SizedBox(width: 8.w),
              _amountTile('已付金额', bill.paidAmount, const Color(0xFF16A34A)),
              SizedBox(width: 8.w),
              _amountTile('待收金额', bill.payableAmount, bill.payableAmount > 0 ? TdColors.brand : TdColors.grey153),
            ],
          ),
        ),
        if (bill.refundedAmount > 0)
          ZhongyiKeyValueRow(
              label: '已退金额',
              value: '¥${zhongyiAmountText(bill.refundedAmount)}',
              valueStyle: redThemeStyle()),
      ],
    );
  }

  Widget _amountTile(String label, double amount, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        decoration: BoxDecoration(color: TdColors.pageBg, borderRadius: BorderRadius.circular(8.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: greyStyle(font: 12.sp)),
            SizedBox(height: 5.h),
            Text('¥${zhongyiAmountText(amount)}',
                style: blackStyle().copyWith(fontWeight: FontWeight.w800, color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _itemsCard(ZhongyiBill bill) {
    return ZhongyiCard(
      title: '明细项目',
      trailing: Text('${bill.items.length} 项', style: greyStyle(font: 12.sp)),
      children: [
        if (bill.items.isEmpty)
          const ZhongyiEmpty(text: '暂无明细')
        else
          for (final item in bill.items)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(item.itemName,
                              style: blackBoldStyle(), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      SizedBox(width: 8.w),
                      Text('¥${zhongyiAmountText(item.amount)}', style: redThemeBoldStyle()),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    [
                      if (zyText(item.specification) != null) item.specification!,
                      '${item.quantity}${zyText(item.unit) ?? ''} x ¥${zhongyiAmountText(item.unitPrice)}',
                    ].join(' · '),
                    style: greyStyle(font: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
      ],
    );
  }

  Widget _refundCard(ZhongyiBill bill) {
    if (bill.refunds.isEmpty) return const SizedBox.shrink();
    return ZhongyiCard(
      title: '退款记录',
      trailing: Text('${bill.refunds.length} 笔', style: greyStyle(font: 12.sp)),
      children: [
        for (final refund in bill.refunds)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(refund.refundNo, style: blackBoldStyle())),
                    Text('¥${zhongyiAmountText(refund.refundAmount)}', style: redThemeBoldStyle()),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '${zhongyiRefundStatusText(refund.status)} · ${zyTimeText(refund.completedAt ?? refund.requestedAt)}',
                  style: greyStyle(font: 12.sp),
                ),
                if (zyText(refund.refundReason) != null) ...[
                  SizedBox(height: 3.h),
                  Text('原因：${refund.refundReason}',
                      style: greyStyle(font: 12.sp), maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ],
            ),
          ),
      ],
    );
  }

  /// 底栏：可收款时给收款，未收款时可作废整单。
  Widget _footer(ZhongyiBill bill) {
    if (!bill.canPay) {
      return Container(
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h + MediaQuery.paddingOf(context).bottom),
        color: TdColors.white,
        child: ZhongyiPrimaryButton(
            text: '返回列表', height: 44, variant: TButtonVariant.outline, onPressed: () => Get.back()),
      );
    }
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 8.h + MediaQuery.paddingOf(context).bottom),
      color: TdColors.white,
      child: Row(
        children: [
          if (bill.canCancel)
            Expanded(
              child: ZhongyiPrimaryButton(
                text: '取消账单',
                height: 44,
                variant: TButtonVariant.outline,
                loading: _cancelling,
                onPressed: () => _cancel(bill),
              ),
            ),
          if (bill.canCancel) SizedBox(width: 10.w),
          Expanded(
            child: ZhongyiPrimaryButton(
              text: '收款 ¥${zhongyiAmountText(bill.payableAmount)}',
              height: 44,
              loading: _paying,
              onPressed: () => _pay(bill),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pay(ZhongyiBill bill) async {
    final result = await showZhongyiPaySheet(context, amount: bill.payableAmount);
    if (result == null) return;
    setState(() => _paying = true);
    try {
      final response = await ZhongyiRequest.payBill(bill.id, channel: result.channel, amount: result.amount);
      showMessage(zyTextOr(response.message, response.success ? '收款成功' : '收款失败'));
      if (response.success) await _load();
    } finally {
      if (mounted) setState(() => _paying = false);
    }
  }

  /// 伪删除：仅打删除标记，列表页返回时自动重取，所以成功后直接回退。
  Future<void> _delete(ZhongyiBill bill) async {
    if (!bill.canDelete) {
      showMessage('已收款账单不能删除，请先退款处理');
      return;
    }
    showAlertDialog(
      title: '删除结算记录',
      message: '确定删除 ${bill.billNo} 吗？删除后不再出现在结算列表，历史数据仍保留在后台。',
      confirmText: '删除',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _deleting = true);
        final response = await ZhongyiRequest.deleteBills([bill.id]);
        if (!mounted) return;
        setState(() => _deleting = false);
        showMessage(zyTextOr(response.message, response.success ? '结算记录已删除' : '删除失败'));
        if (response.success) Get.back();
      },
    );
  }

  Future<void> _cancel(ZhongyiBill bill) async {
    showAlertDialog(
      title: '取消账单',
      message: '确定作废 ${bill.billNo} 吗？已收款的账单不能取消。',
      confirmText: '取消账单',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _cancelling = true);
        final response = await ZhongyiRequest.cancelBill(bill.id);
        if (!mounted) return;
        setState(() => _cancelling = false);
        showMessage(zyTextOr(response.message, response.success ? '账单已取消' : '取消失败'));
        if (response.success) await _load();
      },
    );
  }
}
