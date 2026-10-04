import 'package:flutter_web_server/src/services/zhongyi/zhongyi_billing_service.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/billing_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

void main() {
  group('ZhongyiBillingService billing rules', () {
    test('allows a valid partial payment but rejects overpayment and cancelled bills', () {
      expect(ZhongyiBillingService.canPay(billStatus: 1, totalAmount: 100, paidAmount: 25, amount: 75), isTrue);
      expect(
        ZhongyiBillingService.canPay(billStatus: 1, totalAmount: 100, paidAmount: 25, amount: 75.01),
        isFalse,
      );
      expect(
        ZhongyiBillingService.canPay(billStatus: 0, totalAmount: 100, paidAmount: 0, amount: 10),
        isFalse,
      );
      expect(ZhongyiBillingService.canPay(billStatus: 1, totalAmount: 100, paidAmount: 0, amount: 0), isFalse);
    });

    test('derives unpaid, partial, paid, refunding, and refunded states', () {
      String derive({required double paid, double refunded = 0, double pendingRefund = 0}) =>
          ZhongyiBillingService.derivePaymentStatus(
            totalAmount: 100,
            paidAmount: paid,
            refundedAmount: refunded,
            pendingRefundAmount: pendingRefund,
          );

      expect(derive(paid: 0), 'unpaid');
      expect(derive(paid: 25), 'partially_paid');
      expect(derive(paid: 100), 'paid');
      expect(derive(paid: 100, pendingRefund: 20), 'refunding');
      expect(derive(paid: 100, refunded: 100), 'refunded');
    });

    test('refund availability excludes pending refunds and rejects invalid requests', () {
      expect(
        ZhongyiBillingService.availableRefundAmount(paidAmount: 80, refundedAmount: 10, pendingRefundAmount: 20),
        50,
      );
      expect(
        ZhongyiBillingService.canRequestRefund(
          billStatus: 1,
          paidAmount: 80,
          refundedAmount: 10,
          pendingRefundAmount: 20,
          amount: 50,
        ),
        isTrue,
      );
      expect(
        ZhongyiBillingService.canRequestRefund(
          billStatus: 1,
          paidAmount: 80,
          refundedAmount: 10,
          pendingRefundAmount: 20,
          amount: 50.01,
        ),
        isFalse,
      );
      expect(
        ZhongyiBillingService.canRequestRefund(
          billStatus: 0,
          paidAmount: 80,
          refundedAmount: 0,
          pendingRefundAmount: 0,
          amount: 10,
        ),
        isFalse,
      );
    });

    test('refund workflow only approves pending and completes approved refunds', () {
      expect(ZhongyiBillingService.canApproveRefund(ZhongyiBillingService.refundPending), isTrue);
      expect(ZhongyiBillingService.canApproveRefund(ZhongyiBillingService.refundApproved), isFalse);
      expect(ZhongyiBillingService.canCompleteRefund(ZhongyiBillingService.refundApproved), isTrue);
      expect(ZhongyiBillingService.canCompleteRefund(ZhongyiBillingService.refundPending), isFalse);
      expect(ZhongyiBillingService.canCompleteRefund(ZhongyiBillingService.refundCompleted), isFalse);
    });

    test('calculates billing line amounts from quantity and unit price', () {
      expect(ZhongyiBillingService.calculateLineAmount(quantity: 2, unitPrice: 12.34), 24.68);
      expect(ZhongyiBillingService.calculateLineAmount(quantity: 2.5, unitPrice: 12.34), isNull);
      expect(ZhongyiBillingService.calculateLineAmount(quantity: 0, unitPrice: 12.34), isNull);
    });

    test('projects a legacy bill and its items for the billing page', () {
      final bill = ZhongyiBill(
        id: 7,
        tenantId: 0,
        billNo: 'BIL202605300002',
        patientId: 1,
        billingStage: 'treatment',
        totalAmount: 24.68,
        paidAmount: 0,
        refundedAmount: 0,
        paymentStatus: 'unpaid',
        status: 1,
        notes: '测试备注',
      );
      final item = ZhongyiBillItem(
        id: 12,
        billId: 7,
        itemType: 'medicine',
        itemName: '药品',
        quantity: 2,
        unitPrice: 12.34,
        totalPrice: 24.68,
        referenceType: 'medicine',
        referenceId: 3,
      );

      final result = ZhongyiBillingService.billJson(bill, patientName: '患者甲', items: [item]);
      expect(result['patient_name'], '患者甲');
      expect(result['remark'], '测试备注');
      expect(result['items'], [
        {
          'id': 12,
          'bill_id': 7,
          'item_type': 'medicine',
          'item_name': '药品',
          'quantity': 2,
          'unit_price': 12.34,
          'amount': 24.68,
          'reference_type': 'medicine',
          'reference_id': 3,
          'specification': null,
          'unit': '次',
          'is_refunded': false,
          'refunded_quantity': 0,
        },
      ]);
    });
  });

  group('billing REST route contract', () {
    final routes = zhongyiBillingActionRoutes();

    test('exposes all billing actions at the frontend paths', () {
      expect(
        routes.keys,
        containsAll([
          '/api/lxs_zhongyi/billing/create',
          '/api/lxs_zhongyi/billing/list',
          '/api/lxs_zhongyi/billing/detail/:id',
          '/api/lxs_zhongyi/billing/:id/pay',
          '/api/lxs_zhongyi/billing/:id/cancel',
          '/api/lxs_zhongyi/billing/:id/refund',
          '/api/lxs_zhongyi/billing/refund/:id/approve',
          '/api/lxs_zhongyi/billing/refund/:id/complete',
        ]),
      );
    });

    test('requires authentication and uses the project response envelope', () {
      expect(routes.values, everyElement(predicate<ActionRoute>((route) => route.requireAuth)));
      expect(
        routes.values,
        everyElement(isA<ActionRoute>().having((route) => route.envelope, 'envelope', isA<ServerpodEnvelopeBuilder>())),
      );
    });

    test('uses only the expected HTTP methods', () {
      expect(routes['/api/lxs_zhongyi/billing/list']!.methods, {Method.get});
      expect(routes['/api/lxs_zhongyi/billing/create']!.methods, {Method.post});
      expect(routes['/api/lxs_zhongyi/billing/detail/:id']!.methods, {Method.get});
      expect(routes['/api/lxs_zhongyi/billing/:id/pay']!.methods, {Method.post});
      expect(routes['/api/lxs_zhongyi/billing/:id/cancel']!.methods, {Method.post});
      expect(routes['/api/lxs_zhongyi/billing/:id/refund']!.methods, {Method.post});
      expect(routes['/api/lxs_zhongyi/billing/refund/:id/approve']!.methods, {Method.post});
      expect(routes['/api/lxs_zhongyi/billing/refund/:id/complete']!.methods, {Method.post});
    });
  });
}
