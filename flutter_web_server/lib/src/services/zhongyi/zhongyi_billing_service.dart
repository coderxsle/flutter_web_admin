import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 中医门诊账单、收款及退款流程。
///
/// 患者姓名只用于账单响应；服务不把姓名、账单号、退款原因或其他患者资料
/// 写入应用日志。患者数据访问审计仅记录患者 ID、操作者 ID 和动作。
class ZhongyiBillingService {
  ZhongyiBillingService._();

  static const int _maxPageSize = 200;
  // 账单 status：0取消 1正常
  static const int billActive = 1;
  static const int billCancelled = 0;
  // 账单 paymentStatus：仍为字符串枚举
  static const String paymentUnpaid = 'unpaid';
  static const String paymentPartiallyPaid = 'partially_paid';
  static const String paymentPaid = 'paid';
  static const String paymentRefunding = 'refunding';
  static const String paymentRefunded = 'refunded';
  // 支付记录 status：0待支付 1已支付 2支付失败 3已退款
  static const int paymentRecordPending = 0;
  static const int paymentRecordPaid = 1;
  static const int paymentRecordFailed = 2;
  static const int paymentRecordRefunded = 3;
  // 退款 status：0待审批 1已批准 2已完成
  static const int refundPending = 0;
  static const int refundApproved = 1;
  static const int refundCompleted = 2;

  /// 项目租户解析规则：超管目标租户优先，否则取认证 scope 中的租户，缺省为 0。
  static int tenantIdOf(Session session) {
    final targetTenantId = session.targetTenantId;
    if (targetTenantId != null && targetTenantId > 0) return targetTenantId;
    return session.tenantId;
  }

  static String? _actorIdentifier(Session session) => session.authenticated?.userIdentifier;

  /// 将金额按分比较，避免 double 浮点误差影响收款/退款上限判定。
  static int _cents(double amount) {
    if (!amount.isFinite) return -1;
    return (amount * 100).round();
  }

  static double _amount(int cents) => cents / 100;

  static bool canPay({
    required int billStatus,
    required double totalAmount,
    required double paidAmount,
    required double amount,
  }) {
    final total = _cents(totalAmount);
    final paid = _cents(paidAmount);
    final payment = _cents(amount);
    if (billStatus != billActive || total < 0 || paid < 0 || payment <= 0 || total <= paid) {
      return false;
    }
    return payment <= total - paid;
  }

  static String derivePaymentStatus({
    required double totalAmount,
    required double paidAmount,
    required double refundedAmount,
    double pendingRefundAmount = 0,
  }) {
    final total = _cents(totalAmount);
    final paid = _cents(paidAmount);
    final refunded = _cents(refundedAmount);
    final pending = _cents(pendingRefundAmount);

    if (paid > 0 && refunded >= paid) return paymentRefunded;
    if (pending > 0) return paymentRefunding;
    if (paid <= 0) return paymentUnpaid;
    if (total > 0 && paid < total) return paymentPartiallyPaid;
    return paymentPaid;
  }

  static double availableRefundAmount({
    required double paidAmount,
    required double refundedAmount,
    required double pendingRefundAmount,
  }) {
    final paid = _cents(paidAmount);
    final refunded = _cents(refundedAmount);
    final pending = _cents(pendingRefundAmount);
    if (paid < 0 || refunded < 0 || pending < 0) return 0;
    return _amount((paid - refunded - pending).clamp(0, paid));
  }

  static bool canRequestRefund({
    required int billStatus,
    required double paidAmount,
    required double refundedAmount,
    required double pendingRefundAmount,
    required double amount,
  }) {
    if (billStatus != billActive || _cents(amount) <= 0) return false;
    final available = _cents(
      availableRefundAmount(
        paidAmount: paidAmount,
        refundedAmount: refundedAmount,
        pendingRefundAmount: pendingRefundAmount,
      ),
    );
    return available > 0 && _cents(amount) <= available;
  }

  static bool canApproveRefund(int status) => status == refundPending;

  static bool canCompleteRefund(int status) => status == refundApproved;

  /// 按服务端收到的整数数量和单价计算明细金额，统一按分四舍五入。
  static double? calculateLineAmount({required double quantity, required double unitPrice}) {
    if (!quantity.isFinite ||
        quantity <= 0 ||
        quantity != quantity.roundToDouble() ||
        !unitPrice.isFinite ||
        unitPrice < 0) {
      return null;
    }
    return _amount((quantity * unitPrice * 100).round());
  }

  /// 创建账单时忽略客户端传入的行金额和总金额，按明细数量×单价重算。
  static Future<CommonResponse> createBill(
    Session session, {
    required int patientId,
    required String billingStage,
    required List<Map<String, dynamic>> items,
    String? remark,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    final normalizedStage = _trimmedOrNull(billingStage);
    if (patientId <= 0 || normalizedStage == null || items.isEmpty) {
      return CommonResponse.validateFailed('患者、收费阶段和收费明细不能为空');
    }

    final normalizedItems = <Map<String, dynamic>>[];
    var totalCents = 0;
    for (final source in items) {
      final itemType = _trimmedOrNull(_stringValue(source, 'item_type', 'itemType'));
      final itemName = _trimmedOrNull(_stringValue(source, 'item_name', 'itemName'));
      final quantity = _integerValue(source, 'quantity');
      final unitPrice = _numberValue(source, 'unit_price', 'unitPrice');
      if (itemType == null || itemName == null || quantity == null || unitPrice == null) {
        return CommonResponse.validateFailed('收费明细参数不完整');
      }

      final lineAmount = calculateLineAmount(quantity: quantity.toDouble(), unitPrice: unitPrice);
      if (lineAmount == null) {
        return CommonResponse.validateFailed('收费明细数量或单价不合法');
      }
      final amountCents = _cents(lineAmount);
      totalCents += amountCents;

      final relationType = _trimmedOrNull(_stringValue(source, 'relation_type', 'relationType'));
      final relationId = _intValue(source, 'relation_id', 'relationId');
      if ((relationType == null) != (relationId == null) || (relationId != null && relationId <= 0)) {
        return CommonResponse.validateFailed('收费明细关联信息不合法');
      }

      normalizedItems.add({
        'item_type': itemType,
        'item_name': itemName,
        'quantity': quantity,
        'unit_price': _amount(_cents(unitPrice)),
        'amount': _amount(amountCents),
        'relation_type': relationType,
        'relation_id': relationId,
        'specification': _trimmedOrNull(_stringValue(source, 'specification')),
        'unit': _trimmedOrNull(_stringValue(source, 'unit')),
      });
    }
    if (totalCents <= 0) {
      return CommonResponse.validateFailed('账单总金额必须大于 0');
    }

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();
    try {
      return await session.db.transaction((transaction) async {
        final patient = await ZhongyiPatient.db.findFirstRow(
          session,
          where: (table) => table.id.equals(patientId) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
          transaction: transaction,
        );
        if (patient == null) {
          return CommonResponse.validateFailed('患者不存在');
        }
        for (final item in normalizedItems) {
          if (item['relation_type'] != 'medicine') continue;
          final relationId = item['relation_id'] as int;
          final medicine = await ZhongyiMedicine.db.findFirstRow(
            session,
            where: (table) =>
                table.id.equals(relationId) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
            transaction: transaction,
          );
          if (medicine == null) {
            return CommonResponse.validateFailed('收费明细关联药品不存在');
          }
        }

        final billNo = await _newBillNumber(session, tenantId, now, transaction);
        final bill = await ZhongyiBill.db.insertRow(
          session,
          ZhongyiBill(
            tenantId: tenantId,
            billNo: billNo,
            patientId: patientId,
            billingStage: normalizedStage,
            totalAmount: _amount(totalCents),
            paidAmount: 0,
            refundedAmount: 0,
            paymentStatus: paymentUnpaid,
            status: billActive,
            notes: _trimmedOrNull(remark),
            creator: actorIdentifier,
            updater: actorIdentifier,
            createTime: now,
            updateTime: now,
          ),
          transaction: transaction,
        );

        final billItems = normalizedItems
            .map(
              (item) => ZhongyiBillItem(
                billId: bill.id!,
                itemType: item['item_type'] as String,
                itemName: item['item_name'] as String,
                quantity: item['quantity'] as int,
                unitPrice: item['unit_price'] as double,
                totalPrice: item['amount'] as double,
                referenceType: item['relation_type'] as String?,
                referenceId: item['relation_id'] as int?,
                specification: item['specification'] as String?,
                unit: item['unit'] as String? ?? '次',
                creator: actorIdentifier,
                updater: actorIdentifier,
                createTime: now,
                updateTime: now,
              ),
            )
            .toList();
        final insertedBillItems = await ZhongyiBillItem.db.insert(session, billItems, transaction: transaction);

        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: patientId,
          action: 'billing_create',
          transaction: transaction,
        );
        return CommonResponse.success(billJson(bill, patientName: patient.name, items: insertedBillItems), '账单创建成功');
      });
    } catch (_) {
      return CommonResponse.failed('创建收费账单失败');
    }
  }

  /// 账单分页查询，列表返回账单主表与明细子表。
  static Future<PageResponse<Map<String, dynamic>>> list(
    Session session, {
    int page = 1,
    int pageSize = 20,
    String? billNo,
    String? patientName,
  }) async {
    if (session.authenticated == null) return PageResponse.failed('未登录');

    final tenantId = tenantIdOf(session);
    final safePage = page < 1 ? 1 : page;
    final safePageSize = pageSize.clamp(1, _maxPageSize);
    final normalizedBillNo = _trimmedOrNull(billNo);
    final normalizedPatientName = _trimmedOrNull(patientName);

    try {
      final matchingPatients = normalizedPatientName == null
          ? <ZhongyiPatient>[]
          : await ZhongyiPatient.db.find(
              session,
              where: (table) =>
                  table.tenantId.equals(tenantId) &
                  table.deleted.equals(false) &
                  table.name.like('%$normalizedPatientName%'),
            );
      final patientIds = matchingPatients.map((patient) => patient.id!).toSet();
      if (normalizedPatientName != null && patientIds.isEmpty) {
        return PageResponse<Map<String, dynamic>>.restPage(
          data: const [],
          page: safePage,
          pageSize: safePageSize,
          total: 0,
        );
      }

      Expression where(ZhongyiBillTable table) {
        var filter = table.tenantId.equals(tenantId) & table.deleted.equals(false);
        if (normalizedBillNo != null) filter = filter & table.billNo.equals(normalizedBillNo);
        if (normalizedPatientName != null) filter = filter & table.patientId.inSet(patientIds);
        return filter;
      }

      final rows = await ZhongyiBill.db.find(
        session,
        where: where,
        limit: safePageSize,
        offset: (safePage - 1) * safePageSize,
        orderBy: (table) => table.createTime.desc(),
      );
      final total = await ZhongyiBill.db.count(session, where: where);
      final rowIds = rows.map((row) => row.id!).toSet();
      final items = rowIds.isEmpty
          ? <ZhongyiBillItem>[]
          : await ZhongyiBillItem.db.find(
              session,
              where: (table) => table.billId.inSet(rowIds) & table.deleted.equals(false),
              orderBy: (table) => table.id,
            );
      final pagePatientIds = rows.map((row) => row.patientId).toSet();
      final pagePatients = pagePatientIds.isEmpty
          ? <ZhongyiPatient>[]
          : await ZhongyiPatient.db.find(
              session,
              where: (table) => table.id.inSet(pagePatientIds) & table.tenantId.equals(tenantId),
            );
      final patientsById = {for (final patient in pagePatients) patient.id!: patient.name};
      final itemsByBillId = <int, List<ZhongyiBillItem>>{};
      for (final item in items) {
        itemsByBillId.putIfAbsent(item.billId, () => []).add(item);
      }

      await _recordPatientAccessForBills(session, tenantId, rows, 'billing_list');

      return PageResponse<Map<String, dynamic>>.restPage(
        data: rows
            .map(
              (bill) => billJson(
                bill,
                patientName: patientsById[bill.patientId],
                items: itemsByBillId[bill.id] ?? const [],
              ),
            )
            .toList(),
        page: safePage,
        pageSize: safePageSize,
        total: total,
      );
    } catch (_) {
      return PageResponse.failed('查询收费账单失败');
    }
  }

  /// 返回单条账单及其退款记录。患者访问审计只写患者 ID 与动作。
  static Future<CommonResponse> detail(Session session, int id) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('账单 ID 不合法');

    try {
      final tenantId = tenantIdOf(session);
      final bill = await _findBill(session, id, tenantId);
      if (bill == null) return CommonResponse.validateFailed('账单不存在');
      final patient = await ZhongyiPatient.db.findFirstRow(
        session,
        where: (table) => table.id.equals(bill.patientId) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
      );

      final refunds = await ZhongyiRefund.db.find(
        session,
        where: (table) => table.billingId.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        orderBy: (table) => table.requestedAt.desc(),
      );
      final items = await ZhongyiBillItem.db.find(
        session,
        where: (table) => table.billId.equals(id) & table.deleted.equals(false),
        orderBy: (table) => table.id,
      );

      await _recordPatientAccess(session, tenantId: tenantId, patientId: bill.patientId, action: 'billing_detail');

      return CommonResponse.success({
        ...billJson(bill, patientName: patient?.name, items: items),
        'refunds': refunds.map(_refundJson).toList(),
      });
    } catch (_) {
      return CommonResponse.failed('获取账单详情失败');
    }
  }

  /// 登记一笔收款并在同一事务中更新账单累计金额/状态。
  static Future<CommonResponse> payBill(
    Session session,
    int billId, {
    required String channel,
    required double amount,
    String? transactionNo,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (billId <= 0 || _trimmedOrNull(channel) == null) {
      return CommonResponse.validateFailed('账单和支付方式不能为空');
    }
    if (_cents(amount) <= 0) {
      return CommonResponse.validateFailed('收款金额必须大于 0');
    }

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();

    try {
      final actorId = await _resolveActorId(session, tenantId);
      return await session.db.transaction((transaction) async {
        await _lockBill(session, billId, tenantId, transaction);
        final bill = await _findBill(session, billId, tenantId, transaction: transaction);
        if (bill == null) return CommonResponse.validateFailed('账单不存在');
        if (!canPay(
          billStatus: bill.status,
          totalAmount: bill.totalAmount,
          paidAmount: bill.paidAmount,
          amount: amount,
        )) {
          return CommonResponse.validateFailed('账单状态不允许收款或金额超过待收金额');
        }

        final reference = _trimmedOrNull(transactionNo) ?? _paymentReference(tenantId, billId, now);
        final duplicateReference = await ZhongyiPayment.db.findFirstRow(
          session,
          where: (table) =>
              table.tenantId.equals(tenantId) & table.transactionNo.equals(reference) & table.deleted.equals(false),
          transaction: transaction,
        );
        if (duplicateReference != null) {
          return CommonResponse.validateFailed('交易流水号已存在');
        }

        final paidCents = _cents(bill.paidAmount) + _cents(amount);
        final payment = await ZhongyiPayment.db.insertRow(
          session,
          ZhongyiPayment(
            tenantId: tenantId,
            billingId: billId,
            channel: _trimmedOrNull(channel)!,
            amount: _amount(_cents(amount)),
            transactionNo: reference,
            status: paymentRecordPaid,
            paidAt: now,
            operatorId: actorId,
            creator: actorIdentifier,
            updater: actorIdentifier,
            createTime: now,
            updateTime: now,
          ),
          transaction: transaction,
        );

        final pendingRefundAmount = await _pendingRefundAmount(session, billId, tenantId, transaction: transaction);
        bill
          ..paidAmount = _amount(paidCents)
          ..paymentStatus = derivePaymentStatus(
            totalAmount: bill.totalAmount,
            paidAmount: _amount(paidCents),
            refundedAmount: bill.refundedAmount,
            pendingRefundAmount: pendingRefundAmount,
          )
          ..updater = actorIdentifier
          ..updateTime = now;
        if (bill.paidAmount == bill.totalAmount) bill.paidAt = now;
        await ZhongyiBill.db.updateRow(session, bill, transaction: transaction);
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: bill.patientId,
          action: 'billing_pay',
          actorId: actorId,
          transaction: transaction,
        );

        return CommonResponse.success({'payment': _paymentJson(payment), 'billing': billJson(bill)}, '收款成功');
      });
    } catch (_) {
      return CommonResponse.failed('登记收款失败');
    }
  }

  /// 仅未支付且仍有效的账单可取消。
  static Future<CommonResponse> cancelBill(Session session, int billId) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (billId <= 0) return CommonResponse.validateFailed('账单 ID 不合法');

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();
    try {
      return await session.db.transaction((transaction) async {
        await _lockBill(session, billId, tenantId, transaction);
        final bill = await _findBill(session, billId, tenantId, transaction: transaction);
        if (bill == null) return CommonResponse.validateFailed('账单不存在');
        if (bill.status != billActive || bill.paymentStatus != paymentUnpaid || _cents(bill.paidAmount) != 0) {
          return CommonResponse.validateFailed('仅未支付账单可以取消');
        }

        bill
          ..status = billCancelled
          ..updater = actorIdentifier
          ..updateTime = now;
        await ZhongyiBill.db.updateRow(session, bill, transaction: transaction);
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: bill.patientId,
          action: 'billing_cancel',
          transaction: transaction,
        );
        return CommonResponse.success(billJson(bill), '账单已取消');
      });
    } catch (_) {
      return CommonResponse.failed('取消账单失败');
    }
  }

  /// 发起退款申请。待审批/已审批申请会先占用可退款余额，避免超额重复申请。
  static Future<CommonResponse> createRefund(
    Session session,
    int billId, {
    required double amount,
    required String reason,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    final normalizedReason = _trimmedOrNull(reason);
    if (billId <= 0 || normalizedReason == null) {
      return CommonResponse.validateFailed('账单 ID 和退款原因不能为空');
    }
    if (_cents(amount) <= 0) {
      return CommonResponse.validateFailed('退款金额必须大于 0');
    }

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();
    try {
      final actorId = await _resolveActorId(session, tenantId);
      return await session.db.transaction((transaction) async {
        await _lockBill(session, billId, tenantId, transaction);
        final bill = await _findBill(session, billId, tenantId, transaction: transaction);
        if (bill == null) return CommonResponse.validateFailed('账单不存在');

        final pendingAmount = await _pendingRefundAmount(session, billId, tenantId, transaction: transaction);
        if (!canRequestRefund(
          billStatus: bill.status,
          paidAmount: bill.paidAmount,
          refundedAmount: bill.refundedAmount,
          pendingRefundAmount: pendingAmount,
          amount: amount,
        )) {
          return CommonResponse.validateFailed('退款金额超过可退金额或账单状态不允许退款');
        }

        final refundNo = await _newRefundNumber(session, tenantId, billId, now, transaction);
        final refund = await ZhongyiRefund.db.insertRow(
          session,
          ZhongyiRefund(
            tenantId: tenantId,
            billingId: billId,
            refundNo: refundNo,
            refundAmount: _amount(_cents(amount)),
            refundReason: normalizedReason,
            status: refundPending,
            requestedBy: actorId,
            requestedAt: now,
            creator: actorIdentifier,
            updater: actorIdentifier,
            createTime: now,
            updateTime: now,
          ),
          transaction: transaction,
        );

        bill
          ..paymentStatus = paymentRefunding
          ..updater = actorIdentifier
          ..updateTime = now;
        await ZhongyiBill.db.updateRow(session, bill, transaction: transaction);
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: bill.patientId,
          action: 'billing_refund_request',
          actorId: actorId,
          transaction: transaction,
        );
        return CommonResponse.success(_refundJson(refund), '退款申请已提交');
      });
    } catch (_) {
      return CommonResponse.failed('提交退款申请失败');
    }
  }

  /// 退款单只允许从 pending 进入 approved。
  static Future<CommonResponse> approveRefund(Session session, int refundId) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (refundId <= 0) return CommonResponse.validateFailed('退款 ID 不合法');

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();
    try {
      final actorId = await _resolveActorId(session, tenantId);
      return await session.db.transaction((transaction) async {
        final refund = await _findRefund(session, refundId, tenantId, transaction: transaction, lock: true);
        if (refund == null) return CommonResponse.validateFailed('退款记录不存在');
        if (!canApproveRefund(refund.status)) {
          return CommonResponse.validateFailed('只有待审批的退款申请可以审批');
        }
        await _lockBill(session, refund.billingId, tenantId, transaction);
        final bill = await _findBill(session, refund.billingId, tenantId, transaction: transaction);
        if (bill == null) return CommonResponse.validateFailed('账单不存在');

        refund
          ..status = refundApproved
          ..approvedBy = actorId
          ..approvedAt = now
          ..updater = actorIdentifier
          ..updateTime = now;
        final updated = await ZhongyiRefund.db.updateRow(session, refund, transaction: transaction);
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: bill.patientId,
          action: 'billing_refund_approve',
          actorId: actorId,
          transaction: transaction,
        );
        return CommonResponse.success(_refundJson(updated), '退款审批通过');
      });
    } catch (_) {
      return CommonResponse.failed('审批退款失败');
    }
  }

  /// 完成退款时同步更新退款单、账单累计退款金额和支付状态。
  static Future<CommonResponse> completeRefund(Session session, int refundId) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (refundId <= 0) return CommonResponse.validateFailed('退款 ID 不合法');

    final tenantId = tenantIdOf(session);
    final actorIdentifier = _actorIdentifier(session);
    final now = DateTime.now().toUtc();
    try {
      final actorId = await _resolveActorId(session, tenantId);
      return await session.db.transaction((transaction) async {
        final refund = await _findRefund(session, refundId, tenantId, transaction: transaction, lock: true);
        if (refund == null) return CommonResponse.validateFailed('退款记录不存在');
        if (!canCompleteRefund(refund.status)) {
          return CommonResponse.validateFailed('只有已审批的退款申请可以完成');
        }
        await _lockBill(session, refund.billingId, tenantId, transaction);
        final bill = await _findBill(session, refund.billingId, tenantId, transaction: transaction);
        if (bill == null) return CommonResponse.validateFailed('账单不存在');

        final updatedRefundCents = _cents(bill.refundedAmount) + _cents(refund.refundAmount);
        if (updatedRefundCents > _cents(bill.paidAmount)) {
          return CommonResponse.validateFailed('累计退款金额不能超过已收金额');
        }
        refund
          ..status = refundCompleted
          ..completedBy = actorId
          ..completedAt = now
          ..updater = actorIdentifier
          ..updateTime = now;
        final updatedRefund = await ZhongyiRefund.db.updateRow(session, refund, transaction: transaction);

        bill
          ..refundedAmount = _amount(updatedRefundCents)
          ..updater = actorIdentifier
          ..updateTime = now;
        final pendingAmount = await _pendingRefundAmount(
          session,
          bill.id!,
          tenantId,
          transaction: transaction,
          excludeRefundId: refundId,
        );
        bill.paymentStatus = derivePaymentStatus(
          totalAmount: bill.totalAmount,
          paidAmount: bill.paidAmount,
          refundedAmount: bill.refundedAmount,
          pendingRefundAmount: pendingAmount,
        );
        await ZhongyiBill.db.updateRow(session, bill, transaction: transaction);
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: bill.patientId,
          action: 'billing_refund_complete',
          actorId: actorId,
          transaction: transaction,
        );
        return CommonResponse.success({'refund': _refundJson(updatedRefund), 'billing': billJson(bill)}, '退款已完成');
      });
    } catch (_) {
      return CommonResponse.failed('完成退款失败');
    }
  }

  static String? _trimmedOrNull(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return normalized;
  }

  static Future<ZhongyiBill?> _findBill(Session session, int id, int tenantId, {Transaction? transaction}) =>
      ZhongyiBill.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );

  static Future<void> _lockBill(Session session, int id, int tenantId, Transaction transaction) =>
      ZhongyiBill.db.lockRows(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      );

  static Future<ZhongyiRefund?> _findRefund(
    Session session,
    int id,
    int tenantId, {
    required Transaction transaction,
    bool lock = false,
  }) {
    if (lock) {
      return ZhongyiRefund.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
      );
    }
    return ZhongyiRefund.db.findFirstRow(
      session,
      where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
      transaction: transaction,
    );
  }

  static Future<int?> _resolveActorId(Session session, int tenantId, {Transaction? transaction}) async {
    final auth = session.authenticated;
    if (auth == null) return null;
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) =>
          table.authUserId.equals(auth.authUserId) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
      transaction: transaction,
    );
    return user?.id ?? int.tryParse(auth.userIdentifier);
  }

  static Future<double> _pendingRefundAmount(
    Session session,
    int billId,
    int tenantId, {
    required Transaction transaction,
    int? excludeRefundId,
  }) async {
    final rows = await ZhongyiRefund.db.find(
      session,
      where: (table) {
        var filter =
            table.billingId.equals(billId) &
            table.tenantId.equals(tenantId) &
            table.deleted.equals(false) &
            ((table.status.equals(refundPending)) | table.status.equals(refundApproved));
        if (excludeRefundId != null) {
          filter = filter & table.id.notEquals(excludeRefundId);
        }
        return filter;
      },
      transaction: transaction,
    );
    final cents = rows.fold<int>(0, (sum, refund) => sum + _cents(refund.refundAmount));
    return _amount(cents);
  }

  static Future<String> _newRefundNumber(
    Session session,
    int tenantId,
    int billId,
    DateTime now,
    Transaction transaction,
  ) async {
    for (var attempt = 0; attempt < 5; attempt++) {
      final reference = 'RF-$tenantId-$billId-${now.microsecondsSinceEpoch + attempt}';
      final existing = await ZhongyiRefund.db.findFirstRow(
        session,
        where: (table) => table.tenantId.equals(tenantId) & table.refundNo.equals(reference),
        transaction: transaction,
      );
      if (existing == null) return reference;
    }
    throw StateError('Unable to allocate unique refund reference');
  }

  static Future<String> _newBillNumber(Session session, int tenantId, DateTime now, Transaction transaction) async {
    for (var attempt = 0; attempt < 5; attempt++) {
      final reference = 'BL-$tenantId-${now.microsecondsSinceEpoch + attempt}';
      final existing = await ZhongyiBill.db.findFirstRow(
        session,
        where: (table) => table.billNo.equals(reference),
        transaction: transaction,
      );
      if (existing == null) return reference;
    }
    throw StateError('Unable to allocate unique bill reference');
  }

  static String? _stringValue(Map<String, dynamic> source, String key, [String? camelCaseKey]) {
    final value = source[key] ?? (camelCaseKey == null ? null : source[camelCaseKey]);
    if (value == null) return null;
    return value.toString();
  }

  static double? _numberValue(Map<String, dynamic> source, String key, [String? camelCaseKey]) {
    final value = source[key] ?? (camelCaseKey == null ? null : source[camelCaseKey]);
    final parsed = switch (value) {
      final num number => number.toDouble(),
      final String text => double.tryParse(text.trim()),
      _ => null,
    };
    if (parsed == null || !parsed.isFinite) return null;
    return parsed;
  }

  static int? _intValue(Map<String, dynamic> source, String key, [String? camelCaseKey]) {
    final value = source[key] ?? (camelCaseKey == null ? null : source[camelCaseKey]);
    return switch (value) {
      final int number => number,
      final num number when number.isFinite && number == number.roundToDouble() => number.toInt(),
      final String text => int.tryParse(text.trim()),
      _ => null,
    };
  }

  static int? _integerValue(Map<String, dynamic> source, String key) {
    final parsed = _numberValue(source, key);
    if (parsed == null || parsed <= 0 || parsed != parsed.roundToDouble()) return null;
    return parsed.toInt();
  }

  static String _paymentReference(int tenantId, int billId, DateTime now) =>
      'PAY-$tenantId-$billId-${now.microsecondsSinceEpoch}';

  static Future<void> _recordPatientAccessForBills(
    Session session,
    int tenantId,
    List<ZhongyiBill> bills,
    String action,
  ) async {
    final patientIds = bills.map((bill) => bill.patientId).toSet();
    if (patientIds.isEmpty) return;
    await session.db.transaction((transaction) async {
      final actorId = await _resolveActorId(session, tenantId, transaction: transaction);
      for (final patientId in patientIds) {
        await _recordPatientAccess(
          session,
          tenantId: tenantId,
          patientId: patientId,
          action: action,
          actorId: actorId,
          transaction: transaction,
        );
      }
    });
  }

  static Future<void> _recordPatientAccess(
    Session session, {
    required int tenantId,
    required int patientId,
    required String action,
    int? actorId,
    Transaction? transaction,
  }) async {
    final resolvedActorId = actorId ?? await _resolveActorId(session, tenantId, transaction: transaction);
    await ZhongyiPatientAccessLog.db.insertRow(
      session,
      ZhongyiPatientAccessLog(
        tenantId: tenantId,
        patientId: patientId,
        action: action,
        actorId: resolvedActorId,
        accessTime: DateTime.now().toUtc(),
      ),
      transaction: transaction,
    );
  }

  static Map<String, dynamic> billJson(
    ZhongyiBill bill, {
    String? patientName,
    List<ZhongyiBillItem> items = const [],
  }) => {
    'id': bill.id,
    'bill_no': bill.billNo,
    'patient_id': bill.patientId,
    'patient_name': patientName,
    'billing_stage': bill.billingStage,
    'total_amount': bill.totalAmount,
    'paid_amount': bill.paidAmount,
    'refunded_amount': bill.refundedAmount,
    'payment_status': bill.paymentStatus,
    'status': bill.status,
    if (bill.notes != null) 'remark': bill.notes,
    'create_time': bill.createTime,
    'update_time': bill.updateTime,
    'items': items.map(_billingItemJson).toList(),
  };

  static Map<String, dynamic> _billingItemJson(ZhongyiBillItem item) => {
    'id': item.id,
    'bill_id': item.billId,
    'item_type': item.itemType,
    'item_name': item.itemName,
    'quantity': item.quantity,
    'unit_price': item.unitPrice,
    'amount': item.totalPrice,
    'reference_type': item.referenceType,
    'reference_id': item.referenceId,
    'specification': item.specification,
    'unit': item.unit,
    'is_refunded': item.isRefunded,
    'refunded_quantity': item.refundedQuantity,
  };

  static Map<String, dynamic> _paymentJson(ZhongyiPayment payment) => {
    'id': payment.id,
    'billing_id': payment.billingId,
    'channel': payment.channel,
    'amount': payment.amount,
    'transaction_no': payment.transactionNo,
    'status': payment.status,
    'paid_at': payment.paidAt,
    'operator_id': payment.operatorId,
  };

  static Map<String, dynamic> _refundJson(ZhongyiRefund refund) => {
    'id': refund.id,
    'billing_id': refund.billingId,
    'refund_no': refund.refundNo,
    'refund_amount': refund.refundAmount,
    'refund_reason': refund.refundReason,
    'status': refund.status,
    'requested_by': refund.requestedBy,
    'approved_by': refund.approvedBy,
    'completed_by': refund.completedBy,
    'requested_at': refund.requestedAt,
    'approved_at': refund.approvedAt,
    'completed_at': refund.completedAt,
  };
}
