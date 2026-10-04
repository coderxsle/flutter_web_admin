import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/zhongyi/zhongyi_action_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

void main() {
  const expectedPaths = <String>{
    '/api/lxs_zhongyi/medicine/list',
    '/api/lxs_zhongyi/medicine/options',
    '/api/lxs_zhongyi/medicine/detail/:id',
    '/api/lxs_zhongyi/medicine/create',
    '/api/lxs_zhongyi/medicine/update/:id',
    '/api/lxs_zhongyi/medicine/delete',
    '/api/lxs_zhongyi/medicine/:id/prices',
    '/api/lxs_zhongyi/inventory/list',
    '/api/lxs_zhongyi/inventory/detail/:id',
    '/api/lxs_zhongyi/inventory/stock-in',
    '/api/lxs_zhongyi/inventory/adjust',
    '/api/lxs_zhongyi/inventory/transaction/list',
    '/api/lxs_zhongyi/department/list',
    '/api/lxs_zhongyi/department/tree',
    '/api/lxs_zhongyi/department/detail/:id',
    '/api/lxs_zhongyi/department/create',
    '/api/lxs_zhongyi/department/update/:id',
    '/api/lxs_zhongyi/department/delete',
    '/api/lxs_zhongyi/staff/list',
    '/api/lxs_zhongyi/staff/detail/:id',
    '/api/lxs_zhongyi/staff/create',
    '/api/lxs_zhongyi/staff/update/:id',
    '/api/lxs_zhongyi/staff/delete',
    '/api/lxs_zhongyi/patient/list',
    '/api/lxs_zhongyi/patient/detail/:id',
    '/api/lxs_zhongyi/patient/create',
    '/api/lxs_zhongyi/patient/update/:id',
    '/api/lxs_zhongyi/patient/delete',
    '/api/lxs_zhongyi/prescription-template/list',
    '/api/lxs_zhongyi/prescription-template/detail/:id',
    '/api/lxs_zhongyi/prescription-template/create',
    '/api/lxs_zhongyi/prescription-template/update/:id',
    '/api/lxs_zhongyi/prescription-template/delete',
    '/api/lxs_zhongyi/prescription-template/:id/status',
    '/api/lxs_zhongyi/billing/create',
    '/api/lxs_zhongyi/billing/list',
    '/api/lxs_zhongyi/billing/detail/:id',
    '/api/lxs_zhongyi/billing/:id/pay',
    '/api/lxs_zhongyi/billing/:id/cancel',
    '/api/lxs_zhongyi/billing/:id/refund',
    '/api/lxs_zhongyi/billing/refund/:id/approve',
    '/api/lxs_zhongyi/billing/refund/:id/complete',
  };

  test('汇总并挂载所有中医后端接口，无路径冲突且必须鉴权', () {
    final routes = zhongyiActionRoutes();

    expect(routes.length, expectedPaths.length);
    expect(routes.keys.toSet(), expectedPaths);
    for (final entry in routes.entries) {
      expect(entry.key, startsWith('/api/lxs_zhongyi/'));
      expect(entry.value.requireAuth, isTrue, reason: entry.key);
      expect(entry.value.envelope, isA<ServerpodEnvelopeBuilder>(), reason: entry.key);
    }

    final app = RelicRouter();
    routes.forEach(app.injectAt);
    for (final entry in routes.entries) {
      final concretePath = entry.key.replaceAll(':id', '17');
      for (final method in entry.value.methods) {
        expect(app.lookupUri(method, Uri.parse(concretePath)), isA<RouterMatch>(), reason: '$method $concretePath');
      }
    }
  });
}
