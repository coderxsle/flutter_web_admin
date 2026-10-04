import 'package:flutter_web_server/src/services/zhongyi/zhongyi_billing_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 收费管理 REST 路由。共享注册入口由模块装配处调用
/// [registerZhongyiBillingRoutes]。
void registerZhongyiBillingRoutes(Serverpod pod) {
  for (final entry in zhongyiBillingActionRoutes().entries) {
    pod.webServer.addRoute(entry.value, entry.key);
  }
}

Map<String, ActionRoute> zhongyiBillingActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/lxs_zhongyi/billing/create': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final patientId = _integerOrNull(body['patient_id'] ?? body['patientId']);
        final rawItems = body['items'];
        if (patientId == null || rawItems is! List) {
          throw const RestException.badRequest('患者和收费明细参数不合法');
        }
        final items = <Map<String, dynamic>>[];
        for (final rawItem in rawItems) {
          if (rawItem is! Map) {
            throw const RestException.badRequest('收费明细参数不合法');
          }
          items.add(Map<String, dynamic>.from(rawItem));
        }
        return ensureOk(
          await ZhongyiBillingService.createBill(
            session,
            patientId: patientId,
            billingStage: trimmedString(body['billing_stage'] ?? body['billingStage']) ?? '',
            items: items,
            remark: trimmedString(body['remark']),
          ),
        );
      },
    ),
    '/api/lxs_zhongyi/billing/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiBillingService.list(
          session,
          page: request.queryInt('page_no') ?? request.queryInt('page') ?? 1,
          pageSize: request.queryInt('page_size') ?? request.queryInt('pageSize') ?? 20,
          billNo: request.queryString('bill_no'),
          patientName: request.queryString('patient_name'),
        ),
      ),
    ),
    '/api/lxs_zhongyi/billing/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await ZhongyiBillingService.detail(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/billing/:id/pay': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final amount = _numberOrNull(body['amount']);
        if (amount == null) {
          throw const RestException.badRequest('amount 必须是有效金额');
        }
        return ensureOk(
          await ZhongyiBillingService.payBill(
            session,
            request.pathId(),
            channel: trimmedString(body['channel']) ?? '',
            amount: amount,
            transactionNo: trimmedString(body['transaction_no'] ?? body['transactionNo']),
          ),
        );
      },
    ),
    '/api/lxs_zhongyi/billing/:id/cancel': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await ZhongyiBillingService.cancelBill(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/billing/:id/refund': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final amount = _numberOrNull(body['amount']);
        if (amount == null) {
          throw const RestException.badRequest('amount 必须是有效金额');
        }
        return ensureOk(
          await ZhongyiBillingService.createRefund(
            session,
            request.pathId(),
            amount: amount,
            reason: trimmedString(body['reason']) ?? '',
          ),
        );
      },
    ),
    '/api/lxs_zhongyi/billing/refund/:id/approve': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiBillingService.approveRefund(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/billing/refund/:id/complete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiBillingService.completeRefund(session, request.pathId())),
    ),
  };
}

double? _numberOrNull(Object? value) {
  final parsed = switch (value) {
    final num number => number.toDouble(),
    final String text => double.tryParse(text.trim()),
    _ => null,
  };
  if (parsed == null || !parsed.isFinite) return null;
  return parsed;
}

int? _integerOrNull(Object? value) {
  final parsed = switch (value) {
    final int number => number,
    final num number when number.isFinite && number == number.roundToDouble() => number.toInt(),
    final String text => int.tryParse(text.trim()),
    _ => null,
  };
  if (parsed == null || parsed <= 0) return null;
  return parsed;
}
